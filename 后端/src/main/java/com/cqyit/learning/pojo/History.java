package com.cqyit.learning.pojo;

import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

/**
 * @className: History
 * @author MrHee
 * @date 2023/10/13 12:35
 * @version 1.0
 * @description: 浏览历史
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class History {
    private Long id;
    private Long targetId;
    private Long userId;
    private Integer typeId;
    private Integer status;
    private String gmtCreate;
    private String gmtModified;

    public void setGmtCreate(LocalDateTime gmtCreate) {
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }

    public void setGmtModified(LocalDateTime gmtModified){
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }
}
