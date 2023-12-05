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
import com.team1.careercanvas.vo.PofolVO;

@Controller
public class PofolController {
    private final PofolMapper mapper;

    public PofolController(PofolMapper mapper) {
        this.mapper = mapper;
    }

    @GetMapping("/pofol_preview")
    public ModelAndView pofol(@RequestParam(required = false, value = "category") String category) {
        ModelAndView mav = new ModelAndView();

        List<PofolVO> pofolVO = mapper.getBestPofol(category);

        mav.addObject("pofolVO", pofolVO);
        mav.setViewName("/pofol/pofol_preview");
        return mav;
    }

    @ResponseBody
    @GetMapping("/pofol_solo")
    public List<PofolVO> solo(@RequestParam(required = false, value = "category") String category) {
        List<PofolVO> pofol = mapper.getBestPofol(category);
        System.out.println(pofol);
        return pofol;
    }
}
