package com.cqyit.learning.pojo;

import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @className: Category
 * @author MrHee
 * @date 2023/10/6 15:25
 * @version 1.0
 * @description: 分类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Category {
    private Long id;
    private String text;
    private Integer type;
    private Integer status;
    private String gmtCreate;
    private String gmtModified;

    public void setGmtCreate(LocalDateTime gmtCreate){
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }

    public void setGmtModified(LocalDateTime gmtModified){
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }
}
