package com.team1.careercanvas;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

//이곳의 컨트롤러는 완성 시 삭제될 예정임.
@Controller
public class TestController {
    @GetMapping("signup_end")
    public String signup_end(){
        //mav
        //db에 업데이트문 보냄
        return "myteam/myteam_main";
    }
}

