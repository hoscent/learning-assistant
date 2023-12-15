package com.cqyit.learning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqyit.learning.pojo.History;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: IHistoryService
 * @date 2023/10/27 16:54
 * @description:
 */
public interface IHistoryService extends IService<History> {
    void insertHistory(History history);

    int countHistory(Long targetId, Integer type);
}
