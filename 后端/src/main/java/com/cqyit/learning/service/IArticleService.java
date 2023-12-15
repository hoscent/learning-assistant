package com.cqyit.learning.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cqyit.learning.pojo.Article;
import com.cqyit.learning.pojo.Category;
import com.cqyit.learning.pojo.Comment;

import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: IArticleService
 * @date 2023/10/22 15:05
 * @description:
 */
public interface IArticleService extends IService<Article> {
    List<Category> getCategory();

    boolean insertArticle(Article article);

    IPage<Article> getArticleList(int current, int size, Long category);

    IPage<Article> getArticleAttentionList(int current, int size, Long userId);

    IPage<Article> getUserArticleList(int current, int size, Long userId);

    Article getArticleDetail(Long id);

    boolean insertComment(Comment comment);

    IPage<Comment> getCommentList(int current, int size, Long article);

    int countComment(Long articleId);

    Integer getUserArticleCount(Long id);
}
