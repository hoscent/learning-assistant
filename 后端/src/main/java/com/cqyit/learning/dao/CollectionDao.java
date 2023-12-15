package com.cqyit.learning.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqyit.learning.pojo.Collection;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: CollectionDao
 * @date 2023/11/8 18:10
 * @description:
 */
@Mapper
public interface CollectionDao extends BaseMapper<Collection> {
}
