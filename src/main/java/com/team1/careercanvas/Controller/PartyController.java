package com.team1.careercanvas.Controller;


import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.vo.MemoVO;
import com.team1.careercanvas.vo.PartyVO;
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
public class PartyController {
    private final PartyMapper mapper;

    public PartyController(PartyMapper mapper) {
        this.mapper = mapper;
    }
    //조석훈 시작
    @GetMapping("/party/wanted")
    public ModelAndView partywanted(HttpSession session){
        //파티모집에서 필터할 것, 검색타입(제목, 내용, 파티명), 검색어, 소트(최신, 조회), 카테고리

        ModelAndView mav = new ModelAndView();
        mav.setViewName("party/party_wanted");

        return mav;
    }

    @GetMapping("/party/wanted/write")
    public ModelAndView partywantedwrite(HttpSession session){
        ModelAndView mav = new ModelAndView();
        //로그인한 아이디가 파티장인지 여부 확인 겸 파티장인 파티목록 확인
        List<PartyVO> partylist = mapper.getMineParty((String)session.getAttribute("LogId"));
        if(partylist.size()==0){
            mav.addObject("msg", "파티장만 글 작성이 가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        mav.addObject("pVO", partylist);
        mav.setViewName("party/party_wanted_write");
        return mav;
    }
    //조석훈 끝

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
        PartyVO myteamView = mapper.myteamSelect(vo.get(0).getPartyid());
        List<UserVO> memberList = mapper.SelectMemberList(vo.get(0).getPartyid());
        List<MemoVO> memoListView = mapper.SelectMemoListView(vo.get(0).getPartyid());
        mav.addObject("myteamView", myteamView);
        mav.addObject("memberList", memberList);
        mav.addObject("memoListView", memoListView);
        mav.addObject("pvo",vo);
        mav.addObject("tempno",vo.get(0).getPartyid());
        mav.setViewName("myteam/myteam_main");
        return mav;
    }
    // 정인식 작업 ( 파티 정보 출력 )
    @GetMapping("/myteamView")
    @ResponseBody
    public PartyVO myteamView(@RequestParam("no") int partyid){
        PartyVO myteamView = mapper.myteamSelect(partyid);
        return myteamView;
    }
    @GetMapping("/memberList")
    @ResponseBody
    public List<UserVO> memberList(@RequestParam("no") int partyid){
        List<UserVO> memberList = mapper.SelectMemberList(partyid);
        return memberList;
    }
    @GetMapping("/memoListView")
    @ResponseBody
    public List<MemoVO> memoListView(@RequestParam("no") int partyid){
        List<MemoVO> memoListView = mapper.SelectMemoListView(partyid);
        return memoListView;
    }
    @PostMapping("/memoWriteOK")
    @ResponseBody
    public int memoWriteOK(@RequestParam("no") int partyid,
                              @RequestParam("content") String content,
                              HttpSession session){
        System.out.println("!!"+partyid+", "+content);
        String logId = (String) session.getAttribute("LogId");
           int a =  mapper.InsertMemo(partyid, content, logId);
        return a;
    }

    @PostMapping("/memoDeleteOk")
    @ResponseBody
    public int memoDeleteOk(@RequestParam("target") int target){
        System.out.println("aa");
       int a = mapper.DeleteMemo(target);
       return a;
    }

}
