package com.cqyit.learning.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqyit.learning.pojo.Category;
import org.apache.ibatis.annotations.Mapper;

/**
 * @className: CategoryDao
 * @author MrHee
 * @date 2023/10/8 18:27
 * @version 1.0
 * @description: 
 */
@Mapper
public interface CategoryDao extends BaseMapper<Category> {
}
