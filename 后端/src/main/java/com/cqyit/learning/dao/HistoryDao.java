package com.cqyit.learning.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqyit.learning.pojo.History;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: HistoryDao
 * @date 2023/10/27 16:48
 * @description:
 */
@Mapper
public interface HistoryDao extends BaseMapper<History> {
    @Insert("insert into learning.history (target_id, user_id, type_id) VALUES (#{targetId}, #{userId}, #{typeId}) ON DUPLICATE KEY UPDATE gmt_modified = CURRENT_TIMESTAMP")
    int insert(History history);

    @Select("select count(*) from learning.history where target_id = #{targetId} and type_id = #{typeId}")
    int countByTargetIdAndTypeId(Long targetId, Integer typeId);
}
