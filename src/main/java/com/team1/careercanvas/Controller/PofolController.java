package com.team1.careercanvas.Controller;

import java.util.ArrayList;
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
        List<PofolVO> pofolVO = mapper.getCategoryPofol(pVO);
        System.out.println(pofolVO);
        mav.addObject("pofolVO", pofolVO);
        mav.setViewName("/pofol/pofol_preview");
        return mav;
    }
}
