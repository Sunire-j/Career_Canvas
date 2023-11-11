package com.team1.careercanvas.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TeamController {
    @GetMapping("/myteam/main")
    public String myteam(){
        return "myteam/myteam_main";
    }
}
