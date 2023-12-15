package com.cqyit.learning.common.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 * @className: FormatUtil
 * @author MrHee
 * @date 2023/10/6 15:41
 * @version 1.0
 * @description: 格式化
 */
public class FormatUtil {
    public static String dateFormat(LocalDateTime dateTime) {
        return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public static String dateZeroFormat(LocalDate dateTime) {
        return dateZeroFormat(dateTime, false);
    }

    public static String dateZeroFormat(LocalDate dateTime, boolean night) {
        LocalTime localTime = (night ? LocalDateTime.MAX : LocalDateTime.MIN).toLocalTime();
        LocalDateTime localDateTime = LocalDateTime.of(dateTime, localTime);
        return dateFormat(localDateTime);
    }

    public static LocalDate strToLocalDate(String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime localDateTime = LocalDateTime.parse(date, formatter);
        return localDateTime.toLocalDate();
    }
}
