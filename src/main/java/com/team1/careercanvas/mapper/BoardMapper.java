package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.BoardVO;
import com.team1.careercanvas.vo.PagingVO;
import com.team1.careercanvas.vo.CommentVO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    void InsertNewPost(BoardVO vo);

    List<BoardVO> getPost(PagingVO pvo);

    List<BoardVO> getPostWithCat(PagingVO pvo);

    // 권혁준 작업
    List<BoardVO> getmyPost(String userid);

    List<CommentVO> getmyComment(String userid);

//    정인식 작업 ( 글내용보기 )
    BoardVO SelectBoardView(int postid);
    void ViewsCount(int postid);

    void LikeCount(int postid, String userid);
    int CheckValid(int postid, String userid);
    int GetLikeAmount(int postid);
}
