package com.cqyit.learning.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqyit.learning.dao.HistoryDao;
import com.cqyit.learning.pojo.History;
import com.cqyit.learning.service.IHistoryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author MrHee
 * @version 1.0
 * @className: IHistoryServiceImpl
 * @date 2023/10/27 16:56
 * @description:
 */
@Service
public class IHistoryServiceImpl extends ServiceImpl<HistoryDao, History> implements IHistoryService {
    @Resource
    private HistoryDao historyDao;

    @Override
    public void insertHistory(History history) {
        historyDao.insert(history);
    }

    @Override
    public int countHistory(Long targetId, Integer type) {
        return historyDao.countByTargetIdAndTypeId(targetId, type);
    }
}
