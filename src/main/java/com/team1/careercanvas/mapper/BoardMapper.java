package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.BoardVO;
import com.team1.careercanvas.vo.PagingVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    void InsertNewPost(BoardVO vo);
    List<BoardVO> getPost(PagingVO pvo);
    List<BoardVO> getPostWithCat(PagingVO pvo);
}
