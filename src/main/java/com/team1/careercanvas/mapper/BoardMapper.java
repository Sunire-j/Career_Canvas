package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.BoardVO;
import com.team1.careercanvas.vo.CommentVO;
import com.team1.careercanvas.vo.PagingVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    int deletePost(int postid);
    void InsertNewPost(BoardVO vo);

    List<BoardVO> getPost(PagingVO pvo);

    List<BoardVO> getPostWithCat(PagingVO pvo);

    int getPostAmount(PagingVO pvo);
    int getPostAmountWithCat(PagingVO pvo);

    int reportPost(int target_id, String target_userid, String target_title, String userid);

    // 권혁준 작업
    List<BoardVO> getmyPost(String userId, String searchText);

    List<CommentVO> getmyComment(String userid, String searchText);

    // 정인식 작업 ( 글내용보기 )
    BoardVO SelectBoardView(int postid);

    void ViewsCount(int postid);

    void LikeCount(int postid, String userid);

    int CheckValid(int postid, String userid);

    int GetLikeAmount(int postid);
}
