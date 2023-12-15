package com.cqyit.learning.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @className: Study
 * @author MrHee
 * @date 2023/10/6 15:25
 * @version 1.0
 * @description: 学习记录
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Study {
    private Long id;
    private Long userId;
    private String subject;
    private Integer time;
    private String gmtCreate;
    private String gmtModified;

    @TableField(exist = false)
    private User user;

    public void setGmtCreate(LocalDateTime gmtCreate){
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }

    public  void setGmtModified(LocalDateTime gmtModified){
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }
}
