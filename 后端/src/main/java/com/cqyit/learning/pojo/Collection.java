package com.cqyit.learning.pojo;

import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

/**
 * @author MrHee
 * @version 1.0
 * @className: Collection
 * @date 2023/11/8 18:08
 * @description:
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Collection {
    private Long id;
    private String title;
    private String description;
    private String cover;
    private String gmtCreate;
    private String gmtModified;

    public void setGmtCreate(LocalDateTime gmtCreate){
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }

    public void setGmtModified(LocalDateTime gmtModified){
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }
}
