package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.ApplyVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ApplyMapper {

    List<ApplyVO> getApplyInfo(String userid);

    int getApplyamount(String userid);
}
