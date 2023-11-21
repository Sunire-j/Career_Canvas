package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.PartyVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PartyMapper {
    List<PartyVO> SelectPartyList(String logId);
}
