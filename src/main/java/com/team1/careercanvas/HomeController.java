package com.team1.careercanvas;

import com.team1.careercanvas.mapper.*;
import com.team1.careercanvas.vo.BannerVO;
import com.team1.careercanvas.vo.PofolVO;
import com.team1.careercanvas.vo.SubjectVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

import static com.team1.careercanvas.util.CreateCookie.createCookie;

@Controller
public class HomeController {


    private final UserMapper usermapper;
    private final PofolMapper pofolmapper;
    private final AdminMapper adminMapper;
    private final PartyMapper partyMapper;
    private final SubjectMapper subjectMapper;
    private final UtilMapper utilMapper;

    public HomeController(UserMapper usermapper, PofolMapper pofolmapper, AdminMapper adminMapper, PartyMapper partyMapper, SubjectMapper subjectMapper, UtilMapper utilMapper) {
        this.usermapper = usermapper;
        this.pofolmapper = pofolmapper;

        this.adminMapper = adminMapper;
        this.partyMapper = partyMapper;
        this.subjectMapper = subjectMapper;
        this.utilMapper = utilMapper;
    }

    @GetMapping("/")
    public ModelAndView home(){
        ModelAndView mav = new ModelAndView();
        //1. 배너이미지 불러오기
        List<BannerVO> list = adminMapper.getBannerList();
        mav.addObject("banner",list);
        //2.인기포트폴리오 초기(1순위 따봉, 2순위 날짜 최근순으로)
        List<PofolVO> plist = pofolmapper.getPortfolioForHome();
        //isteam 1이 개인임
        for(PofolVO templist : plist){
            if(templist.getIsteam()==0){
                //파티명으로 이름 바꿔줘야함
                templist.setUsername(partyMapper.myteamSelect(templist.getPartyid()).getPartyname());
                //파티이미지로 이미지도 바꿔줌
                templist.setProfileimg(partyMapper.myteamSelect(templist.getPartyid()).getPartyimage());
            }
        }
        mav.addObject("plist",plist);

        //3. 최신기업과제 초기(무조건 날짜 최근순)
        List<SubjectVO> slist = subjectMapper.getSubjectForHome();
        mav.addObject("slist", slist);

        mav.setViewName("home");
        return mav;
    }

    @PostMapping("/home/loadsubject")
    @ResponseBody
    public List<SubjectVO> loadNewSubject(int category){
        //카테고리는 0,1,2,3으로 들어올거임
        //그거 맞춰서 4개만 뽑아다주면 됨
        List<SubjectVO> list;
        if(category==0){
            list = subjectMapper.getSubjectForHome();
        }else{
            list = subjectMapper.getSubjectForHomeWithCat(category);
        }
        return list;
    }

    @PostMapping("/home/loadPortfolio")
    @ResponseBody
    public List<PofolVO> loadNewPortfolio(int category){
        List<PofolVO> list;
        if(category==0){
            list = pofolmapper.getPortfolioForHome();
        }else{
            list = pofolmapper.getPortfolioForHomeWithCat(category);
        }

        for(PofolVO templist : list){
            if(templist.getIsteam()==0){
                templist.setUsername(partyMapper.myteamSelect(templist.getPartyid()).getPartyname());
                templist.setProfileimg(partyMapper.myteamSelect(templist.getPartyid()).getPartyimage());
            }
        }
        return list;
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
            utilMapper.increaseCountOrInsert(currentDate);
            //date가 db에 들어갈 날짜


            createCookie(response);
            return "Cookie created";
        }
    }
}
