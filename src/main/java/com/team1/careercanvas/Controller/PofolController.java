package com.team1.careercanvas.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.team1.careercanvas.mapper.BoardMapper;
import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.vo.PagingVO;
import com.team1.careercanvas.vo.PartyVO;
import com.team1.careercanvas.vo.PartymemberVO;
import com.team1.careercanvas.vo.PofolVO;
import com.team1.careercanvas.vo.UserVO;

@Controller
public class PofolController {
    private final PofolMapper mapper;
    private final PartyMapper partymapper;

    public PofolController(PofolMapper mapper, PartyMapper partymapper) {
        this.mapper = mapper;
        this.partymapper = partymapper;
    }

    @GetMapping("/pofol_preview")
    public ModelAndView pofol(PagingVO pVO) {
        ModelAndView mav = new ModelAndView();

        pVO.setOnePageRecord(12);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(mapper.getTotalSoloPofol(pVO));

        // Sort
        pVO.setPostSort(pVO.getPostSort());
        pVO.setCategory(pVO.getCategory());

        List<PofolVO> pofolVO = mapper.getPublicSoloPofol(pVO);

        System.out.println(pofolVO);
        System.out.println(pVO);
        mav.addObject("pVO", pVO);
        mav.addObject("pofolVO", pofolVO);
        mav.setViewName("/pofol/pofol_preview_solo");
        return mav;
    }

    @GetMapping("/pofol_preview/team")
    public ModelAndView pofolTeam(HttpSession session, PagingVO pVO) {
        ModelAndView mav = new ModelAndView();

        pVO.setOnePageRecord(12);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(mapper.getTotalTeamPofol(pVO));

        // Sort
        pVO.setPostSort(pVO.getPostSort());
        pVO.setCategory(pVO.getCategory());

        List<PofolVO> pofolVO = mapper.getPublicTeamPofol(pVO);
        List<PartyVO> partyVO = partymapper.getMineParty((String) session.getAttribute("LogId"));
        System.out.println(partyVO);
        System.out.println(pofolVO);
        System.out.println(pVO);
        mav.addObject("partyVO", partyVO);
        mav.addObject("pVO", pVO);
        mav.addObject("pofolVO", pofolVO);
        mav.setViewName("/pofol/pofol_preview_team");
        return mav;
    }

    // @GetMapping("/pofol/write/team")
    // public ModelAndView pofolWriteTeam(HttpSession session) {
    // ModelAndView mav = new ModelAndView();
    // List<PartyVO> partylist = partymapper.getMineParty((String)
    // session.getAttribute("LogId"));
    // List<PartyVO> memberList = mapper.getPartyList((String)
    // session.getAttribute("LogId"));

    // if (partylist.size() == 0) {
    // mav.addObject("msg", "파티장만 글 작성이 가능합니다.");
    // mav.addObject("isBack", 0);
    // mav.setViewName("improve_alert");
    // return mav;
    // }
    // mav.addObject("mList", memberList);
    // mav.setViewName("users/mypage_pofolWrite_team");
    // return mav;
    // }

    // @PostMapping("getpartymember")
    // @ResponseBody
    // public List<UserVO> getpartymember(int partyid) {
    // System.out.println("!!!!");
    // List<UserVO> partymember = mapper.getMemberList(partyid);
    // System.out.println(partymember);
    // return partymember;
    // }
}
