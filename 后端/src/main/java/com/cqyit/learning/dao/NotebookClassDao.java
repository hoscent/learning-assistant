package com.cqyit.learning.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqyit.learning.pojo.NotebookClass;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: NotebookClassDao
 * @date 2023/11/9 12:56
 * @description:
 */
@Mapper
public interface NotebookClassDao extends BaseMapper<NotebookClass> {
}
