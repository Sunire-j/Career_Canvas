package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.BoardMapper;
import com.team1.careercanvas.mapper.CommentMapper;
import com.team1.careercanvas.vo.ApplyVO;
import com.team1.careercanvas.vo.BoardVO;
import com.team1.careercanvas.vo.PagingVO;
import com.team1.careercanvas.vo.SubjectVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class BoardController {

    private final BoardMapper mapper;

    public BoardController(BoardMapper mapper, CommentMapper commentMapper) {
        this.mapper = mapper;
    }

    @GetMapping("/board/free")
    public ModelAndView boardFree(HttpSession session,
            @RequestParam(required = false, defaultValue = "0") int category,
            @RequestParam(required = false, defaultValue = "1") int page, // 했음
            @RequestParam(required = false) String searchKey, // 했음
            @RequestParam(required = false) String searchWord, // 했음
            @RequestParam(required = false, defaultValue = "1") int postSort) {// 했음
        ModelAndView mav = new ModelAndView();
        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        pvo.setPostSort(postSort);
        pvo.setBoardcategory(0);
        if (searchWord != null || searchWord != "") {
            pvo.setSearchKey(searchKey);
            pvo.setSearchWord(searchWord);
        }
        List<BoardVO> bvo;
        if (category != 0 && category != 1 && category != 2 && category != 3) {
            mav.setViewName("404pages");
            return mav;
        } else if (category == 0) {// 카테고리가 없으면
            bvo = mapper.getPost(pvo);
            pvo.setTotalRecord(mapper.getPostAmount(pvo));
        } else {// 있으면
            pvo.setCategory(category);
            bvo = mapper.getPostWithCat(pvo);
            pvo.setTotalRecord(mapper.getPostAmountWithCat(pvo));
        }
        // 날짜포맷변경 시작
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        for (BoardVO vo : bvo) {
            LocalDateTime writeDate = LocalDateTime.parse(vo.getDate(), dtf);
            if (writeDate.getYear() != now.getYear()) {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")));
            } else if (writeDate.getMonthValue() != now.getMonthValue()) {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("MM/dd")));
            } else if (writeDate.getDayOfMonth() != now.getDayOfMonth()) {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("MM/dd")));
            } else {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("HH:mm")));
            }
        }
        // 날짜포맷변경 끝

        session.setAttribute("boardcat", "free");
        mav.addObject("pVO", pvo);
        mav.addObject("bVO", bvo);
        mav.setViewName("board/boardList");
        return mav;
    }

    @GetMapping("/board/ask")
    public ModelAndView boardAsk(HttpSession session,
            @RequestParam(required = false, defaultValue = "0") int category,
            @RequestParam(required = false, defaultValue = "1") int page, // 했음
            @RequestParam(required = false) String searchKey, // 했음
            @RequestParam(required = false) String searchWord, // 했음
            @RequestParam(required = false, defaultValue = "1") int postSort) {// 했음
        ModelAndView mav = new ModelAndView();
        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        pvo.setPostSort(postSort);
        pvo.setBoardcategory(1);
        if (searchWord != null || searchWord != "") {
            pvo.setSearchKey(searchKey);
            pvo.setSearchWord(searchWord);
        }
        List<BoardVO> bvo;
        if (category != 0 && category != 1 && category != 2 && category != 3) {
            mav.setViewName("404pages");
            return mav;
        } else if (category == 0) {// 카테고리가 없으면
            bvo = mapper.getPost(pvo);
            pvo.setTotalRecord(mapper.getPostAmount(pvo));
        } else {// 있으면
            pvo.setCategory(category);
            bvo = mapper.getPostWithCat(pvo);
            pvo.setTotalRecord(mapper.getPostAmountWithCat(pvo));
        }
        // 날짜포맷변경 시작
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        for (BoardVO vo : bvo) {
            LocalDateTime writeDate = LocalDateTime.parse(vo.getDate(), dtf);
            if (writeDate.getYear() != now.getYear()) {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")));
            } else if (writeDate.getMonthValue() != now.getMonthValue()) {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("MM/dd")));
            } else if (writeDate.getDayOfMonth() != now.getDayOfMonth()) {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("MM/dd")));
            } else {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("HH:mm")));
            }
        }
        // 날짜포맷변경 끝
        session.setAttribute("boardcat", "ask");
        mav.addObject("pVO", pvo);
        mav.addObject("bVO", bvo);
        System.out.println(bvo);
        mav.setViewName("board/boardList");
        return mav;
    }

    @GetMapping("/board/tip")
    public ModelAndView boardTip(HttpSession session,
            @RequestParam(required = false, defaultValue = "0") int category,
            @RequestParam(required = false, defaultValue = "1") int page, // 했음
            @RequestParam(required = false) String searchKey, // 했음
            @RequestParam(required = false) String searchWord, // 했음
            @RequestParam(required = false, defaultValue = "1") int postSort) {// 했음
        ModelAndView mav = new ModelAndView();
        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        pvo.setPostSort(postSort);
        pvo.setBoardcategory(2);
        if (searchWord != null || searchWord != "") {
            pvo.setSearchKey(searchKey);
            pvo.setSearchWord(searchWord);
        }
        List<BoardVO> bvo;
        if (category != 0 && category != 1 && category != 2 && category != 3) {
            mav.setViewName("404pages");
            return mav;
        } else if (category == 0) {// 카테고리가 없으면
            bvo = mapper.getPost(pvo);
            pvo.setTotalRecord(mapper.getPostAmount(pvo));
        } else {// 있으면
            pvo.setCategory(category);
            bvo = mapper.getPostWithCat(pvo);
            pvo.setTotalRecord(mapper.getPostAmountWithCat(pvo));
        }

        // 날짜포맷변경 시작
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        for (BoardVO vo : bvo) {
            LocalDateTime writeDate = LocalDateTime.parse(vo.getDate(), dtf);
            if (writeDate.getYear() != now.getYear()) {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")));
            } else if (writeDate.getMonthValue() != now.getMonthValue()) {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("MM/dd")));
            } else if (writeDate.getDayOfMonth() != now.getDayOfMonth()) {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("MM/dd")));
            } else {
                vo.setDate(writeDate.format(DateTimeFormatter.ofPattern("HH:mm")));
            }
        }
        // 날짜포맷변경 끝
        session.setAttribute("boardcat", "tip");
        mav.addObject("pVO", pvo);
        mav.addObject("bVO", bvo);
        System.out.println(bvo);
        mav.setViewName("board/boardList");
        return mav;
    }

    @GetMapping("/board/free/write")
    public ModelAndView boardfreewrite(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack",1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }
        session.setAttribute("boardcat", 0);
        mav.setViewName("board/boardWrite");
        return mav;
    }

    @GetMapping("/board/ask/write")
    public ModelAndView boardaskwrite(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack",1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }
        session.setAttribute("boardcat", 1);
        mav.setViewName("board/boardWrite");
        return mav;
    }

    @GetMapping("/board/tip/write")
    public ModelAndView boardtipwrite(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack",1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }
        session.setAttribute("boardcat", 2);
        mav.setViewName("improve_alert");
        return mav;
    }

    @PostMapping("/board/writeOk")
    public String boardwriteOk(HttpSession session, BoardVO vo) {
        vo.setUser_userid((String) session.getAttribute("LogId"));
        mapper.InsertNewPost(vo);
        System.out.println("완료");
        if (vo.getBoardcategory() == 0) {
            return "redirect:/board/free";
        } else if (vo.getBoardcategory() == 1) {
            return "redirect:/board/ask";
        } else if (vo.getBoardcategory() == 2) {
            return "redirect:/board/tip";
        }
        return "404pages";
    }

    @PostMapping("/board/postdel")
    @ResponseBody
    public int deletePost(int postid) {
        int result = mapper.deletePost(postid);
        return result;
    }

    @PostMapping("/board/post_report")
    @ResponseBody
    public int reportPost(int target_id, String target_userid, String target_title, HttpSession session) {
        int result = mapper.reportPost(target_id, target_userid, target_title, (String) session.getAttribute("LogId"));
        return result;
    }

    // 정인식 작업 ( 글 내용보기 )
    @GetMapping("/board/view")
    public ModelAndView boardView(@RequestParam("no") int postid) {
        ModelAndView mav = new ModelAndView();
        int checkForBoardView = mapper.CheckForBoardView(postid);
        System.out.println(checkForBoardView);
        if(checkForBoardView==0){
            mav.setViewName("improve_alert");
            mav.addObject("msg","삭제됐거나, 존재하지 않은 게시글입니다.");
            mav.addObject("isBack", 0);
            return mav;
        }
        mapper.ViewsCount(postid); // 조회수 증가
        BoardVO vo = mapper.SelectBoardView(postid);
        int like = mapper.GetLikeAmount(postid);
        mav.addObject("bvo", vo);
        mav.addObject("postlike", like);
        mav.setViewName("board/boardView");
        return mav;
    }

    // 정인식 작업 ( 글 내용 추천 수 )
    @GetMapping("/board/like")
    public ModelAndView postlike(@RequestParam("no") int postid, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if (session.getAttribute("LogStatus") == null || !session.getAttribute("LogStatus").equals("Y")) {
            mav.addObject("msg", "로그인 후 추천이 가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }
        int result = mapper.CheckValid(postid, (String) session.getAttribute("LogId"));
        if (result == 1) {
            mav.addObject("msg", "추천은 한번만 가능합니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        mapper.LikeCount(postid, (String) session.getAttribute("LogId"));

        mav.setViewName("redirect:/board/view?no=" + postid);
        return mav;
    }

    @GetMapping("/mypage/sendMsgView")
    public String sendMsg() {
        return "users/mypage_sendMsgView";
    }

    // 권혁준 작업
    @GetMapping("/subject")
    public ModelAndView subject(PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        pVO.setOnePageRecord(12);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(mapper.getSubjectListAmount());
        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }
        List<SubjectVO> sVO = mapper.getSubjectList(pVO);

        System.out.println(pVO + "!!!!  ");
        mav.addObject("sVO", sVO);
        mav.addObject("pVO", pVO);
        mav.setViewName("/subject/subjectList");
        return mav;
    }

    @GetMapping("/subject/apply")
    public ModelAndView subjectApply(PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        pVO.setOnePageRecord(12);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(mapper.getSubjectApplyCount());
        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }
        List<ApplyVO> avo = mapper.getSubjectApplyList(pVO);
        System.out.println(pVO);
        mav.addObject("sVO", avo);
        mav.addObject("pVO", pVO);
        mav.setViewName("/subject/subjectApplyList");
        return mav;
    }

    @GetMapping("/subject/apply/team")
    public ModelAndView subjectApplyTeam(PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        pVO.setOnePageRecord(12);
        pVO.setPage(pVO.getPage());
        pVO.setTotalRecord(mapper.getSubjectApplyTeamCount());
        if (pVO.getSearchWord() == null) {
            pVO.setSearchWord("");
        }
        List<ApplyVO> SubjectVO = mapper.getSubjectApplyTeamList(pVO);
        System.out.println(pVO);
        mav.addObject("sVO", SubjectVO);
        mav.addObject("pVO", pVO);
        mav.setViewName("/subject/subjectApplyTeamList");
        return mav;
    }
}
