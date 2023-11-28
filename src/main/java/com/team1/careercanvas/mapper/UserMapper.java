package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.MessageVO;
import com.team1.careercanvas.vo.PagingVO;
import com.team1.careercanvas.vo.PofolVO;
import com.team1.careercanvas.vo.SubmitSubjectVO;
import com.team1.careercanvas.vo.UserVO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

    int idCheck(String input);

    int namecheck(String input);

    int emailcheck(String input);

    void signupPersonal(String userid, String userpwd, String username, String useremail, String usertel, int usertype,
            String salt);

    void signupBiz(String userid, String companyno);

    UserVO getUser(String userid);

    void InsertAuthImg(String imgsrc, String companyno);

    String getBizNo(String userid);

    int getAccept(String userid);

    String getUserId(String useremail, int usertype);

    String getUserIdForBiz(String useremail, String companyno, int usertype);

    String getUserPwd(String userid, String useremail, int usertype);

    String getUserPwdForBiz(String userid, String useremail, int usertype, String companyno);

    String getUserIdByPwd(String originpwd);

    void deleteUserPwd(String userid);

    void changePwd(String userid, String pwd, String salt);

    // 권혁준 작업
    UserVO getUserInfo(String LogId);

    void updateMypageWithoutPwd(String nickName, String tel, String comment, String userid);

    List<MessageVO> getSendMsg(PagingVO pVO);

    int getTotalSendMsg(PagingVO pVO);

    List<MessageVO> getReceiveMsg(PagingVO pVO);

    int getTotalReceiveMsg(PagingVO pVO);

    List<SubmitSubjectVO> getSubmitSubjectSolo(PagingVO pVO);

    int getSubjectSoloAmount(PagingVO pVO);

    List<SubmitSubjectVO> getSubmitSubjectTeam(String LogId, PagingVO pVO);

    int getSubjectTeamAmount(PagingVO pVO);

    int getPofolAmount(String LogId, PagingVO pVO);

    void pofolWrite(String LogId, String title, String content, String category);

}
