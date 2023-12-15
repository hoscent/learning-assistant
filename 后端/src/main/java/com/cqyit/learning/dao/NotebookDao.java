package com.cqyit.learning.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqyit.learning.pojo.Notebook;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author MrHee
 * @version 1.0
 * @className: NotebookDao
 * @date 2023/11/9 12:55
 * @description:
 */
@Mapper
public interface NotebookDao extends BaseMapper<Notebook> {
}
