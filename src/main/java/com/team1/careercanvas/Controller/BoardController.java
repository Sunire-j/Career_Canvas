package com.team1.careercanvas.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardController {

    @GetMapping("/board")
    public String board(){
        return "board/boardList";
    }

    @GetMapping("/board/write")
    public String boardwrite(){
        return "board/boardWrite";
    }
}
