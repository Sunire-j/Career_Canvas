package com.team1.careercanvas.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    String loginSelect(String userid);
}
