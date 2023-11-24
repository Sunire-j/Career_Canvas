package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.AdminMapper;
import com.team1.careercanvas.vo.BoardVO;
import com.team1.careercanvas.vo.ReportVO;
import com.team1.careercanvas.vo.SubjectVO;
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

    @GetMapping("/admin/member") // 개인회원관리
    public ModelAndView member(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        List<UserVO> list = mapper.getUserProfile();
        mav.addObject("uVO", list);
        mav.setViewName("/admin/admin_member");

        return mav;
    }

    @GetMapping("/admin/company") // 기업회원관리
    public ModelAndView company(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        mav.setViewName("/admin/admin_company");

        return mav;
    }

    @GetMapping("/admin/board") // 게시판 - 실시간 모니터링
    public ModelAndView board(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        List<BoardVO> list = mapper.getBoardList();
        mav.addObject("bVO", list);
        mav.setViewName("/admin/admin_board");

        return mav;
    }

    @GetMapping("/admin/report") // 신고 게시글 관리
    public ModelAndView report(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        List<ReportVO> list = mapper.getReportList();
        mav.addObject("rVO", list);
        mav.setViewName("admin/report_board");

        return mav;
    }

    @GetMapping("/admin/delete") // 삭제 신청 과제
    public ModelAndView assignment(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        List<SubjectVO> list = mapper.getDeleteList();
        mav.addObject("sVO", list);
        mav.setViewName("admin/delete_assignment");

        return mav;
    }

    @GetMapping("/subject/delete") // 삭제 신청 과제 삭제
    public String deleteAssignment(HttpSession session, int subjectid) {
        int result = mapper.deleteAssignment(subjectid);
        if (result > 0) { // 삭제 성공
            return "redirect:/admin/delete";
        } else { // 삭제 실패
            session.setAttribute("msg", "삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/board/delete") // 모니터링 페이지 게시글 삭제
    public String deleteBoard(HttpSession session, int postid) {
        int result = mapper.deleteBoard(postid);
        if (result > 0) { // 삭제 성공
            return "redirect:/admin/board";
        } else { // 삭제 실패
            session.setAttribute("msg", "삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/report/dismiss") // 기각해서 리포트 테이블만 삭제
    public String dismissReport(HttpSession session, int targetid) {
        int result = mapper.deleteReport(targetid);
        //보드에 삭제
        if (result > 0) { // 삭제 성공
            return "redirect:/admin/report";
        } else { // 삭제 실패
            session.setAttribute("msg", "삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/report/delete") // 리포트 and 포스트 테이블 삭제
    public String deleteReport(HttpSession session, int targetid) {
        int Rresult = mapper.deleteReport(targetid);
        int Bresult = mapper.deleteBoard(targetid);
        // 보드에 삭제
        if (Rresult > 0 && Bresult > 0) { // 삭제 성공
            return "redirect:/admin/report";
        } else { // 삭제 실패
            session.setAttribute("msg", "삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/report/delete/user") // 탈퇴 - 리포트 테이블에서 userid 뽑고, 리포트 앤드 보드 삭제 -> user테이블에서 삭제
    public String reportDeleteUser(HttpSession session, int target_id) {
        String userid = mapper.reporterUser(target_id);
        int Rresult = mapper.deleteReport(target_id);
        int Bresult = mapper.deleteBoard(target_id);
        int Uresult = mapper.deleteUser(userid);

        if (Uresult > 0) {
            if (Rresult > 0 && Bresult > 0) { // 삭제 성공
                return "redirect:/admin/report";
            } else { // 삭제 실패
                session.setAttribute("msg", "삭제 실패했습니다.");
                return "alert_page";
            }
        } else {
            session.setAttribute("msg", "유저 삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/delete/user") // 강제 탈퇴 - 일반회원관리
    public String deleteUser(HttpSession session, String userid) {
        int result = mapper.deleteUser(userid);
        if (result > 0) { // 삭제 성공
            return "redirect:/admin/member";
        } else { // 삭제 실패
            session.setAttribute("msg", "유저 삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/board/delete/user") // 강제 탈퇴 - 실시간 모니터링 강제탈퇴
    public String boardDeleteUser(HttpSession session, int postid) {
        String userid = mapper.getWriterUser(postid);
        int Uresult = mapper.deleteUser(userid);
        mapper.deleteBoard(postid);

        if (Uresult > 0) {
            return "redirect:/admin/board";
        } else {
            session.setAttribute("msg", "유저 삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/change/user") // 닉네임 강제 변경
    public String changeUser(HttpSession session, String username) {
        String changed = "불건전한닉네임" + username;
        System.out.println(changed);
        int result = mapper.changeUsername(username, changed);
        if (result > 0) { // 삭제 성공
            return "redirect:/admin/member";
        } else { // 삭제 실패
            session.setAttribute("msg", "닉네임 변경 실패했습니다.");
            return "alert_page";
        }
    }
}