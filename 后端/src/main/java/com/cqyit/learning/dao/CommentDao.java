package com.cqyit.learning.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqyit.learning.pojo.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * @className: Comment
 * @author MrHee
 * @date 2023/10/8 18:27
 * @version 1.0
 * @description: 
 */
@Mapper
public interface CommentDao extends BaseMapper<Comment> {
    @Select("select count(*) from learning.comment where article_id = #{articleId}")
    int countByArticleId(Long articleId);

    @Update("update learning.comment set visit = 1 where received_id = #{userId} and visit = 0")
    int setRead(Long userId);
}
