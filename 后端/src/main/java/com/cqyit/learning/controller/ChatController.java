package com.cqyit.learning.controller;

import com.alibaba.dashscope.aigc.generation.GenerationResult;
import com.cqyit.learning.service.ChatService;
import com.cqyit.learning.common.utils.ResultUtil;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: ChatController
 * @author MrHee
 * @date 2023/10/1 11:35
 * @version 1.0
 * @description: AI聊天机器人
 */
@RestController
@RequestMapping("/api")
public class ChatController {
    private final ChatService chatService;

    public ChatController(ChatService chatService) {
        this.chatService = chatService;
    }

    @PostMapping("/chat")
    public ResultUtil<String> chat(@RequestBody String question) {
        GenerationResult result = chatService.callWithMessage(question);
        String text = result.getOutput()
                .getText()
                .replaceAll("阿里云", "智慧学伴")
                .replaceAll("通义千问", "小智AI")
                .replaceAll("阿里巴巴集团", "三个诸葛亮团队")
                .replaceAll("达摩院", "三个诸葛亮团队");
        text += "\n\n(内容由小智AI生成)";
        return new ResultUtil<>(text);
    }
}
