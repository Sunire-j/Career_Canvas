package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.ChattingVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ChatMapper {

    void InsertChat(ChattingVO vo);
    List<ChattingVO> getChat(int partyid);
}
