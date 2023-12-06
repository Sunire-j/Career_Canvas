package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.SubjectMapper;
import com.team1.careercanvas.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class SubjectController {

    private final SubjectMapper mapper;

    public SubjectController(SubjectMapper mapper) {
        this.mapper = mapper;
    }

    @GetMapping("/subject/write")
    public ModelAndView subjectWrite(HttpSession session){
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("logStatus");

        UserVO uvo = mapper.SelectCompany(logId);

        if (logStatus != "Y" && logId == null) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        if (uvo == null) {
            mav.addObject("msg", "기업회원만 작성 가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }





        mav.setViewName("company/subjectWrite");

        return mav;
    }
}
