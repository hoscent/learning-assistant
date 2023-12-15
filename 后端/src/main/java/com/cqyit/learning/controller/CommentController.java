package com.cqyit.learning.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cqyit.learning.common.utils.ResultUtil;
import com.cqyit.learning.common.utils.TokenUtil;
import com.cqyit.learning.pojo.Comment;
import com.cqyit.learning.pojo.User;
import com.cqyit.learning.service.ICommentService;
import com.cqyit.learning.service.IUserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author MrHee
 * @version 1.0
 * @className: CommentController
 * @date 2023/11/1 10:40
 * @description:
 */
@RestController
@RequestMapping("/comment")
public class CommentController {
    @Resource
    private IUserService userService;
    @Resource
    private ICommentService commentService;

    @GetMapping("/not_read")
    public ResultUtil<Integer> getNotReadCount(@RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        return new ResultUtil<>(commentService.getNotReadCount(user.getId()));
    }

    @PutMapping("/read")
    public void setCommentVisit(@RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        commentService.setCommentRead(user.getId());
    }

    @GetMapping("/list")
    public ResultUtil<IPage<Comment>> getCommentList(int current, int size, @RequestHeader("Authorization") String token) {
        User user = new TokenUtil().getUser(userService, token);
        setCommentVisit(token);
        return new ResultUtil<>(commentService.getCommentList(current, size, user.getId()));
    }
}
