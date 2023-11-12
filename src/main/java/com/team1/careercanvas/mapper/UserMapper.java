package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

    int idCheck(String input);

    int namecheck(String input);

    int emailcheck(String input);

    void signupPersonal(String userid, String userpwd, String username, String useremail, String usertel, int usertype, String salt);
    void signupBiz(String userid, String companyno);

    UserVO getUser(String userid);
}
