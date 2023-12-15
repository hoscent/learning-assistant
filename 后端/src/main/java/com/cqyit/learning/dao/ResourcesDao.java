package com.cqyit.learning.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqyit.learning.pojo.Resources;
import org.apache.ibatis.annotations.Mapper;

/**
 * @className: ResourcesDao
 * @author MrHee
 * @date 2023/10/8 18:28
 * @version 1.0
 * @description: 
 */
@Mapper
public interface ResourcesDao extends BaseMapper<Resources> {
}
