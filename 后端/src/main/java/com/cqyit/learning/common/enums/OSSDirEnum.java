package com.cqyit.learning.common.enums;
/**
 * @enumName: OSSDirEnum
 * @author MrHee
 * @date 2023/10/13 14:27
 * @version 1.0
 * @description: 阿里云OSS存储目录
 */
public enum OSSDirEnum {
    MENU("menu"),
    ARTICLE("article"),
    AVATAR("avatar"),
    CAROUSEL("carousel"),
    BOOK("book"),
    VIDEO("video");

    private final String value;

    OSSDirEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
