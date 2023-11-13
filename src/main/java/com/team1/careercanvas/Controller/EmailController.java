package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mail.EmailService;
import com.team1.careercanvas.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.time.Duration;
import java.time.LocalDateTime;

@Controller
public class EmailController {

    private final UserMapper mapper;
    @Autowired
    private EmailService emailService;

    public EmailController(UserMapper mapper) {
        this.mapper = mapper;
    }


    @PostMapping("/emailsend")
    @ResponseBody
    public int sendEmail(@RequestParam("email") String email, HttpSession session) {
        String authCode = generateAuthCode();
        emailService.sendMail(email, "커리어캔버스 회원가입 인증 코드", authCode);

        session.setAttribute("authCode", authCode);
        session.setAttribute("authCodeTime", LocalDateTime.now());

        return 0;
    }

    @PostMapping("/findidStart")
    public String findIdStart(@RequestParam("userEmail")String useremail,
                              @RequestParam("usertype")int usertype,
                              @RequestParam(value = "companyno", required = false)String companyno,
                              HttpSession session){

        System.out.println(companyno);
        System.out.println(usertype);
        if(usertype==0){
            //유저아이디를 가져와야함.
            String userid = mapper.getUserId(useremail, usertype);
            //메일을 보내야함.
            if(userid!=null){
                emailService.sendMail(useremail, "커리어캔버스 아이디 찾기", "가입된 아이디 = "+userid);
                session.setAttribute("msg", "작성하신 메일 주소로 아이디를 발송했습니다.");
            }else{
                session.setAttribute("msg", "가입 된 정보가 없습니다.");
            }

            return "alert_page";//여기에 메일 보냈다는 홈페이지로 이동.

        }else{
            //유저 아이디를 가져와야함
            if(companyno!=null){
                String userid = mapper.getUserIdForBiz(useremail,companyno, usertype);
                System.out.println(userid);

                if(userid!=null){
                    emailService.sendMail(useremail, "커리어캔버스 아이디 찾기", "가입된 아이디 = "+userid);
                    session.setAttribute("msg", "작성하신 메일 주소로 아이디를 발송했습니다.");
                }else {
                    session.setAttribute("msg", "가입 된 정보가 없습니다.");
                }
            }else{
                session.setAttribute("msg", "가입 된 정보가 없습니다.");
            }
            return "alert_page";
        }
    }

    @PostMapping("/email/verify")
    @ResponseBody
    public int verifyAuthCode( @RequestParam("emailauth") String authCode, HttpSession session) {
        String sessionAuthCode = (String) session.getAttribute("authCode");
        LocalDateTime sessionAuthCodeTime = (LocalDateTime) session.getAttribute("authCodeTime");

        if (sessionAuthCode == null || sessionAuthCodeTime == null) {
            return 1;//발송x
        }

        if (Duration.between(sessionAuthCodeTime, LocalDateTime.now()).toMinutes() > 5) {
            return 1;//만료
        }

        if (!sessionAuthCode.equals(authCode)) {
            return 2;//틀림
        }

        // 인증 완료 처리
        return 0; // 인증 완료
    }


    private String generateAuthCode() {
        SecureRandom random = new SecureRandom();
        String authCode = "";
        for (int i = 0; i < 6; i++) {
            authCode += random.nextInt(10); // 0~9 사이의 랜덤한 숫자를 생성
        }
        return authCode;
    }
}