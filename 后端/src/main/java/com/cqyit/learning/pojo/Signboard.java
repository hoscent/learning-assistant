package com.cqyit.learning.pojo;

import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @className: Signboard
 * @author MrHee
 * @date 2023/10/6 15:27
 * @version 1.0
 * @description: 菜单展示
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Signboard {
    private Long id;
    private String title;
    private String image;
    private Integer type;
    private String link;
    private String gmtCreate;
    private String gmtModified;

    public void setGmtCreate(LocalDateTime gmtCreate){
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }

    public void setGmtModified(LocalDateTime gmtModified){
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }
}
