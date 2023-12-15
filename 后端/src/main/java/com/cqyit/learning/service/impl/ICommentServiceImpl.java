package com.cqyit.learning.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqyit.learning.dao.CommentDao;
import com.cqyit.learning.pojo.Comment;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.ICommentService;
import com.cqyit.learning.service.IUserService;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @className: ICommentServiceImpl
 * @date 2023/11/1 10:42
 * @description:
 */
@Service
public class ICommentServiceImpl extends ServiceImpl<CommentDao, Comment> implements ICommentService {
    @Resource
    private CommentDao commentDao;
    @Resource
    private IUserService userService;

    @Override
    public Integer getNotReadCount(Long userId) {
        LambdaQueryWrapper<Comment> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Comment::getReceivedId, userId);
        lqw.eq(Comment::getVisit, 0);
        return Math.toIntExact(commentDao.selectCount(lqw));
    }

    @Override
    public void setCommentRead(Long userId) {
        commentDao.setRead(userId);
    }

    @Override
    public IPage<Comment> getCommentList(int current, int size, Long userId) {
        LambdaQueryWrapper<Comment> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Comment::getReceivedId, userId);
        lqw.ne(Comment::getUserId, userId);
        lqw.orderByDesc(Comment::getGmtCreate);
        return getCommentIPage(current, size, lqw, commentDao, userService);
    }

    @NotNull
    static IPage<Comment> getCommentIPage(int current, int size, LambdaQueryWrapper<Comment> lqw, CommentDao commentDao, IUserService userService) {
        IPage<Comment> iPage = new Page<>(current, size);
        commentDao.selectPage(iPage, lqw);
        List<Comment> records = iPage.getRecords();
        for (Comment comment : records) {
            User user = userService.getUserNoPrivacy(comment.getUserId());
            comment.setUser(user);
        }
        iPage.setRecords(records);

        return iPage;
    }

}
