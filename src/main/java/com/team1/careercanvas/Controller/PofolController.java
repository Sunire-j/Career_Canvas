package com.team1.careercanvas.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.team1.careercanvas.mapper.BoardMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.vo.PagingVO;
import com.team1.careercanvas.vo.PofolVO;

@Controller
public class PofolController {
    private final PofolMapper mapper;

    public PofolController(PofolMapper mapper) {
        this.mapper = mapper;
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
    public ModelAndView pofolTeam(PagingVO pVO) {
        ModelAndView mav = new ModelAndView();

        pVO.setOnePageRecord(12);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(mapper.getTotalTeamPofol(pVO));

        // Sort
        pVO.setPostSort(pVO.getPostSort());
        pVO.setCategory(pVO.getCategory());

        List<PofolVO> pofolVO = mapper.getPublicTeamPofol(pVO);
        System.out.println(pofolVO);
        mav.addObject("pVO", pVO);
        mav.addObject("pofolVO", pofolVO);
        mav.setViewName("/pofol/pofol_preview_team");
        return mav;
    }
}
