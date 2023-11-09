package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.UserMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;

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
    public String login(){
        return "users/login";
    }
    @PostMapping("/loginOk")
    public String loginOk(HttpSession session){
        System.out.println(mapper.loginSelect("goguma"));
        System.out.println("end");
        return "";
    }
}