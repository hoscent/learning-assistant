package com.cqyit.learning.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqyit.learning.pojo.Charts;
import com.cqyit.learning.pojo.Study;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @className: StudyDao
 * @author MrHee
 * @date 2023/10/8 18:28
 * @version 1.0
 * @description: 
 */
@Mapper
public interface StudyDao extends BaseMapper<Study> {
    @Select("select user_id, sum(time) as totalTime from learning.study where DATE(gmt_create) = CURDATE() group by user_id order by totalTime desc limit 10")
    List<Charts> getTop10StudyTime();
}
