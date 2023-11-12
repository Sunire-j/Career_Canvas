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

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

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
        return "users/signup-biz";
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
            String[] securearr = encryptWithSalt(userpwd);
            mapper.signupPersonal(userid,securearr[0],username,useremail,usertel,0,securearr[1]);

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
        }catch(Exception e){
            return "404 page";
        }
    }

    @PostMapping("/signup/bizstart")
    public String signUpBiz(@RequestParam("userId")String userid,
                                 @RequestParam("userPwd")String userpwd,
                                 @RequestParam("userNickName")String username,
                                 @RequestParam("userEmail")String useremail,
                                 @RequestParam("usertel")String usertel,
                                 @RequestParam("companyno") String companyno,
                                 HttpSession session){
        try{
            String[] securearr = encryptWithSalt(userpwd);
            mapper.signupPersonal(userid,securearr[0],username,useremail,usertel,1,securearr[1]);
            mapper.signupBiz(userid, companyno);

            session.setAttribute("tempusername",username);
            session.setAttribute("tempcompanyno",companyno);

            return "/users/signup-biz-upload";
        }catch(Exception e){
            e.printStackTrace();
            return "404 page";
        }
    }

    @PostMapping("/signup/bizupload")
    public String bizupload(@RequestParam("ex_file")MultipartFile file,
                            @RequestParam("companyno") String companyno){

        if (file.isEmpty()) {
            System.out.println("파일없음");
            return "404";
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
            return "404";
        }

        String imgsrc = "/companyauth/" + newFileName;

        mapper.InsertAuthImg(imgsrc, companyno);
        //이제 신청이 완료되었음 하고 로그인으로 보내든 해야함
        return "users/biz-end";
    }

    @PostMapping("/loginOk")
    public String loginOk(HttpSession session, UserVO vo){
        //아직 관리자로그인 고려안함
        try{
            if(vo.getUsertype()==0){//개인로그인
                UserVO userInDB = mapper.getUser(vo.getUserid());

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