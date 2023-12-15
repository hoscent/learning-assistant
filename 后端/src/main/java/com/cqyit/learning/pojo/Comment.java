package com.cqyit.learning.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @className: Comment
 * @author MrHee
 * @date 2023/10/6 15:26
 * @version 1.0
 * @description: 评论
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
    private Long id;
    private Long cid;
    private String content;
    private Long userId;
    private Long receivedId;
    private Long articleId;
    private Integer visit;
    private String gmtCreate;
    private String gmtModified;

    @TableField(exist = false)
    private User user;

    public void setGmtCreate(LocalDateTime gmtCreate){
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }
    public void setGmtModified(LocalDateTime gmtModified){
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }
}
