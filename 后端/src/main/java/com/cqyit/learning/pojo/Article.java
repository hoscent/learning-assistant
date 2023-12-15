package com.cqyit.learning.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @className: Article
 * @author MrHee
 * @date 2023/10/6 15:26
 * @version 1.0
 * @description: 文章
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
    private Long id;
    private String title;
    private String content;
    private String image;
    private Long userId;
    private Long categoryId;
    private Integer praiseNum;
    private Integer status;
    private String gmtCreate;
    private String gmtModified;

    @TableField(exist = false)
    private User user;
    @TableField(exist = false)
    private String categoryName;

    public void setGmtCreate(LocalDateTime gmtCreate) {
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }

    public void setGmtModified(LocalDateTime gmtModified){
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }

}
