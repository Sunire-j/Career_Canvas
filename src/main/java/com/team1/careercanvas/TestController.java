package com.team1.careercanvas;

import com.team1.careercanvas.mapper.ApplyMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.vo.PofolVO;
import com.team1.careercanvas.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

//이곳의 컨트롤러는 완성 시 삭제될 예정임.
@Controller
public class TestController {
    private final UserMapper usermapper;
    private final PofolMapper pofolmapper;
    public TestController(UserMapper usermapper, PofolMapper pofolmapper) {
        this.usermapper = usermapper;
        this.pofolmapper = pofolmapper;

    }
    @GetMapping("signup_end")
    public String signup_end(){
        //mav
        //db에 업데이트문 보냄
        //아이 뽑

        return "myteam/party/edit";
    }


}

