package com.cqyit.learning.common.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author MrHee
 * @version 1.0
 * @className: TokenProperties
 * @date 2023/10/17 17:17
 * @description:
 */
@Data
@Component
@ConfigurationProperties(prefix = "tools.token")
public class TokenProperties {
    private int expiration;
    private String secret;
}
