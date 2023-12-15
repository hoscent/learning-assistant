package com.cqyit.learning.controller;

import com.cqyit.learning.common.properties.TokenProperties;
import com.cqyit.learning.common.utils.ResultUtil;
import com.cqyit.learning.common.utils.TokenUtil;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.IAttentionService;
import com.cqyit.learning.service.IUserService;
import org.apache.logging.log4j.util.Strings;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * @author MrHee
 * @version 1.0
 * @className: UserController
 * @date 2023/10/15 22:18
 * @description:
 */
@RestController
@RequestMapping("/user")
public class UserController {
    @Resource
    private IUserService userService;
    @Resource
    private TokenProperties tokenProperties;
    @Resource
    private IAttentionService attentionService;

    @PostMapping("/register")
    public ResultUtil<String> userRegister(@RequestBody Map<String, String> map) {
        String username = map.get("username");
        String password = map.get("password");
        String rePassword = map.get("rePassword");
        String usernameRegex = "^[a-zA-Z0-9]{5,16}$";
        String passwordRegex = "^\\S{6,18}$";
        if (Strings.isEmpty(username) || Strings.isEmpty(password) || Strings.isEmpty(rePassword)) {
            return new ResultUtil<>(201, "请确保信息填写完整");
        }
        if (!username.matches(usernameRegex)) {
            return new ResultUtil<>(201, "账号长度为5-16位，只能包含字母、数字");
        }
        if (!password.matches(passwordRegex)) {
            return new ResultUtil<>(201, "密码必须为非空字符，长度为6-18位");
        }
        if (!password.equals(rePassword)) {
            return new ResultUtil<>(201, "两次输入密码不一致");
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        boolean b = userService.registerUser(user);
        if (!b) {
            return new ResultUtil<>(201, "用户名已存在");
        }
        return new ResultUtil<>("注册成功");
    }

    @GetMapping("/info")
    public ResultUtil<User> getUserInfo(@RequestParam(required = false) Integer userId, @RequestHeader("Authorization") String token) {
        Long uid;
        if (userId != null) {
            uid = userId.longValue();
        } else {
            User user = new TokenUtil().getUser(userService, token);
            uid = user.getId();
        }
        return new ResultUtil<>(userService.getUserNoPrivacy(uid));
    }

    @PostMapping("/login")
    public ResultUtil<String> userLogin(@RequestBody Map<String, String> map) {
        String username = map.get("username");
        String password = map.get("password");
        User user = userService.login(username, password);
        if (user == null) {
            return new ResultUtil<>(201, "用户名或密码错误");
        }
        return new ResultUtil<>(new TokenUtil(tokenProperties).getToken(user));
    }

    @GetMapping("/verify")
    public ResultUtil<Boolean> getTokenVerify(@RequestHeader("Authorization") String token) {
        return new ResultUtil<>(new TokenUtil(tokenProperties).verify(userService, token));
    }

    @GetMapping("/attention/num")
    public ResultUtil<HashMap<String, Integer>> getAttentionNum(@RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        int attentionsCount = attentionService.getAttentionsCount(user.getId());
        int fansCount = attentionService.getFansCount(user.getId());
        HashMap<String, Integer> map = new HashMap<>();
        map.put("attentionsCount", attentionsCount);
        map.put("fansCount", fansCount);
        return new ResultUtil<>(map);
    }
}
