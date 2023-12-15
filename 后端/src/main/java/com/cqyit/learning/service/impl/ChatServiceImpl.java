package com.cqyit.learning.service.impl;

import com.alibaba.dashscope.aigc.generation.Generation;
import com.alibaba.dashscope.aigc.generation.GenerationResult;
import com.alibaba.dashscope.aigc.generation.models.QwenParam;
import com.alibaba.dashscope.common.Message;
import com.alibaba.dashscope.common.Role;
import com.alibaba.dashscope.exception.InputRequiredException;
import com.alibaba.dashscope.exception.NoApiKeyException;
import com.cqyit.learning.service.ChatService;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @className: ChatServiceImpl
 * @date 2023/10/5 17:26
 * @description: ChatService实现类
 */
@Service
public class ChatServiceImpl implements ChatService {
    private final Generation gen = new Generation();
    private final List<Message> messages = new ArrayList<>();

    ChatServiceImpl() {
        Message systemMsg = Message.builder().role(Role.SYSTEM.getValue()).content("您好，我是小智，有什么可以帮到您的吗？").build();
        messages.add(systemMsg);
    }

    @Override
    public GenerationResult callWithMessage(String question) {
        Message userMsg = Message.builder().role(Role.USER.getValue()).content(question).build();
        messages.add(userMsg);
        QwenParam param = QwenParam.builder().model(Generation.Models.QWEN_PLUS).messages(messages)
                .resultFormat(QwenParam.ResultFormat.MESSAGE)
                .topP(0.8)
                .seed(1234)
                .enableSearch(true)
                .resultFormat("text")
                .build();
        GenerationResult result;
        try {
            result = gen.call(param);
            Message message = Message.builder().role(Role.ASSISTANT.getValue()).content(result.getOutput().getText()).build();
            messages.add(message);
        } catch (NoApiKeyException | InputRequiredException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
}
