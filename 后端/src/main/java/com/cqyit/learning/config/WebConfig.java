package com.cqyit.learning.config;

import com.cqyit.learning.common.interceptor.TokenInterceptor;
import org.jetbrains.annotations.NotNull;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import java.util.ArrayList;
import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @className: CorsConfig
 * @date 2023/10/10 16:20
 * @description: Web相关配置
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Bean
    public HandlerInterceptor tokenInterceptor() {
     return new TokenInterceptor();
    }

    @Override
    public void addInterceptors(@NotNull InterceptorRegistry registry) {
        List<String> excludePath = new ArrayList<>();
        //排除拦截
        excludePath.add("/user/login");     //登录
        excludePath.add("/user/register");     //注册
        excludePath.add("/user/verify"); //Token合法性验证
        excludePath.add("/home/signboard/**");  //公共资源

        registry.addInterceptor(tokenInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns(excludePath);
    }
}