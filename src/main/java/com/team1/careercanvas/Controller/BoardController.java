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


    @GetMapping("/board/free")
    public String boardFree(HttpSession session){
        session.setAttribute("boardcat", "free");
        return "board/boardList";
    }
    @GetMapping("/board/ask")
    public String boardAsk(HttpSession session){
        session.setAttribute("boardcat", "ask");
        return "board/boardList";
    }
    @GetMapping("/board/tip")
    public String boardTip(HttpSession session){
        session.setAttribute("boardcat", "tip");
        return "board/boardList";
    }

    @GetMapping("/board/free/write")
    public String boardfreewrite(HttpSession session){
        if(session.getAttribute("LogStatus")==null || session.getAttribute("LogStatus").equals("N")){
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        session.setAttribute("boardcat", 0);
        return "board/boardWrite";
    }

    @GetMapping("/board/ask/write")
    public String boardaskwrite(HttpSession session){
        if(session.getAttribute("LogStatus")==null || session.getAttribute("LogStatus").equals("N")){
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        session.setAttribute("boardcat", 1);
        return "board/boardWrite";
    }

    @GetMapping("/board/tip/write")
    public String boardtipwrite(HttpSession session){
        if(session.getAttribute("LogStatus")==null || session.getAttribute("LogStatus").equals("N")){
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        session.setAttribute("boardcat", 2);
        return "board/boardWrite";
    }

    @PostMapping("/board/writeOk")
    public String boardwriteOk(HttpSession session,
                               BoardVO vo){
        vo.setUserid((String) session.getAttribute("LogId"));
        mapper.InsertNewPost(vo);
        System.out.println("완료");
        if(vo.getBoardcategory()==0){
            return "redirect:/board/free";
        }else if(vo.getBoardcategory()==1){
            return "redirect:/board/ask";
        }else if(vo.getBoardcategory()==2){
            return "redirect:/board/tip";
        }
        return "404pages";
    }
}
