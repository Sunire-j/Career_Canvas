package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.AdminMapper;
import com.team1.careercanvas.vo.BoardVO;
import com.team1.careercanvas.vo.ReportVO;
import com.team1.careercanvas.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
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

    @GetMapping("/admin/member")
    public ModelAndView member() {
        ModelAndView mav = new ModelAndView();

        List<UserVO> list = mapper.getUserProfile();
        mav.addObject("uVO", list);
        mav.setViewName("/admin/admin_member");

        return mav;
    }

    @GetMapping("/admin/board")
    public ModelAndView board(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        List<BoardVO> list = mapper.getBoardList();
        mav.addObject("bVO", list);
        mav.setViewName("/admin/admin_board");

        System.out.println(session.getAttribute("LogId"));

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        return mav;
    }

    @GetMapping("/admin/report")
    public ModelAndView report(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        List<ReportVO> list = mapper.getReportList();
        mav.addObject("rVO", list);
        mav.setViewName("admin/report_board");

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        return mav;
    }

    @GetMapping("/admin/delete")
    public ModelAndView assignment() {
        ModelAndView mav = new ModelAndView();

        mav.setViewName("admin/delete_assignment");

        return mav;
    }
}