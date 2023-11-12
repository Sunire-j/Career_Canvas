package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.util.securePassword;
import com.team1.careercanvas.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

import static com.team1.careercanvas.util.securePassword.encryptWithSalt;

@Controller
public class UserController {

    private final UserMapper mapper;

    public UserController(UserMapper mapper) {
        this.mapper = mapper;
    }

    @GetMapping("findid")
    public String findid(){
        return "users/findid";
    }
    @GetMapping("/findpw")
    public String findpw(){
        return "users/findpw";
    }
    @GetMapping("/login")
    public String login(HttpSession session){
        if(session.getAttribute("LogStatus")=="Y"){
            return "redirect:/";
        }
        return "users/login";
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/signup")
    public String signup(HttpSession session){
        if(session.getAttribute("LogStatus")=="Y"){
            return "잘못된 접근입니다 페이지";
        }
        return "users/signup-start";
    }
    @GetMapping("/signup/personal")
    public String signup_personal(HttpSession session){
        if(session.getAttribute("LogStatus")=="Y"){
            return "잘못된 접근입니다 페이지";
        }
        return "users/signup-personal";
    }

    @GetMapping("/signup/biz")
    public String signup_biz(HttpSession session){
        if(session.getAttribute("LogStatus")=="Y"){
            return "잘못된 접근입니다 페이지";
        }
        return "users/signup-start";
    }

    @PostMapping("checkId")
    @ResponseBody
    public int checkid(@RequestParam("id")String input){
        return  mapper.idCheck(input);
    }

    @PostMapping("checkName")
    @ResponseBody
    public int checkname(@RequestParam("name")String input){
        return mapper.namecheck(input);
    }

    @PostMapping("checkemail")
    @ResponseBody
    public int checkemail(@RequestParam("email")String input){
        return mapper.emailcheck(input);
    }

    @PostMapping("/signup/personalstart")
    public String signUpPersonal(@RequestParam("userId")String userid,
                                 @RequestParam("userPwd")String userpwd,
                                 @RequestParam("userNickName")String username,
                                 @RequestParam("userEmail")String useremail,
                                 @RequestParam("usertel")String usertel,
                                 HttpSession session){
        try{
            //비밀번호 암호화 해야함 아직 고려 x
            String[] securearr = encryptWithSalt(userpwd);
            mapper.signupPersonal(userid,securearr[0],username,useremail,usertel,securearr[1]);
            session.setAttribute("tempID", userid);
            session.setAttribute("tempmail", useremail);
            return "/users/personal_end";
        }catch(Exception e){
            return "404 page";
        }
    }

    @PostMapping("/loginOk")
    public String loginOk(HttpSession session, UserVO vo){
        //아직 관리자로그인 고려안함
        try{
            if(vo.getUsertype()==0){//개인로그인
                // 해당 유저의 salt와 암호화된 비밀번호를 가져옴
                UserVO userInDB = mapper.getUser(vo.getUserid());

                // 입력한 비밀번호를 암호화
                String encryptedInputPwd = securePassword.encryptWithSalt(vo.getUserpwd(), userInDB.getUsersalt())[0];

                if(!userInDB.getUserpwd().equals(encryptedInputPwd)){
                    return "can't login page";
                }else{
                    session.setAttribute("LogStatus", "Y");
                    session.setAttribute("LogId",vo.getUserid());
                    session.setAttribute("usertype", vo.getUsertype());
                    return "redirect:/";
                }
            }else{//기업로그인
                return "can't login page";
            }
        }catch (Exception e){
            e.printStackTrace();
            return "can't login page";//
        }
    }
}