package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.vo.PartyVO;
import com.team1.careercanvas.vo.PofolVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class PofolpolioController {

    private final PofolMapper pofolmapper;
    private final PartyMapper partymapper;
    public PofolpolioController(PofolMapper pofolmapper, PartyMapper partymapper) {
        this.pofolmapper = pofolmapper;
        this.partymapper = partymapper;
    }


    @GetMapping("/pofolview")
    public ModelAndView pofolview(HttpSession session,
                                  @RequestParam(required = false, defaultValue = "0") int pofolid){
        ModelAndView mav = new ModelAndView();
        if(pofolid==0){
            session.setAttribute("msg","잘못된 접근입니다.");
            mav.setViewName("alert_page");
            return mav;
        }

        PofolVO pofolVO = pofolmapper.getPofolall(pofolid);
        if(pofolVO.getIsteam()==0){//파티일경우
            String partyname = partymapper.getPartyName(pofolVO.getPartyid());
            mav.addObject("partyname",partyname);
        }

        if(pofolVO==null){
            session.setAttribute("msg","잘못된 접근입니다.");
            mav.setViewName("alert_page");
            return mav;
        }

        //추천수조회
        int thumbsup = pofolmapper.getpofollike(pofolid);

        mav.addObject("pVO", pofolVO);
        mav.addObject("likeamount",thumbsup);

        mav.setViewName("pofol/pofolview");
        return mav;
    }
}
