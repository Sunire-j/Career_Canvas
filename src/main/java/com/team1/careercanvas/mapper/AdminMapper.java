package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {
    List<UserVO> getUserProfile(PagingVO pvo);

    List<BoardVO> getBoardList();

    List<ReportVO> getReportList();

    String getAdminName(String username);

    List<SubjectVO> getDeleteList();

    int deleteAssignment(int subjectid);

    int dismissSubject(int subjectid);

    int deleteBoard(int postid);

    int deleteReport(int targetid);

    int deleteWanted(int wantedid);

    int deleteComment(int commentid);

    int deleteWantedComment(int commentid);

    int deleteUser(String userid);

    String getWriterUser(int postid);

    String reporterUser(int target_id);

    int changeUsername(String userid, String changed);

    int getUserCount();

    int getBoardCount();

    int getReportCount();

    int getDeleteCount();

    int getBoardToday();

    List<BoardVO> getBoardMonth();

    // 권혁준작업
    List<BannerVO> getBannerList();

    int getBannerAmount(PagingVO pVO);

    //조석훈 작업

    int InsertBanner(BannerVO bvo);
    void InsertBannerimg(String imgsrc, int bannerid);
}
