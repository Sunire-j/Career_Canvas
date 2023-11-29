package com.team1.careercanvas;

import com.team1.careercanvas.mapper.UtilMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;

import static com.team1.careercanvas.util.CreateCookie.createCookie;

@Controller
public class HomeController {

    private final UtilMapper utilmapper;

    public HomeController(UtilMapper utilmapper) {
        this.utilmapper = utilmapper;
    }

    @RequestMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/test")
    public String test(){
        return "users/mypage";
    }

    @GetMapping("/createCookie")
    @ResponseBody
    public String CreateCookie(HttpServletResponse response,
                               @CookieValue(value = "today", defaultValue = "")String cookievalue) {
        // 쿠키 생성 로직
        if(cookievalue.equals("check")){
            return "already_visited";
        }else{
            //db에서 방문자수 늘리기
            Date currentDate = new Date();
            utilmapper.increaseCountOrInsert(currentDate);
            //date가 db에 들어갈 날짜


            createCookie(response);
            return "Cookie created";
        }
    }
}
