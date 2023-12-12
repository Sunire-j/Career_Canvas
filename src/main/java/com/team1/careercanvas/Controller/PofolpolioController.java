package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.vo.PofolVO;
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
            mav.addObject("msg","잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        //포폴이 진짜 있는지 확인
        PofolVO pofolVO = pofolmapper.getPofolall(pofolid);
        if(pofolVO==null){
            mav.addObject("msg","삭제되거나 존재하지 않은 포트폴리오입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        if(pofolVO.getIsteam()==0){//파티일경우
            String partyname = partymapper.getPartyName(pofolVO.getPartyid());
            mav.addObject("partyname",partyname);
            // 정인식 작업
            List<UserVO> member = pofolmapper.getMemberList(pofolVO.getPartyid());
            mav.addObject("member", member);
            // 정인식 작업 끝
        }

        //추천수조회
        int thumbsup = pofolmapper.getpofollike(pofolid);

        mav.addObject("pVO", pofolVO);
        mav.addObject("likeamount",thumbsup);

        mav.setViewName("pofol/pofolview");
        return mav;
    }

    @GetMapping("/portfolio/edit")
    public ModelAndView pofolEdit(HttpSession session, int no){
        ModelAndView mav = new ModelAndView();


        PofolVO pofolVO = pofolmapper.getPofolall(no);

        //파티랑 솔로랑 viewname을 바꿔서 보내줘야함
        //파티를 먼저하자
        if(pofolVO.getIsteam()==0){
            String partyname = partymapper.getPartyName(pofolVO.getPartyid());
            mav.addObject("partyname",partyname);
            List<UserVO> member = pofolmapper.getMemberList(pofolVO.getPartyid());
            mav.addObject("member", member);
            //준비물 끝
            mav.addObject("pofolVO", pofolVO);
            mav.setViewName("myteam/myteam_pofol_edit");
            return mav;
        }

        return mav;
    }

    @GetMapping("/pofol/like")
    public ModelAndView pofollike (HttpSession session, int no){
        ModelAndView mav = new ModelAndView();

        if(session.getAttribute("LogId")==null){
            mav.addObject("msg", "로그인 후 추천이 가능합니다.");
            mav.addObject("isBack",1);
            mav.addObject("login");
            return mav;
        }
        String userid = (String) session.getAttribute("LogId");

        int result = pofolmapper.isLike(no, userid);
        if(result == 1){
            mav.addObject("msg", "추천은 한번만 가능합니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        pofolmapper.pofolLike(no, userid);

        mav.setViewName("redirect:/pofolview?pofolid="+no);
        return mav;
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
