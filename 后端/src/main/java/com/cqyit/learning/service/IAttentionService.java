package com.cqyit.learning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqyit.learning.pojo.Attention;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: IAttentionService
 * @date 2023/10/28 16:23
 * @description:
 */
public interface IAttentionService extends IService<Attention> {
    int getAttentionsCount(Long userId);

    int getFansCount(Long userId);
}
