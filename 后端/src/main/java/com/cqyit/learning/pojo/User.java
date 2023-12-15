package com.cqyit.learning.pojo;

import com.cqyit.learning.common.utils.FormatUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

/**
 * @className: User
 * @author MrHee
 * @date 2023/10/6 15:25
 * @version 1.0
 * @description: 用户实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private Long id;
    private String username;
    private String password;
    private String avatar;
    private String nickname;
    private String birthday;
    private String description;
    private Integer gender;
    private String email;
    private Integer phone;
    private String gmtCreate;
    private String gmtModified;

    public void setBirthday(LocalDateTime birthday) {
        this.birthday = FormatUtil.dateFormat(birthday);
    }

    public void setGmtCreate(LocalDateTime gmtCreate) {
        this.gmtCreate = FormatUtil.dateFormat(gmtCreate);
    }

    public void setGmtModified(LocalDateTime gmtModified) {
        this.gmtModified = FormatUtil.dateFormat(gmtModified);
    }

    public void setGmtModified(String gmtModified) {
        this.gmtModified = gmtModified;
    }
}
