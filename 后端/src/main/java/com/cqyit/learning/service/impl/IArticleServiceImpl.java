package com.cqyit.learning.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqyit.learning.dao.ArticleDao;
import com.cqyit.learning.dao.CategoryDao;
import com.cqyit.learning.dao.CommentDao;
import com.cqyit.learning.pojo.Article;
import com.cqyit.learning.pojo.Category;
import com.cqyit.learning.pojo.Comment;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.IArticleService;
import com.cqyit.learning.service.IUserService;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import static com.cqyit.learning.service.impl.ICommentServiceImpl.getCommentIPage;


/**
 * @author MrHee
 * @version 1.0
 * @className: IArticleServiceImpl
 * @date 2023/10/22 15:05
 * @description:
 */
@Service
public class IArticleServiceImpl extends ServiceImpl<ArticleDao, Article> implements IArticleService {
    @Resource
    private ArticleDao articleDao;
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private IUserService userService;
    @Resource
    private CommentDao commentDao;

    @Override
    public List<Category> getCategory() {
        LambdaQueryWrapper<Category> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Category::getType, 0);
        lqw.eq(Category::getStatus, 1);
        return categoryDao.selectList(lqw);
    }

    @Override
    public boolean insertArticle(Article article) {
        return articleDao.insert(article) > 0;
    }

    @Override
    public IPage<Article> getArticleList(int current, int size, Long category) {
        LambdaQueryWrapper<Article> lqw = new LambdaQueryWrapper<>();
        IPage<Article> iPage = new Page<>(current, size);
        if (category > 0) {
            lqw.eq(Article::getCategoryId, category);
        }
        lqw.orderByDesc(Article::getGmtModified);
        return getArticleIAuthor(lqw, iPage);
    }

    @Override
    public IPage<Article> getArticleAttentionList(int current, int size, Long userId) {
        IPage<Article> iPage = new Page<>(current, size);
        articleDao.getAttentionsPage(iPage, userId);
        return iPage;
    }

    @Override
    public IPage<Article> getUserArticleList(int current, int size, Long userId) {
        LambdaQueryWrapper<Article> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Article::getUserId, userId);
        IPage<Article> articleIPage = new Page<>(current, size);
        return getArticleIAuthor(lqw, articleIPage);
    }

    @NotNull
    private IPage<Article> getArticleIAuthor(LambdaQueryWrapper<Article> lqw, IPage<Article> articleIPage) {
        articleDao.selectPage(articleIPage, lqw);
        List<Article> records = articleIPage.getRecords();
        for (Article a : records) {
            User user = userService.getUserNoPrivacy(a.getUserId());
            a.setUser(user);
        }
        articleIPage.setRecords(records);
        return articleIPage;
    }

    @Override
    public Article getArticleDetail(Long id) {
        Article article = articleDao.selectById(id);
        article.setUser(userService.getUserNoPrivacy(article.getUserId()));
        article.setCategoryName(categoryDao.selectById(article.getCategoryId()).getText());
        return article;
    }

    @Override
    public boolean insertComment(Comment comment) {
        return commentDao.insert(comment) > 0;
    }

    @Override
    public IPage<Comment> getCommentList(int current, int size, Long article) {
        LambdaQueryWrapper<Comment> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Comment::getArticleId, article);
        return getCommentIPage(current, size, lqw, commentDao, userService);
    }

    @Override
    public int countComment(Long articleId) {
        return commentDao.countByArticleId(articleId);
    }

    @Override
    public Integer getUserArticleCount(Long id) {
        LambdaQueryWrapper<Article> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Article::getUserId, id);
        return Math.toIntExact(articleDao.selectCount(lqw));
    }
}
