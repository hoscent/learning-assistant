package com.cqyit.learning.pojo;

import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

/**
 * @className: Resources
 * @author MrHee
 * @date 2023/10/6 15:27
 * @version 1.0
 * @description: 资源
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Resources {
    private Long id;
    private String title;
    private String tabs;
    private String author;
    private String description;
    private String cover;
    private String path;
    private String type;
    private Long categoryId;
    private Long collectionId;
    private Integer episodes;
    private String gmtCreate;
    private String gmtModified;

    public void setGmtCreate(LocalDateTime gmtCreate){
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }

    public void setGmtModified(LocalDateTime gmtModified){
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }
}
