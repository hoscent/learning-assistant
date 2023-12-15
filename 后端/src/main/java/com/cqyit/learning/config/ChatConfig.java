package com.cqyit.learning.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.alibaba.dashscope.utils.Constants;

/**
 * @className: ChatConfig
 * @author MrHee
 * @date 2023/10/5 16:42
 * @version 1.0
 * @description: Dashscope 密钥配置
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "tools.openai.dashscope")
public class ChatConfig {
    private String qwenKey;

    @Bean
    public String constants () {
        return Constants.apiKey = qwenKey;
    }
}
