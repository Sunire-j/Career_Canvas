package com.team1.careercanvas;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
    @RequestMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/test")
    public String test(){
        return "users/mypage";
    }
}
