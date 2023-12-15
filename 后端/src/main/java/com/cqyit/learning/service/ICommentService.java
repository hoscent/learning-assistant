package com.cqyit.learning.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cqyit.learning.pojo.Comment;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: ICommentService
 * @date 2023/11/1 10:41
 * @description:
 */
public interface ICommentService extends IService<Comment> {
    Integer getNotReadCount(Long userId);

    void setCommentRead(Long userId);

    IPage<Comment> getCommentList(int current, int size, Long userId);
}
