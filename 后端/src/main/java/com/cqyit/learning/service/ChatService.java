package com.cqyit.learning.service;

import com.alibaba.dashscope.aigc.generation.GenerationResult;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: ChatService
 * @date 2023/10/5 17:26
 * @description: ChatService Interface
 */
public interface ChatService {
    GenerationResult callWithMessage(String question);
}
