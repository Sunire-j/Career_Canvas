package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.BoardVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {
    void InsertNewPost(BoardVO vo);
}
