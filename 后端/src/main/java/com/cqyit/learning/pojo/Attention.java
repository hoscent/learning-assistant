package com.cqyit.learning.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @className: Attention
 * @author MrHee
 * @date 2023/10/6 15:27
 * @version 1.0
 * @description: 用户关注实体类
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attention {
    private Long id;
    private Long fansId;
    private Long attentionId;
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
