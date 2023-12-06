package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PartyMapper {
    List<PartyVO> SelectPartyList(String logId);
    PartyVO myteamSelect(int partyid);
    List<UserVO> SelectMemberList(int partyid);
    List<MemoVO> SelectMemoListView(int partyid);
    int InsertMemo(int partyid, String content, String logid);

    int DeleteMemo(int partymemo);

    int InsertCreateTeam(PartyVO temp);

    void InsertPartyImg(String imgsrc, int partyid);
    void InsertMember(int Partyid, String logId, String temp);

    int CheckPartyName(String partyname);

    void UpdatePartyName(String partyname, int partyid);

    void UpdatePartyObjective(int partyid, String partygoal);

    void UpdatePartyIntro(int partyid, String partycomment);

    //조석훈 시작
    List<PartyVO> getMineParty(String userid);

    void InsertWanted(WantedVO wVO);

    List<WantedVO> GetWantedList(PagingVO pvo);
    int getWantedListCount(PagingVO pvo);

    WantedVO GetWantedView(int no);

    List<CommentVO> commentLoad(int no);

    int replyInsert(CommentVO cvo);

    void replyInsertTP(CommentVO cvo);
    int DeleteWanted(int wantedid);
    int reportWanted(int wantedid, String targetuid, String title, String uid);
    String getCommentWriter(int commentid);
    String getCommentcontent(int commentid);

    int commentReport(ReportVO rvo);

    int deleteWantedComment(int commentid);
    void increseView(int no);
    int applyParty(String uid,int partyid);
    String getPartyName(int partyid);

    String getpartyimg(int partyid);

    int CheckpartyId(int partyid);
    //조석훈 끝

    // 정인식 작업
    List<UserVO> SelectWaitingList(int partyid);

    void DeleteMember(int partyid, String user_userid);
    void ApproveMember(int partyid, String user_userid);
    void RefuseMember(int partyid, String user_userid);

    void UpdatePartyImg(String imgsrc, int partyid);

    List<PofolVO> SelectPofolList(PagingVO pvo);

    int getpofolamountforparty(int partyid);

    int pofolWrite(PofolVO pvo);

    void addPofolMember(int portfolioid, String userid);

    int insertPofolImg(String pathfordb,int Portfolioid);

    // 정인식 작업 끝
}
