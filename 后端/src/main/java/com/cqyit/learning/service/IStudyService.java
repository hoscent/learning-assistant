package com.cqyit.learning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqyit.learning.pojo.Charts;
import com.cqyit.learning.pojo.Study;
import com.cqyit.learning.pojo.StudyRecord;
import com.cqyit.learning.pojo.User;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: IStudyService
 * @date 2023/10/19 14:17
 * @description:
 */
public interface IStudyService extends IService<Study> {
    /**
     * 插入学习记录
     * @param study Study
     * @return boolean
     */
    boolean insertRecord(Study study);

    /**
     * 获取用户某一天的学习记录
     * @param user User
     * @param localDate LocalDate
     * @return List<Study>
     */
    List<Study> getRecord(User user, LocalDate localDate);

    List<Study> getRecord(User user, String date);

    Map<String, List<Study>> getAllRecord(User user);

    /**
     * 获取用户今天起至前6天的周学习记录
     * @param user User
     * @return List<StudyRecord>
     */
    List<StudyRecord> getRecordWeek(User user);

    /**
     * 计算集合中Study总的学习时长
     * @param list List<Study>
     * @return StudyRecord
     */
    StudyRecord getAllTime(List<Study> list);

    /**
     * 获取每日排行
     * @return List<Charts>
     */
    List<Charts> getCharts();
}
