package com.cqyit.learning.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqyit.learning.dao.SignboardDao;
import com.cqyit.learning.pojo.Signboard;
import com.cqyit.learning.service.ISignboardService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @className: ISignboardServiceImpl
 * @date 2023/10/15 21:36
 * @description:
 */
@Service
public class ISignboardServiceImpl extends ServiceImpl<SignboardDao, Signboard> implements ISignboardService {
    @Resource
    private SignboardDao signboardDao;

    @Override
    public List<Signboard> getSignboardPage(Integer type, Integer limit) {
        LambdaQueryWrapper<Signboard> lqw = new LambdaQueryWrapper<>();
        lqw.orderByDesc(Signboard::getGmtModified);
        lqw.eq(Signboard::getType, type);
        lqw.last("limit " + limit);
        return signboardDao.selectList(lqw);
    }
}
