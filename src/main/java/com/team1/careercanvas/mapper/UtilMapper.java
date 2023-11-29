package com.team1.careercanvas.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.Date;

@Mapper
public interface UtilMapper {
    int increaseCountOrInsert(Date date);
}
