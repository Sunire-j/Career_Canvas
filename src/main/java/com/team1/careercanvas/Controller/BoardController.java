package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.BoardMapper;
import com.team1.careercanvas.vo.BoardVO;
import com.team1.careercanvas.vo.PagingVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BoardController {

    private final BoardMapper mapper;

    public BoardController(BoardMapper mapper) {
        this.mapper = mapper;
    }


    @GetMapping("/board/free")
    public ModelAndView boardFree(HttpSession session,
                                  @RequestParam(required = false, defaultValue = "0") int category,
                                  @RequestParam(required = false,defaultValue = "1") int page,//했음
                                  @RequestParam(required = false)String searchKey,//했음
                                  @RequestParam(required = false)String searchWord,//했음
                                  @RequestParam(required = false, defaultValue = "1")int postSort) {//했음
        ModelAndView mav = new ModelAndView();
        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        pvo.setPostSort(postSort);
        pvo.setBoardcategory(0);
        if(searchWord!=null || searchWord!=""){
            pvo.setSearchKey(searchKey);
            pvo.setSearchWord(searchWord);
        }
        List<BoardVO> bvo;
        if (category != 0 && category != 1 && category != 2 && category != 3) {
            mav.setViewName("404pages");
            return mav;
        }else if(category==0){//카테고리가 없으면
            bvo= mapper.getPost(pvo);
            pvo.setTotalRecord(mapper.getPostAmount(pvo));
        }else{//있으면
            pvo.setCategory(category);
            bvo=mapper.getPostWithCat(pvo);
            pvo.setTotalRecord(mapper.getPostAmountWithCat(pvo));
        }
        session.setAttribute("boardcat", "free");
        mav.addObject("pVO",pvo);
        mav.addObject("bVO",bvo);
        mav.setViewName("board/boardList");
        return mav;
    }

    @GetMapping("/board/ask")
    public ModelAndView boardAsk(HttpSession session,
                                  @RequestParam(required = false, defaultValue = "0") int category,
                                  @RequestParam(required = false,defaultValue = "1") int page,//했음
                                  @RequestParam(required = false)String searchKey,//했음
                                  @RequestParam(required = false)String searchWord,//했음
                                  @RequestParam(required = false, defaultValue = "1")int postSort) {//했음
        ModelAndView mav = new ModelAndView();
        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        pvo.setPostSort(postSort);
        pvo.setBoardcategory(1);
        if(searchWord!=null || searchWord!=""){
            pvo.setSearchKey(searchKey);
            pvo.setSearchWord(searchWord);
        }
        List<BoardVO> bvo;
        if (category != 0 && category != 1 && category != 2 && category != 3) {
            mav.setViewName("404pages");
            return mav;
        }else if(category==0){//카테고리가 없으면
            bvo= mapper.getPost(pvo);
        }else{//있으면
            pvo.setCategory(category);
            bvo=mapper.getPostWithCat(pvo);
        }
        pvo.setTotalRecord(bvo.size());

        session.setAttribute("boardcat", "ask");
        mav.addObject("pVO",pvo);
        mav.addObject("bVO",bvo);
        System.out.println(bvo);
        mav.setViewName("board/boardList");
        return mav;
    }

    @GetMapping("/board/tip")
    public ModelAndView boardTip(HttpSession session,
                                 @RequestParam(required = false, defaultValue = "0") int category,
                                 @RequestParam(required = false,defaultValue = "1") int page,//했음
                                 @RequestParam(required = false)String searchKey,//했음
                                 @RequestParam(required = false)String searchWord,//했음
                                 @RequestParam(required = false, defaultValue = "1")int postSort) {//했음
        ModelAndView mav = new ModelAndView();
        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        pvo.setPostSort(postSort);
        pvo.setBoardcategory(2);
        if(searchWord!=null || searchWord!=""){
            pvo.setSearchKey(searchKey);
            pvo.setSearchWord(searchWord);
        }
        List<BoardVO> bvo;
        if (category != 0 && category != 1 && category != 2 && category != 3) {
            mav.setViewName("404pages");
            return mav;
        }else if(category==0){//카테고리가 없으면
            bvo= mapper.getPost(pvo);
        }else{//있으면
            pvo.setCategory(category);
            bvo=mapper.getPostWithCat(pvo);
        }
        pvo.setTotalRecord(bvo.size());
        session.setAttribute("boardcat", "tip");
        mav.addObject("pVO",pvo);
        mav.addObject("bVO",bvo);
        System.out.println(bvo);
        mav.setViewName("board/boardList");
        return mav;
    }

    @GetMapping("/board/free/write")
    public String boardfreewrite(HttpSession session) {
        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        session.setAttribute("boardcat", 0);
        return "board/boardWrite";
    }

    @GetMapping("/board/ask/write")
    public String boardaskwrite(HttpSession session) {
        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        session.setAttribute("boardcat", 1);
        return "board/boardWrite";
    }

    @GetMapping("/board/tip/write")
    public String boardtipwrite(HttpSession session) {
        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            session.setAttribute("msg", "잘못된 접근입니다.");
            return "alert_page";
        }
        session.setAttribute("boardcat", 2);
        return "board/boardWrite";
    }

    @PostMapping("/board/writeOk")
    public String boardwriteOk(HttpSession session,
                               BoardVO vo) {
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

    // 정인식 작업 ( 글 내용보기 )
    @GetMapping("/board/view")
    public ModelAndView boardView(@RequestParam("no") int postid){
        ModelAndView mav = new ModelAndView();
        mapper.ViewsCount(postid); // 조회수 증가
        BoardVO vo = mapper.SelectBoardView(postid);
        int like = mapper.GetLikeAmount(postid);
        mav.addObject("bvo",vo);
        mav.addObject("postlike", like);
        mav.setViewName("board/boardView");
        return mav;
    }

    // 정인식 작업 ( 글 내용 추천 수 )
    @GetMapping("/board/like")
    public String postlike(@RequestParam("no") int postid, HttpSession session){
        if(session.getAttribute("LogStatus") == null || !session.getAttribute("LogStatus").equals("Y")){
            session.setAttribute("msg", "로그인 후 추천이 가능합니다.");
            return "alert_page";
        }
        int result=mapper.CheckValid(postid, (String) session.getAttribute("LogId"));
        if(result==1){
            session.setAttribute("msg", "추천은 한번만 가능합니다.");
            return "alert_page";
        }
        mapper.LikeCount(postid, (String) session.getAttribute("LogId"));

        return "redirect:/board/view?no="+postid;
    }
}
