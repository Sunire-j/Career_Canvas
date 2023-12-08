package com.team1.careercanvas;

import com.team1.careercanvas.mapper.AdminMapper;
import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.vo.BannerVO;
import com.team1.careercanvas.vo.PofolVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

//이곳의 컨트롤러는 완성 시 삭제될 예정임.
@Controller
public class TestController {
    private final UserMapper usermapper;
    private final PofolMapper pofolmapper;
    private final AdminMapper adminMapper;
    private final PartyMapper partyMapper;
    public TestController(UserMapper usermapper, PofolMapper pofolmapper, AdminMapper adminMapper, PartyMapper partyMapper) {
        this.usermapper = usermapper;
        this.pofolmapper = pofolmapper;

        this.adminMapper = adminMapper;
        this.partyMapper = partyMapper;
    }

    @GetMapping("/temp_home")
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

        mav.setViewName("home");
        return mav;
    }


}

