package com.cqyit.learning.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

/**
 * @author MrHee
 * @version 1.0
 * @className: CorsFilter
 * @date 2023/10/16 22:29
 * @description:
 */
@Configuration
public class CorsFilterConfig {

    @Bean
    public CorsFilter corsFilter() {
        // 创建 CorsConfiguration 对象后添加配置
        CorsConfiguration corsConfiguration = new CorsConfiguration();
        // 设置放行哪些原始域
        corsConfiguration.addAllowedOrigin("*");
        // 放行哪些原始请求头部信息
        corsConfiguration.addAllowedHeader("*");
        // 放行哪些请求方法
        corsConfiguration.addAllowedMethod("*");

        corsConfiguration.setMaxAge(86400L);

        // 添加映射路径
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfiguration);

        return new CorsFilter(source);
    }
}
