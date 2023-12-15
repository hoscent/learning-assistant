package com.cqyit.learning.common.utils;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTCreator;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.*;
import com.auth0.jwt.interfaces.JWTVerifier;
import com.cqyit.learning.common.properties.TokenProperties;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.IUserService;
import org.apache.logging.log4j.util.Strings;
import java.util.Calendar;

/**
 * @author MrHee
 * @version 1.0
 * @className: TokenUtil
 * @date 2023/10/14 17:47
 * @description: Token工具类
 */
public class TokenUtil {
    private TokenProperties tokenProperties;

    public TokenUtil() {
    }

    public TokenUtil(TokenProperties tokenProperties) {
        this.tokenProperties = tokenProperties;
    }

    /**
     * 生成token
     * @param user user
     * @return token
     */
    public String getToken(User user) {
        Calendar instance = Calendar.getInstance();
        // 令牌过期时间
        instance.add(Calendar.SECOND, tokenProperties.getExpiration());
        JWTCreator.Builder builder = JWT.create();
        builder.withClaim("userId", user.getId())
                .withClaim("username", user.getUsername());

        return builder.withExpiresAt(instance.getTime())
                .sign(Algorithm.HMAC256(user.getPassword() + tokenProperties.getSecret()));
    }

    /**
     * @param token token
     * 验证token合法性
     */
    public boolean verify(IUserService userService, String token) {
        if(Strings.isEmpty(token)){
            return false; // 无Token
        }

        User user = getUser(userService, token);
        if (user == null) {
            return false; // 用户不存在
        }
        JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC256(user.getPassword() + tokenProperties.getSecret())).build();
        try {
            jwtVerifier.verify(token);
        } catch (SignatureVerificationException e) {
            return false; // 无效签名
        } catch (TokenExpiredException e) {
            return false; // token过期
        } catch (AlgorithmMismatchException e) {
            return false; // token算法不一致
        } catch (Exception e) {
            return false; // 无效token
        }
        return true;
    }

    /**
     * 通过token获取用户信息
     * @param token token
     * @return user
     */
    public User getUser(IUserService userService, String token) {
        Long userId;
        try {
            userId = JWT.decode(token).getClaim("userId").asLong();
        } catch (JWTDecodeException e) {
            return null; // userId解析失败
        }
        return userService.getById(userId);
    }
}
