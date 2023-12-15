package com.cqyit.learning.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqyit.learning.dao.AttentionDao;
import com.cqyit.learning.pojo.Attention;
import com.cqyit.learning.service.IAttentionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author MrHee
 * @version 1.0
 * @className: IAttentionServiceImpl
 * @date 2023/10/28 16:24
 * @description:
 */
@Service
public class IAttentionServiceImpl extends ServiceImpl<AttentionDao, Attention> implements IAttentionService {
    @Resource
    private AttentionDao attentionDao;

    @Override
    public int getAttentionsCount(Long userId) {
        LambdaQueryWrapper<Attention> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Attention::getFansId, userId);
        return attentionDao.selectCount(lqw).intValue();
    }

    @Override
    public int getFansCount(Long userId) {
        LambdaQueryWrapper<Attention> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Attention::getAttentionId, userId);
        return attentionDao.selectCount(lqw).intValue();
    }
}
