package com.cqyit.learning.common.interceptor;

import com.cqyit.learning.common.properties.TokenProperties;
import com.cqyit.learning.common.utils.TokenUtil;
import com.cqyit.learning.service.IUserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.logging.log4j.util.Strings;
import org.jetbrains.annotations.NotNull;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.annotation.Resource;

/**
 * @author MrHee
 * @version 1.0
 * @className: TokenInterceptor
 * @date 2023/10/14 18:07
 * @description: Token拦截验证
 */
public class TokenInterceptor implements HandlerInterceptor {
    @Resource
    private IUserService userService;
    @Resource
    private TokenProperties tokenProperties;


    @Override
    public boolean preHandle(HttpServletRequest request, @NotNull HttpServletResponse response, @NotNull Object handler) throws Exception {
        String token = request.getHeader("Authorization");
        if(Strings.isEmpty(token)){
            return false;
        }
        return new TokenUtil(tokenProperties).verify(userService, token);
    }
}
