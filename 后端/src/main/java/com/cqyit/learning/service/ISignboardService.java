package com.cqyit.learning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqyit.learning.pojo.Signboard;

import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: ISignboardService
 * @date 2023/10/15 21:35
 * @description:
 */
public interface ISignboardService extends IService<Signboard> {
    List<Signboard> getSignboardPage(Integer type, Integer limit);
}
