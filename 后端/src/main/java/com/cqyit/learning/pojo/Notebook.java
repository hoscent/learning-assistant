package com.cqyit.learning.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @author MrHee
 * @version 1.0
 * @className: Notebook
 * @date 2023/11/9 12:52
 * @description:
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notebook {
    private Long id;
    private String title;
    private String content;
    private String text;
    private Long categoryId;
    private Long userId;
    private Integer otherVisit;
    private Integer otherEdit;
    private String gmtCreate;
    private String gmtModified;

    @TableField(exist = false)
    private NotebookClass notebookClass;

    public void setGmtCreate(LocalDateTime gmtCreate) {
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }

    public void setGmtModified(LocalDateTime gmtModified){
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }
}
