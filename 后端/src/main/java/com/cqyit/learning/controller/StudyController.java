package com.cqyit.learning.controller;

import com.cqyit.learning.common.utils.FormatUtil;
import com.cqyit.learning.common.utils.ResultUtil;
import com.cqyit.learning.common.utils.TokenUtil;
import com.cqyit.learning.pojo.Charts;
import com.cqyit.learning.pojo.Study;
import com.cqyit.learning.pojo.StudyRecord;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.IStudyService;
import com.cqyit.learning.service.IUserService;
import org.apache.logging.log4j.util.Strings;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.*;

/**
 * @author MrHee
 * @version 1.0
 * @className: StudyController
 * @date 2023/10/19 14:16
 * @description:
 */
@RestController
@RequestMapping("/study")
public class StudyController {
    @Resource
    private IStudyService studyService;
    @Resource
    private IUserService userService;

    @GetMapping("/charts")
    public ResultUtil<List<Charts>> getDayCharts() {
        return new ResultUtil<>(studyService.getCharts());
    }

    @GetMapping("/record/history")
    public ResultUtil<List<HashMap<String, Object>>> getRecordList(@RequestParam(required = false) String dateStr, @RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        List<HashMap<String, Object>> list = new ArrayList<>();
        if (Strings.isNotEmpty(dateStr)) {
            String[] dates = dateStr.split(",");
            for (String date : dates) {
                HashMap<String, Object> map = new HashMap<>();
                date = date + " 00:00:00";
                List<Study> record = studyService.getRecord(user, date);
                if (record.isEmpty()) {
                    continue;
                }
                map.put("date", date);
                map.put("record", record);
                list.add(map);
            }
        } else {
            Map<String, List<Study>> allRecord = studyService.getAllRecord(user);
            Set<String> dates = allRecord.keySet();
            for (String date : dates) {
                HashMap<String, Object> map = new HashMap<>();
                map.put("date", date);
                map.put("record", allRecord.get(date));
                list.add(map);
            }
        }
        list.sort((o1, o2) -> {
            LocalDate localDate1 = FormatUtil.strToLocalDate(o1.get("date").toString());
            LocalDate localDate2 = FormatUtil.strToLocalDate(o2.get("date").toString());
            return localDate2.compareTo(localDate1);
        });
        return new ResultUtil<>(list);
    }

    @PostMapping("/record")
    public ResultUtil<String> recordStudy(@RequestBody Map<String, String> map, @RequestHeader("Authorization") String token) {
        String subject = map.get("subject");
        String time = map.get("time");
        int i = Integer.parseInt(time);
        if (i > 0) {
            User user = new TokenUtil().getUser(userService, token);
            Study study = new Study();
            study.setUserId(user.getId());
            study.setSubject(subject);
            study.setTime(i);
            boolean b = studyService.insertRecord(study);
            if (b) {
                return new ResultUtil<>("记录成功");
            }
        }
        return new ResultUtil<>(200, "记录失败");
    }

    @GetMapping("/record")
    public ResultUtil<StudyRecord> getRecord(@RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        LocalDate localDate = LocalDate.now(); //获取当前日期
        List<Study> record = studyService.getRecord(user, localDate);
        record.sort((o1, o2) -> o2.getTime() - o1.getTime());
        LocalDate yesterday = localDate.minusDays(1);
        List<Study> yesterdayRecord = studyService.getRecord(user, yesterday);
        StudyRecord studyRecord = studyService.getAllTime(yesterdayRecord);
        studyRecord.setStudies(record.toArray(Study[]::new));
        return new ResultUtil<>(studyRecord);
    }

    @GetMapping("/record/week")
    public ResultUtil<List<StudyRecord>> getRecordWeek(@RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        return new ResultUtil<>(studyService.getRecordWeek(user));
    }
}
