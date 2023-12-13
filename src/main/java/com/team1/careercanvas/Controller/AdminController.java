package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.AdminMapper;
import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
public class AdminController {
    private final AdminMapper mapper;
    private final UserMapper usermapper;

    public AdminController(AdminMapper mapper, UserMapper usermapper) {
        this.mapper = mapper;
        this.usermapper = usermapper;
    }

    @GetMapping("/admin/home")
    public ModelAndView home(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(5);
        pvo.setPage(1);
        pvo.setOffsetPoint(0);
        pvo.setPostSort(4);
        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        mav.addObject("today", mapper.getTodayAccessor());
        mav.addObject("all", mapper.getAllAccessor());
        mav.addObject("rToday", mapper.reportToday());
        mav.addObject("newMember", mapper.todatNewMember());
        List<BoardVO> board = mapper.getBoardList(pvo);
        mav.addObject("bVO", board);

        List<ReportVO> report = mapper.getReportList(pvo);
        mav.addObject("rVO", report);

        List<CompanyVO> company = mapper.getCompanyList(pvo);
        mav.addObject("cVO", company);

        mav.setViewName("/admin/admin_home");

        return mav;
    }

    @GetMapping("/admin/member") // 개인회원관리
    public ModelAndView member(HttpSession session,
                               @RequestParam(required = false, defaultValue = "1") int postSort,
                               @RequestParam(required = false) String searchKey,
                               @RequestParam(required = false) String searchWord,
                               @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        PagingVO pvo = new PagingVO();
        pvo.setSearchKey(searchKey);
        pvo.setSearchWord(searchWord);
        pvo.setPostSort(postSort);
        pvo.setPage(page);
        pvo.setTotalRecord(mapper.getUserCount());

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        List<UserVO> list = mapper.getUserProfile(pvo);
        mav.addObject("uVO", list);
        mav.addObject("pVO", pvo);
        mav.addObject("today", mapper.getTodayAccessor());
        mav.addObject("all", mapper.getAllAccessor());
        mav.setViewName("/admin/admin_member");

        return mav;
    }

    @GetMapping("/admin/board") // 게시판 - 실시간 모니터링 리스트
    public ModelAndView board(HttpSession session,
                              @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        pvo.setTotalRecord(mapper.getBoardCount());

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        List<BoardVO> list = mapper.getBoardList(pvo);
        mav.addObject("bVO", list);
        mav.addObject("pVO", pvo);
        mav.addObject("today", mapper.getTodayAccessor());
        mav.addObject("all", mapper.getAllAccessor());
        mav.setViewName("/admin/admin_board");

        return mav;
    }

    @GetMapping("/admin/report") // 신고 게시글 관리 리스트
    public ModelAndView report(HttpSession session,
                               @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        pvo.setTotalRecord(mapper.getReportCount());

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        List<ReportVO> list = mapper.getReportList(pvo);
        mav.addObject("rVO", list);
        mav.addObject("pVO", pvo);
        mav.addObject("today", mapper.getTodayAccessor());
        mav.addObject("all", mapper.getAllAccessor());
        mav.setViewName("admin/report_board");

        return mav;
    }

    @GetMapping("/admin/delete") // 삭제 신청 과제 리스트
    public ModelAndView assignment(HttpSession session,
                                   @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        pvo.setTotalRecord(mapper.getDeleteCount());

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        List<SubjectVO> list = mapper.getDeleteList(pvo);
        mav.addObject("sVO", list);
        mav.addObject("pVO", pvo);
        mav.addObject("today", mapper.getTodayAccessor());
        mav.addObject("all", mapper.getAllAccessor());
        mav.setViewName("admin/delete_assignment");

        return mav;
    }

    @GetMapping("/subject/delete") // 삭제 신청 과제 삭제
    public String deleteAssignment(HttpSession session, int subjectid) {
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        mapper.dismissSubject(subjectid);
        int result = mapper.deleteAssignment(subjectid);
        if (result > 0) { // 삭제 성공
            return "redirect:/admin/delete";
        } else { // 삭제 실패
            session.setAttribute("msg", "삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/subject/dismiss") // 삭제 신청 과제 거절
    public String dismissAssignment(HttpSession session, int subjectid) {
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        int result = mapper.dismissSubject(subjectid);
        if (result > 0) { // 삭제 성공
            return "redirect:/admin/delete";
        } else { // 삭제 실패
            session.setAttribute("msg", "삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/board/delete") // 모니터링 페이지 게시글 삭제
    public String deleteBoard(HttpSession session, int postid) {
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

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
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        int result = mapper.deleteReport(targetid);
        // 보드에 삭제
        if (result > 0) { // 삭제 성공
            return "redirect:/admin/report";
        } else { // 삭제 실패
            session.setAttribute("msg", "삭제 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/report/delete") // 신고된 글 삭제 버튼 클릭 이벤트
    public String deleteReport(HttpSession session, int targetid, String reporttype) {
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        int Rresult = mapper.deleteReport(targetid);
        if (Rresult > 0) {
            if (reporttype.equals("board")) {
                int Bresult = mapper.deleteBoard(targetid);
                if (Bresult > 0) {
                    return "redirect:/admin/report";
                } else {
                    session.setAttribute("msg", "글 삭제 실패했습니다.");
                    return "alert_page";
                }
            } else if (reporttype.equals("comment")) {
                int Cresult = mapper.deleteComment(targetid);
                if (Cresult > 0) {
                    return "redirect:/admin/report";
                } else {
                    session.setAttribute("msg", "삭제 실패했습니다.");
                    return "alert_page";
                }
            } else if (reporttype.equals("wanted")) {
                int Wresult = mapper.deleteWanted(targetid);
                if (Wresult > 0) {
                    return "redirect:/admin/report";
                } else {
                    session.setAttribute("msg", "삭제 실패했습니다.");
                    return "alert_page";
                }
            } else if (reporttype.equals("wantedcomment")) {
                int WCresult = mapper.deleteWantedComment(targetid);
                if (WCresult > 0) {
                    return "redirect:/admin/report";
                } else {
                    session.setAttribute("msg", "삭제 실패했습니다.");
                    return "alert_page";
                }
            } else if (reporttype.equals("pp")) {
                int Presult = mapper.deletePP(targetid);
                if (Presult > 0) {
                    return "redirect:/admin/report";
                } else {
                    session.setAttribute("msg", "삭제 실패했습니다.");
                    return "alert_page";
                }
            }else if(reporttype.equals("subject")){
                int Sresult = mapper.deleteSubject(targetid);
                if(Sresult>0){
                    return "redirect:/admin/report";
                } else {
                    session.setAttribute("msg", "삭제 실패했습니다.");
                    return "alert_page";
                }
            }
            // ---------------------------- 추가되면 여기다 작업
        } else {
            session.setAttribute("msg", "삭제 실패했습니다.");
            return "alert_page";
        }
        return "redirect:/admin/report";
    }

    @GetMapping("/report/delete/user") // 탈퇴 - 리포트 테이블에서 userid 뽑고, 리포트 앤드 보드 삭제 -> user테이블에서 삭제
    public String reportDeleteUser(HttpSession session, int target_id, String reporttype) {

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        String userid = mapper.reporterUser(target_id);
        int Rresult = mapper.deleteReport(target_id);
        if (Rresult > 0) {
            if (reporttype.equals("board")) {
                int Bresult = mapper.deleteBoard(target_id);
                if (Bresult > 0) {
                    int Uresult = mapper.deleteUser(userid);
                    if (Uresult > 0) {
                        return "redirect:/admin/report";
                    } else {
                        session.setAttribute("msg", "회원 삭제 실패했습니다.");
                        return "alert_page";
                    }
                }
            } else if (reporttype.equals("comment")) {
                int Cresult = mapper.deleteComment(target_id);
                if (Cresult > 0) {
                    int Uresult = mapper.deleteUser(userid);
                    if (Uresult > 0) {
                        return "redirect:/admin/report";
                    } else {
                        session.setAttribute("msg", "회원 삭제 실패했습니다.");
                        return "alert_page";
                    }
                }
            } else if (reporttype.equals("wanted")) {
                int Wresult = mapper.deleteWanted(target_id);
                if (Wresult > 0) {
                    int Uresult = mapper.deleteUser(userid);
                    if (Uresult > 0) {
                        return "redirect:/admin/report";
                    } else {
                        session.setAttribute("msg", "회원 삭제 실패했습니다.");
                        return "alert_page";
                    }
                }
            } else if (reporttype.equals("wantedcomment")) {
                int WCresult = mapper.deleteWantedComment(target_id);
                if (WCresult > 0) {
                    int Uresult = mapper.deleteUser(userid);
                    if (Uresult > 0) {
                        return "redirect:/admin/report";
                    } else {
                        session.setAttribute("msg", "회원 삭제 실패했습니다.");
                        return "alert_page";
                    }
                }
            } else if (reporttype.equals("pp")) {
                int Presult = mapper.deletePP(target_id);
                if (Presult > 0) {
                    int Uresult = mapper.deleteUser(userid);
                    if (Uresult > 0) {
                        return "redirect:/admin/report";
                    } else {
                        session.setAttribute("msg", "회원 삭제 실패했습니다.");
                        return "alert_page";
                    }
                }
            }
            // ---------------------------- 추가되면 여기다 작업
        } else {
            session.setAttribute("msg", "삭제 실패했습니다.");
            return "alert_page";
        }
        return "redirect:/admin/report";
    }

    @GetMapping("/delete/user") // 강제 탈퇴 - 일반회원관리
    public String deleteUser(HttpSession session, String userid) {

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

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

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

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

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        String changed = "불건전한닉네임" + username;
        int result = mapper.changeUsername(username, changed);
        if (result > 0) { // 삭제 성공
            return "redirect:/admin/member";
        } else { // 삭제 실패
            session.setAttribute("msg", "닉네임 변경 실패했습니다.");
            return "alert_page";
        }
    }

    @GetMapping("/admin/user/stats")
    public ModelAndView userStats(HttpSession session) {
        ModelAndView mav = new ModelAndView();


        String logStatus = (String) session.getAttribute("LogStatus");

        if(logStatus==null|| !logStatus.equals("Y")){
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        String logId = (String) session.getAttribute("LogId");
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        mav.addObject("member", mapper.getUserCount());
        mav.addObject("company", mapper.getCompanyCount());
        mav.addObject("newMember", mapper.getNewMember());
        mav.addObject("accessor", mapper.getAccessor());
        mav.addObject("today", mapper.getTodayAccessor());
        mav.addObject("all", mapper.getAllAccessor());
        mav.setViewName("admin/admin_user_stats");
        return mav;
    }

    @GetMapping("/admin/board/stats")
    public ModelAndView boardStats(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        mav.addObject("bVO", mapper.getBoardCount());
        mav.addObject("rVO", mapper.getReportCount());
        mav.addObject("today", mapper.getBoardToday());
        mav.addObject("month", mapper.getBoardMonth());
        mav.addObject("category", mapper.getBoardCategory());
        mav.addObject("today", mapper.getTodayAccessor());
        mav.addObject("all", mapper.getAllAccessor());
        mav.setViewName("admin/admin_board_stats");
        return mav;
    }

    // 권혁준 작업
    @GetMapping("/admin/banner")
    public ModelAndView banner(PagingVO pVO, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        List<BannerVO> bVO = mapper.getBannerList();
        pVO.setOnePageRecord(10);
        pVO.setTotalRecord(mapper.getBannerAmount(pVO));
        pVO.setPage(pVO.getPage());

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        mav.addObject("bannerVO", bVO);
        mav.addObject("today", mapper.getTodayAccessor());
        mav.addObject("all", mapper.getAllAccessor());
        mav.setViewName("/admin/admin_banner");
        return mav;
    }

    //조석훈 작업
    @GetMapping("/admin/banner/add")
    public String banner_add(HttpSession session) {

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        List<BannerVO> list = mapper.getBannerList();
        if (list.size() >= 10) {
            return "redirect:/admin/banner";
        }
        return "admin/admin_banner_add";
    }

    @PostMapping("/admin/banner/addOk")
    public String banner_addOk(String startdate,
                               String deadline,
                               String owner,
                               MultipartFile bannerimg) {
        BannerVO bvo = new BannerVO();
        bvo.setStartdate(startdate);
        bvo.setDeadline(deadline);
        bvo.setOwner(owner);
        int result = mapper.InsertBanner(bvo);
        if (!bannerimg.isEmpty()) {
            // 파일저장시작
            String extension = bannerimg.getOriginalFilename().substring(bannerimg.getOriginalFilename().lastIndexOf("."));
            String newFileName = bvo.getBannerid() + "_" + extension;
            String projectDir = new File("").getAbsolutePath();
            File directory = new File(projectDir + "/upload/bannerimg");
            if (!directory.exists()) {
                directory.mkdirs(); // 디렉토리 생성
            }

            Path path = Paths.get(directory.getAbsolutePath(), newFileName); // 절대 경로를 사용

            try {
                bannerimg.transferTo(new File(path.toString()));
            } catch (IOException e) {
                e.printStackTrace();
                return "404pages";
            }
            // 파일저장 끝

            // db에 경로넣기
            String imgsrc = "/bannerimg/" + newFileName;

            mapper.InsertBannerimg(imgsrc, bvo.getBannerid());
        }
        //일단 insert는 했는데 bannerid를 얻어내서 이미지를 업로드하고 db에 또 반영해야함

        return "redirect:/admin/banner";
    }

    @GetMapping("/admin/banner/check")
    public ModelAndView checkBanner(HttpSession session, int bannerid) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        String bannerimg = mapper.getBannerImg(bannerid);

        mav.addObject("imgsrc", bannerimg);
        mav.setViewName("/admin/image_popup");
        return mav;
    }

    @GetMapping("/admin/banner/delete")
    public String delBanner(int bannerid, HttpSession session) {
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        UserVO uvo = usermapper.getUser((String) session.getAttribute("LogId"));
        if (uvo.getUsertype() != 2) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        mapper.deleteBanner(bannerid);
        return "redirect:/admin/banner";
    }

    @GetMapping("/admin/company") // 기업회원관리
    public ModelAndView company(HttpSession session, PagingVO pvo) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        String name = mapper.getAdminName((String) session.getAttribute("LogId"));
        mav.addObject("name", name);

        //기업회원 select하고
        //onepagerecord 15로 그대로 쓰기
        pvo.setTotalRecord(mapper.getCompanyCount());
        List<CompanyVO> list = mapper.getCompanyList(pvo);
        //mav에 넣기

        mav.addObject("cVO", list);
        mav.addObject("pVO", pvo);
        mav.addObject("today", mapper.getTodayAccessor());
        mav.addObject("all", mapper.getAllAccessor());

        mav.setViewName("/admin/admin_company");

        return mav;
    }

    @GetMapping("/admin/company/check")
    public ModelAndView checkAuth(HttpSession session, String uid) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int usertype = mapper.getUsertype(logId);
        if ( usertype != 2) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        String imgsrc = mapper.getAuthimg(uid);

        mav.addObject("imgsrc", imgsrc);
        mav.setViewName("admin/image_popup");
        return mav;
    }

    @GetMapping("/admin/company/accept")
    public String acceptCompany(String uid, HttpSession session) {
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        UserVO uvo = usermapper.getUser((String) session.getAttribute("LogId"));
        if (uvo.getUsertype() != 2) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }

        mapper.acceptCompany(uid);

        return "redirect:/admin/company";
    }

    @GetMapping("/admin/company/deny")
    public String denyCompany(String uid, HttpSession session) {
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        UserVO uvo = usermapper.getUser((String) session.getAttribute("LogId"));
        if (uvo.getUsertype() != 2) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        mapper.denyCompany(uid);

        return "redirect:/admin/company";
    }

    @GetMapping("/admin/company/forceDelete")
    public String forceDelete(String uid, HttpSession session) {
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if ( logId == null || !logStatus.equals("Y")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }
        int usertype = mapper.getUsertype(logId);
        if(usertype!=2){
            session.setAttribute("msg", "잘못된 접근입니다.");
            session.setAttribute("isBack",0);
            return "improve_alert";
        }

        UserVO uvo = usermapper.getUser((String) session.getAttribute("LogId"));
        if (uvo.getUsertype() != 2) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        mapper.denyCompany(uid);

        return "redirect:/admin/company";
    }

}