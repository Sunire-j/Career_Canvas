package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.BoardMapper;
import com.team1.careercanvas.vo.BoardVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;

@Controller
public class BoardController {

    private final BoardMapper mapper;

    public BoardController(BoardMapper mapper) {
        this.mapper = mapper;
    }


    @GetMapping("/board")
    public String board(){
        return "board/boardList";
    }

    @GetMapping("/board/write")
    public String boardwrite(HttpSession session){
        if(session.getAttribute("LogStatus")==null || session.getAttribute("LogStatus").equals("N")){
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        return "board/boardWrite";
    }

    @PostMapping("/board/writeOk")
    public String boardwriteOk(HttpSession session,
                               BoardVO vo){
        vo.setUserid((String) session.getAttribute("LogId"));
        mapper.InsertNewPost(vo);
        System.out.println("완료");
        return "";
    }
}
