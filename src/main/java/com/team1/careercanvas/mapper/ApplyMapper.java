package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.ApplyVO;
import com.team1.careercanvas.vo.PagingVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ApplyMapper {

    List<ApplyVO> getApplyInfo(PagingVO pvo);

    int getApplyamountSolo(String userid);
}
