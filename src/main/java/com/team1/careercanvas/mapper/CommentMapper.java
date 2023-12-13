package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.CommentVO;
import com.team1.careercanvas.vo.ReportVO;
import com.team1.careercanvas.vo.SubjectCommentVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommentMapper {

    List<CommentVO> replySelect(int no);
    int replyInsert(CommentVO vo);
    void replyInsertTP(CommentVO vo);
    int replydel(int commentid);
    String getWriter(int targetid);
    String getContent(int targetid);
    int replyReport(ReportVO rvo);
    void UpdatePostComment(int id, String content);

    void UpdateWantedComment(int id ,String content);
    void InsertSubjectComment(SubjectCommentVO scvo);

    List<SubjectCommentVO> getSubjectComment(int applyid);
}
