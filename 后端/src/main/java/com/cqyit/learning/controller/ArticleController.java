package com.cqyit.learning.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cqyit.learning.common.enums.OSSDirEnum;
import com.cqyit.learning.common.utils.ResultUtil;
import com.cqyit.learning.common.utils.TokenUtil;
import com.cqyit.learning.pojo.Article;
import com.cqyit.learning.pojo.Category;
import com.cqyit.learning.pojo.Comment;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.AliOssService;
import com.cqyit.learning.service.IArticleService;
import com.cqyit.learning.service.IUserService;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.*;

/**
 * @author MrHee
 * @version 1.0
 * @className: ArticleController
 * @date 2023/10/16 20:03
 * @description:
 */
@RestController
@RequestMapping("/article")
public class ArticleController {
    @Resource
    private AliOssService aliOssService;
    @Resource
    private IUserService userService;
    @Resource
    private IArticleService articleService;

    @GetMapping("/count/comment")
    public ResultUtil<Integer> getCommentCount(@RequestParam Integer id) {
        long articleId = id.longValue();
        return new ResultUtil<>(articleService.countComment(articleId));
    }

    @GetMapping("/detail")
    public ResultUtil<Article> getArticleDetail(@RequestParam Integer id) {
        long articleId = id.longValue();
        return new ResultUtil<>(articleService.getArticleDetail(articleId));
    }

    @GetMapping("/category")
    public ResultUtil<List<Category>> getCategory() {
        return new ResultUtil<>(articleService.getCategory());
    }

    @GetMapping("/comment")
    public ResultUtil<IPage<Comment>> getCommentList(@RequestParam int page, @RequestParam int pageSize, @RequestParam Integer article) {
        if (page == 0 || pageSize == 0 || article == null) {
            return new ResultUtil<>(205, "参数不完整");
        }
        IPage<Comment> commentList = articleService.getCommentList(page, pageSize, article.longValue());
        return new ResultUtil<>(commentList);
    }

    @PostMapping("/comment")
    public ResultUtil<String> publishComment(@RequestBody Map<String, Object> map, @RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        String content = (String) map.get("comment");
        if (content.isEmpty()) {
            return new ResultUtil<>(205, "评论不能为空");
        }
        Comment comment = new Comment();
        comment.setContent(content);
        comment.setCid(((Integer) map.get("cid")).longValue());
        comment.setArticleId(((Integer) map.get("articleID")).longValue());
        long receivedId = ((Integer) map.get("receivedId")).longValue();
        comment.setReceivedId(receivedId);
        comment.setUserId(user.getId());
        if (user.getId() == receivedId) {
            comment.setVisit(1);
        }
        if (articleService.insertComment(comment)) {
            return new ResultUtil<>("评价成功");
        }
        return new ResultUtil<>(206, "评论失败");
    }

    @GetMapping("/list")
    public ResultUtil<IPage<Article>> getArticleList(@RequestParam int page, @RequestParam int pageSize, @RequestParam(required = false) String categoryId, @RequestHeader("Authorization") String token) {
        long category = 0L;
        if (NumberUtils.isParsable(categoryId)) {
            category = Long.parseLong(categoryId);
        } else {
            if (categoryId.equals("attention")) {
                User user = new TokenUtil().getUser(userService, token);
                return new ResultUtil<>(articleService.getArticleAttentionList(page, pageSize, user.getId()));
            }
        }
        return new ResultUtil<>(articleService.getArticleList(page, pageSize, category));
    }

    @PostMapping("/push")
    public ResultUtil<String> push(@RequestBody Map<String, Object> map, @RequestHeader("Authorization") String token) {
        String title = (String) map.get("title");
        String content = (String) map.get("content");
        Long category = ((Integer) map.get("category")).longValue();
        List<?> images = (List<?>) map.get("images");
        ArrayList<String> imagesUrl = new ArrayList<>();

        for (Object image : images) {
            String img = (String) image;
            String pureBase64String = img.split(",")[1];
            byte[] imageBytes = Base64.getDecoder().decode(pureBase64String);
            String imageUrl = aliOssService.UploadOSS(OSSDirEnum.ARTICLE.getValue(), imageBytes, "png");
            imagesUrl.add(imageUrl);
        }
        User user = new TokenUtil().getUser(userService, token);
        if (user == null) {
            return new ResultUtil<>(202, "用户信息无效");
        }
        Article article = new Article();
        article.setTitle(title);
        article.setContent(content);
        article.setImage(String.valueOf(imagesUrl));
        article.setCategoryId(category);
        article.setUserId(user.getId());
        boolean b = articleService.insertArticle(article);
        if (b)
            return new ResultUtil<>("发布成功");
        return new ResultUtil<>("发布失败");
    }

    @GetMapping("/user")
    public ResultUtil<IPage<Article>> getUserArticleList(@RequestParam int page, @RequestParam int pageSize, @RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        IPage<Article> userArticleList = articleService.getUserArticleList(page, pageSize, user.getId());
        if (page > userArticleList.getPages()) {
            userArticleList = articleService.getUserArticleList((int) userArticleList.getPages(), pageSize, user.getId());
        }
        return new ResultUtil<>(userArticleList);
    }

    @GetMapping("/user/count")
    public ResultUtil<Integer> getUserArticleCount(@RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        Integer count = articleService.getUserArticleCount(user.getId());
        return new ResultUtil<>(count);
    }
}