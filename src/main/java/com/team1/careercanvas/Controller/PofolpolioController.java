package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.vo.PartyVO;
import com.team1.careercanvas.vo.PofolVO;
import com.team1.careercanvas.vo.ReportVO;
import com.team1.careercanvas.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

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
            // 정인식 작업
            List<UserVO> member = pofolmapper.getMemberList(pofolVO.getPartyid());
            mav.addObject("member", member);
            // 정인식 작업 끝
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
    @GetMapping("/pofol/like")
    public String pofollike (HttpSession session, int no){
        if(session.getAttribute("LogId")==null){
            session.setAttribute("msg", "잘못된 접근입니다.");

            return "alert_page";
        }
        String userid = (String) session.getAttribute("LogId");

        int result = pofolmapper.isLike(no, userid);
        if(result == 1){
            session.setAttribute("msg", "추천은 한번만 가능합니다.");

            return "alert_page";
        }
        pofolmapper.pofolLike(no, userid);

        return "redirect:/pofolview?pofolid="+no;
    }
    @PostMapping("/pofol/pofol_report")
    @ResponseBody
    public int pofol_report(int target_id, String target_userid, String target_title, HttpSession session){

        String userid = (String)session.getAttribute("LogId");
        pofolmapper.reportPofol(target_id, target_userid, target_title, userid);

        return 0;
    }
    @PostMapping("/pofol/postdel")
    @ResponseBody
    public int deletePost(int pofolid) {
        int result = pofolmapper.deletePofol(pofolid);

        return result;
    }
}
