package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.AdminMapper;
import com.team1.careercanvas.vo.BoardVO;
import com.team1.careercanvas.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class AdminController {
    private final AdminMapper mapper;

    public AdminController(AdminMapper mapper) {
        this.mapper = mapper;
    }

    @GetMapping("/admin/company")
    public String company() {
        return "admin/admin_company";
    }


    @GetMapping("/admin/report")
    public String report() {
        return "admin/report_board";
    }

    @GetMapping("/admin/delete")
    public String assignment() {
        return "admin/delete_assignment";
    }

    @GetMapping("/admin/member")
    public ModelAndView member() {
        ModelAndView mav = new ModelAndView();

        List<UserVO> list = mapper.getUserProfile();
        mav.addObject("uVO",list);
        mav.setViewName("/admin/admin_member");

        return mav;
    }

    @GetMapping("/admin/board")
    public ModelAndView board() {
        ModelAndView mav=new ModelAndView();

        List<BoardVO> list=mapper.getBoardList();
        mav.addObject("bVO",list);
        mav.setViewName("/admin/admin_board");

        return mav;
    }
}