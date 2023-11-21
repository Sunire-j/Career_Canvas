package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.MessageVO;
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

    List<MessageVO> getSendMsg(String LogId);

    List<MessageVO> getReceiveMsg(String LogId);

    List<SubmitSubjectVO> getSubmitSubjectSolo(String LogId);

    List<SubmitSubjectVO> getSubmitSubjectTeam(String LogId);

}
