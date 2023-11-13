package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.util.securePassword;
import com.team1.careercanvas.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.NoSuchAlgorithmException;
import java.util.Objects;

import static com.team1.careercanvas.util.securePassword.encryptWithSalt;

@Controller
public class UserController {

    private final UserMapper mapper;

    public UserController(UserMapper mapper) {
        this.mapper = mapper;
    }

    @GetMapping("/findpw")
    public String findpw(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/findpw";
    }

    @GetMapping("/login")
    public String login(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }



    @GetMapping("/signup")
    public String signup(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/signup-start";
    }

    @GetMapping("/signup/personal")
    public String signup_personal(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/signup-personal";
    }

    @GetMapping("/signup/biz")
    public String signup_biz(HttpSession session) {
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/signup-biz";
    }

    @GetMapping("/findid")
    public String findid(HttpSession session){
        if (session.getAttribute("LogStatus") == "Y") {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "users/findid";
    }

    @PostMapping("checkId")
    @ResponseBody
    public int checkid(@RequestParam("id") String input) {
        return mapper.idCheck(input);
    }

    @PostMapping("checkName")
    @ResponseBody
    public int checkname(@RequestParam("name") String input) {
        return mapper.namecheck(input);
    }

    @PostMapping("checkemail")
    @ResponseBody
    public int checkemail(@RequestParam("email") String input) {
        return mapper.emailcheck(input);
    }

    @GetMapping("/changepwd")
    public String pwdchange(@RequestParam("id") String originpwd,
                            HttpSession session,
                            HttpServletRequest request){
        if(session != null || !session.isNew()){
            session.invalidate();
            session = request.getSession(true);
        }

        String userid = mapper.getUserIdByPwd(originpwd);
        UserVO saltcheck = mapper.getUser(userid);
        if(!saltcheck.getUsersalt().equals("dontbreakmysalt")){
            session.setAttribute("msg","잘못된 접근입니다!");
            return "alert_page";
        }
        if(userid==null){
            session.setAttribute("msg","잘못된 접근입니다!");
            return "alert_page";
        }else{
            session.setAttribute("userid", userid);
            return "users/changepwd_byemail";
        }
    }
    @PostMapping("startchangepwd")
    public String startchangepwd(@RequestParam("userPwd")String newpassword,
                                 HttpSession session) throws NoSuchAlgorithmException {
        String userid = (String) session.getAttribute("userid");
        String[] secureValue = encryptWithSalt(newpassword);
        String encryptedpwd = secureValue[0];
        String salt = secureValue[1];
        mapper.changePwd(userid, encryptedpwd,salt);
        return "redirect:/login";
    }

    @PostMapping("/signup/personalstart")
    public String signUpPersonal(@RequestParam("userId") String userid,
                                 @RequestParam("userPwd") String userpwd,
                                 @RequestParam("userNickName") String username,
                                 @RequestParam("userEmail") String useremail,
                                 @RequestParam("usertel") String usertel,
                                 HttpSession session) {
        try {
            String[] securearr = encryptWithSalt(userpwd);
            mapper.signupPersonal(userid, securearr[0], username, useremail, usertel, 0, securearr[1]);

            int length = userid.length();
            String firstPart = userid.substring(0, 2);
            String lastPart = userid.substring(length - 2, length);

            StringBuilder asterisks = new StringBuilder();
            for (int i = 0; i < length - 4; i++) {
                asterisks.append("*");
            }

            String result = firstPart.concat(String.valueOf(asterisks)).concat(lastPart);
            session.setAttribute("tempID", result);
            session.setAttribute("tempmail", useremail);
            return "/users/personal_end";
        } catch (Exception e) {
            return "404pages";
        }
    }

    @PostMapping("/signup/bizstart")
    public String signUpBiz(@RequestParam("userId") String userid,
                            @RequestParam("userPwd") String userpwd,
                            @RequestParam("userNickName") String username,
                            @RequestParam("userEmail") String useremail,
                            @RequestParam("usertel") String usertel,
                            @RequestParam("companyno") String companyno,
                            HttpSession session) {
        try {
            String[] securearr = encryptWithSalt(userpwd);
            mapper.signupPersonal(userid, securearr[0], username, useremail, usertel, 1, securearr[1]);
            mapper.signupBiz(userid, companyno);

            session.setAttribute("tempusername", username);
            session.setAttribute("tempcompanyno", companyno);

            return "/users/signup-biz-upload";
        } catch (Exception e) {
            e.printStackTrace();
            return "404pages";
        }
    }

    @PostMapping("/signup/bizupload")
    public String bizupload(@RequestParam("ex_file") MultipartFile file,
                            @RequestParam("companyno") String companyno) {

        if (file.isEmpty()) {
            System.out.println("파일없음");
            return "404pages";
        }

        String extension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String newFileName = companyno + extension;
        String projectDir = new File("").getAbsolutePath();
        File directory = new File(projectDir + "/upload/companyauth");
        if (!directory.exists()) {
            directory.mkdirs(); // 디렉토리 생성
        }

        Path path = Paths.get(directory.getAbsolutePath(), newFileName); // 절대 경로를 사용

        try {
            file.transferTo(new File(path.toString()));
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("파일저장실패");
            return "404pages";
        }

        String imgsrc = "/companyauth/" + newFileName;

        mapper.InsertAuthImg(imgsrc, companyno);
        //이제 신청이 완료되었음 하고 로그인으로 보내든 해야함
        return "users/biz-end";
    }

    @PostMapping("/loginOk")
    public String loginOk(HttpSession session, UserVO vo,
                          @RequestParam("usertype") int usertype,
                          @RequestParam("userid") String userid,
                          @RequestParam("userpwd") String userpwd,
                          @RequestParam(value = "companyno", required = false) String companyno) {//vo쓰면 안됨.
        //아직 관리자로그인 고려안함
        try {
            if (usertype == 0 || usertype == 2) {//개인로그인, 관리자로그인
                UserVO userInDB = mapper.getUser(userid);
                System.out.println(userInDB.getUsersalt());

                if(!Objects.equals(userInDB.getUsersalt(), "dontbreakmysalt")){

                    String encryptedInputPwd = securePassword.encryptWithSalt(userpwd, userInDB.getUsersalt())[0];

                    if (!userInDB.getUserpwd().equals(encryptedInputPwd)) {
                        session.setAttribute("msg", "일치하는 정보가 없습니다.");
                        return "alert_page";
                    } else {
                        session.setAttribute("LogStatus", "Y");
                        session.setAttribute("LogId", userid);
                        session.setAttribute("usertype", userInDB.getUsertype());
                        return "redirect:/";
                    }
                }else{
                    session.setAttribute("msg", "비밀번호 변경 후 진행해주세요. 메일함을 확인해주세요.");
                    return "alert_page";
                }

            } else {//기업로그인
                UserVO userInDB = mapper.getUser(userid);
                if(Objects.equals(userInDB.getUsersalt(), "dontbreakmysalt")){
                    String companynoInDB = mapper.getBizNo(userid);
                    int isaccept = mapper.getAccept(userid);

                    String encryptedInputPwd = securePassword.encryptWithSalt(userpwd, userInDB.getUsersalt())[0];

                    if (!userInDB.getUserpwd().equals(encryptedInputPwd) || !companynoInDB.equals(companyno)) {
                        session.setAttribute("msg", "일치하는 정보가 없습니다.");
                        return "alert_page";
                    } else if (isaccept != 0) {
                        session.setAttribute("msg", "승인 대기중입니다.");
                        return "alert_page";
                    } else {
                        session.setAttribute("LogStatus", "Y");
                        session.setAttribute("LogId", userid);
                        session.setAttribute("usertype", usertype);
                        return "redirect:/";
                    }
                }else{
                    session.setAttribute("msg", "비밀번호 변경 후 진행해주세요.\n메일함을 확인해주세요.");
                    return "alert_page";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "404pages";//
        }
    }


}