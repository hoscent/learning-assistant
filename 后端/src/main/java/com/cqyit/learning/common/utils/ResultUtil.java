package com.cqyit.learning.common.utils;

import lombok.Data;

/**
 * @className: ResultUtil
 * @author MrHee
 * @date 2023/10/1 21:44
 * @version 1.0
 * @description: 后端向前端返回数据工具类
 */
@Data
public class ResultUtil<T> {
    Integer code = 200;
    T data;
    String msg = "success";

    public ResultUtil() {
    }

    public ResultUtil(T data) {
        this.data = data;
    }

    public ResultUtil(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
