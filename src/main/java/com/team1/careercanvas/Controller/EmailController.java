package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mail.EmailService;
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

    @Autowired
    private EmailService emailService;

    @PostMapping("/emailsend")
    @ResponseBody
    public int sendEmail(@RequestParam("email") String email, HttpSession session) {
        String authCode = generateAuthCode();
        emailService.sendMail(email, "회원가입 인증 코드", authCode);

        session.setAttribute("authCode", authCode);
        session.setAttribute("authCodeTime", LocalDateTime.now());

        return 0;
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