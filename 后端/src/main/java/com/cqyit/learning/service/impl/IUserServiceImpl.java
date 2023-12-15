package com.cqyit.learning.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqyit.learning.dao.UserDao;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.IUserService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;


/**
 * @className: IUserServiceImpl
 * @author MrHee
 * @date 2023/10/8 18:34
 * @version 1.0
 * @description: 
 */
@Service
public class IUserServiceImpl extends ServiceImpl<UserDao, User> implements IUserService {
    @Resource
    private UserDao userDao;

    @Override
    public boolean registerUser(User user) {
        user.setNickname(user.getUsername());
        LambdaQueryWrapper<User> lqw = new LambdaQueryWrapper<>();
        lqw.eq(User::getUsername, user.getUsername());
        User us = userDao.selectOne(lqw);
        if (us != null) {
            return false;
        }
        userDao.insert(user);
        return true;
    }

    @Override
    public User login(String username, String password) {
        LambdaQueryWrapper<User> lqw = new LambdaQueryWrapper<>();
        lqw.eq(User::getUsername, username);
        User user = userDao.selectOne(lqw);
        if (user == null) {
            return null;
        }
        if (user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public User getUserNoPrivacy(Long id) {
        User user = userDao.selectById(id);
        user.setPassword(null);
        user.setEmail(null);
        user.setGmtModified((String) null);
        return user;
    }
}
