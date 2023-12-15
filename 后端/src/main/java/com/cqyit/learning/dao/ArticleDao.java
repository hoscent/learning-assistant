package com.cqyit.learning.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cqyit.learning.pojo.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * @className: ArticleDao
 * @author MrHee
 * @date 2023/10/8 18:27
 * @version 1.0
 * @description: 
 */
@Mapper
public interface ArticleDao extends BaseMapper<Article> {
    @Select("select " +
            "article.*,user.username,user.nickname,user.avatar " +
            "from " +
            "learning.article article " +
            "join learning.attention attention on article.user_id = attention.attention_id " +
            "join learning.user user on user.id = article.user_id " +
            "where attention.fans_id = #{userId} " +
            "order by article.gmt_modified desc")
    void getAttentionsPage(IPage<Article> page, @Param("userId") Long userId);
}
