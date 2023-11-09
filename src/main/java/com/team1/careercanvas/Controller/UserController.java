package com.team1.careercanvas.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
    @GetMapping("findid")
    public String findid(){
        return "users/findid";
    }
    @GetMapping("/findpw")
    public String findpw(){
        return "users/findpw";
    }
}
