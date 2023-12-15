package com.cqyit.learning.pojo;

import lombok.Data;

/**
 * @author MrHee
 * @version 1.0
 * @className: StudyRecord
 * @date 2023/10/21 15:30
 * @description: Study实体类的辅助类
 */
@Data
public class StudyRecord {
    private Study[] studies;
    private Integer allHistoryTime;
    private String date;
}
