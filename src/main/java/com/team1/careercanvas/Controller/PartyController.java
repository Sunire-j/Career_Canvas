package com.team1.careercanvas.Controller;


import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.vo.PartyVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class PartyController {
    private final PartyMapper mapper;

    public PartyController(PartyMapper mapper) {
        this.mapper = mapper;
    }

    // 정인식 작업
    @GetMapping("/myteam/main")
    public ModelAndView myteamMain(HttpSession session){
        ModelAndView mav = new ModelAndView();
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("logStatus");
        if (logStatus != "Y" && logId == null) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.setViewName("redirect:/");
            //mav.setViewName("alert_page");
            return mav;
        }
        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mav.addObject("pvo",vo);
        mav.setViewName("myteam/myteam_main");
        return mav;
    }
    // 정인식 작업 ( 파티 정보 출력 )
    @GetMapping("/myteamView")
    public PartyVO myteamView(int no){
        PartyVO myteamView = mapper.myteamSelect(no);

        return myteamView;
    }
}
