package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.BoardVO;
import com.team1.careercanvas.vo.ReportVO;
import com.team1.careercanvas.vo.SubjectVO;
import com.team1.careercanvas.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {
    List<UserVO> getUserProfile();
    List<BoardVO> getBoardList();
    List<ReportVO> getReportList();
    String getAdminName(String username);
    List<SubjectVO> getDeleteList();
    int deleteAssignment(int subjectid);
    int deleteBoard(int postid);
    int deleteReport(int targetid);
    int deleteUser(String userid);
    String getWriterUser(int postid);
    String reporterUser(int target_id);
    int changeUsername(String userid, String changed);
}
