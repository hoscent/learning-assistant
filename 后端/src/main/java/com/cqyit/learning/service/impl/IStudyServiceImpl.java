package com.cqyit.learning.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqyit.learning.common.utils.FormatUtil;
import com.cqyit.learning.dao.StudyDao;
import com.cqyit.learning.pojo.Charts;
import com.cqyit.learning.pojo.Study;
import com.cqyit.learning.pojo.StudyRecord;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.IStudyService;
import com.cqyit.learning.service.IUserService;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author MrHee
 * @version 1.0
 * @className: IStudyServiceImpl
 * @date 2023/10/19 14:18
 * @description:
 */
@Service
public class IStudyServiceImpl extends ServiceImpl<StudyDao, Study> implements IStudyService {
    @Resource
    private StudyDao studyDao;
    @Resource
    private IUserService userService;

    @Override
    public boolean insertRecord(Study study) {
        LambdaQueryWrapper<Study> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Study::getUserId, study.getUserId()); //查询是否有当前用户记录
        lqw.eq(Study::getSubject, study.getSubject()); //查询是否有当前用户该科目的学习记录
        LocalDate today = LocalDate.now(); //获取当前日期
        String early = FormatUtil.dateZeroFormat(today);
        String night = FormatUtil.dateZeroFormat(today, true);
        lqw.ge(Study::getGmtCreate, early);
        lqw.le(Study::getGmtCreate, night);
        Study study1 = studyDao.selectOne(lqw); //查询是否有当前用户该科目的今天的学习记录
        if (study1 == null) {
            return studyDao.insert(study) > 0;
        }
        study.setId(study1.getId());
        study.setTime(study.getTime() + study1.getTime());
        return studyDao.updateById(study) > 0;
    }

    @Override
    public List<Study> getRecord(User user, LocalDate localDate) {
        LambdaQueryWrapper<Study> lqw = new LambdaQueryWrapper<>();
        String early = FormatUtil.dateZeroFormat(localDate);
        String night = FormatUtil.dateZeroFormat(localDate, true);
        lqw.ge(Study::getGmtCreate, early);
        lqw.le(Study::getGmtCreate, night);
        lqw.eq(Study::getUserId, user.getId());
        return studyDao.selectList(lqw);
    }

    @Override
    public List<Study> getRecord(User user, String date) {
        return getRecord(user, FormatUtil.strToLocalDate(date));
    }

    @Override
    public Map<String, List<Study>> getAllRecord(User user) {
        LambdaQueryWrapper<Study> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Study::getUserId, user.getId());
        lqw.orderByDesc(Study::getGmtModified);
        List<Study> studies = studyDao.selectList(lqw);
        Map<String, List<Study>> map = new HashMap<>();
        for (Study study : studies) {
            LocalDate localDate = FormatUtil.strToLocalDate(study.getGmtCreate());
            String today = FormatUtil.dateZeroFormat(localDate);
            if (map.containsKey(today)) {
                map.get(today).add(study);
            } else {
                List<Study> list = new ArrayList<>();
                list.add(study);
                map.put(today, list);
            }
        }
        return map;
    }

    @Override
    public List<StudyRecord> getRecordWeek(User user) {
        LocalDate localDate = LocalDate.now(); //获取当前日期
        List<LocalDate> dateList = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            dateList.add(localDate.minusDays(i));
        }
        List<StudyRecord> records = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            LocalDate date = dateList.get(i);
            List<Study> record = getRecord(user, date);
            StudyRecord studyRecord = getAllTime(record);
            studyRecord.setDate(FormatUtil.dateZeroFormat(date));
            records.add(studyRecord);
        }
        return records;
    }

    @Override
    public StudyRecord getAllTime(List<Study> list) {
        int sumTime = 0;
        StudyRecord studyRecord = new StudyRecord();
        for (Study s : list) {
            sumTime += s.getTime();
        }
        studyRecord.setAllHistoryTime(sumTime);
        return studyRecord;
    }

    @Override
    public List<Charts> getCharts() {
        List<Charts> top10StudyTime = studyDao.getTop10StudyTime();
        for (Charts c : top10StudyTime) {
            User user = userService.getById(c.getUserId());
            if (Strings.isNotEmpty(user.getNickname())) {
                c.setNickname(user.getNickname());
            } else {
                c.setNickname(user.getUsername());
            }
            c.setAvatar(user.getAvatar());
        }
        return top10StudyTime;
    }
}
