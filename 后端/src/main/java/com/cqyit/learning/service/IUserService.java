package com.cqyit.learning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqyit.learning.pojo.User;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: IUserService
 * @date 2023/10/8 18:33
 * @description:
 */
public interface IUserService extends IService<User> {
    boolean registerUser(User user);

    User login(String username, String password);

    User getUserNoPrivacy(Long id);
}
