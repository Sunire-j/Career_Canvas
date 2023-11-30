package com.team1.careercanvas.Controller;


import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class PartyController {
    private final PartyMapper mapper;

    public PartyController(PartyMapper mapper) {
        this.mapper = mapper;
    }
    //조석훈 시작
    @GetMapping("/party/wanted")
    public ModelAndView partywanted(HttpSession session,
                                    @RequestParam(required = false, defaultValue = "1")int page,
                                    @RequestParam(required = false)String searchWord,
                                    @RequestParam(required = false)String searchKey,
                                    @RequestParam(required = false, defaultValue = "1")int postSort){
        //파티모집에서 필터할 것, 검색타입(제목, 내용, 파티명), 검색어, 소트(최신, 조회), 카테고리

        ModelAndView mav = new ModelAndView();
        PagingVO pvo = new PagingVO();

        pvo.setOnePageRecord(10);
        pvo.setPage(page);
        if(searchWord!=null||searchWord!=""){
            pvo.setSearchKey(searchKey);
            pvo.setSearchWord(searchWord);
        }
        pvo.setPostSort(postSort);
        pvo.setTotalRecord(mapper.getWantedListCount(pvo));
        List<WantedVO> wvo = mapper.GetWantedList(pvo);

        mav.addObject("wVO",wvo);
        mav.addObject("pVO", pvo);
        mav.setViewName("party/party_wanted");

        return mav;
    }

    @GetMapping("/party/wanted/write")
    public ModelAndView partywantedwrite(HttpSession session){
        ModelAndView mav = new ModelAndView();
        //로그인한 아이디가 파티장인지 여부 확인 겸 파티장인 파티목록 확인
        List<PartyVO> partylist = mapper.getMineParty((String)session.getAttribute("LogId"));
        if(partylist.size()==0){
            mav.addObject("msg", "파티장만 글 작성이 가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        mav.addObject("pVO", partylist);
        mav.setViewName("party/party_wanted_write");
        return mav;
    }

    @PostMapping("/party/wanted/writeOk")
    public String wantedWriteOk(WantedVO wVO, HttpSession session){
        wVO.setUser_userid((String) session.getAttribute("LogId"));
        //준비 끝 db보내고 게시판으로 보내주면 됨.
        mapper.InsertWanted(wVO);
        return "redirect:/party/wanted";
    }

    @GetMapping("/party/wanted/view")
    public ModelAndView wantedView(int no){
        ModelAndView mav = new ModelAndView();
        //no글 선택
        mapper.increseView(no);
        WantedVO wvo = mapper.GetWantedView(no);
        wvo.setPartyname(mapper.getPartyName(wvo.getParty_partyid()));
        mav.addObject("wvo", wvo);
        mav.setViewName("party/party_wanted_view");

        return mav;
    }

    @PostMapping("/party/commentLoad")
    @ResponseBody
    public List<CommentVO> commendLoad(int no){
        List<CommentVO> list = mapper.commentLoad(no);
        return list;
    }

    @PostMapping("/party/commentWrite")
    @ResponseBody
    public int commentWrite(HttpSession session,
                            CommentVO cvo){
        cvo.setUser_userid((String) session.getAttribute("LogId"));
        cvo.setDepth(0);
        if(cvo.getTarget_parent()>0){
            cvo.setDepth(1);
        }
        int result = mapper.replyInsert(cvo);
        if (cvo.getDepth() == 0) {
            mapper.replyInsertTP(cvo);
        }
        return result;
    }

    @PostMapping("/party/wanteddel")
    @ResponseBody
    public String wanteddel(int wantedid){
        int result = mapper.DeleteWanted(wantedid);
        System.out.println(result);
        return "";
    }

    @PostMapping("/party/wanted/report")
    @ResponseBody
    public int reportwanted(int target_id, String target_userid, String target_title,
                            HttpSession session){
        //신고자
        String userid = (String) session.getAttribute("LogId");
        int result = mapper.reportWanted(target_id, target_userid, target_title, userid);
        System.out.println(result);
        return result;
    }

    @PostMapping("/party/comment/report")
    @ResponseBody
    public int reportwantedcomment(int originpostid, int targetid, HttpSession session){
        String uid = (String) session.getAttribute("LogId");
        String userid = mapper.getCommentWriter(targetid);
        String commentcontent = mapper.getCommentcontent(targetid);
        if (commentcontent.length() > 40) {
            commentcontent = commentcontent.substring(0, 40);
        }
        ReportVO rvo = new ReportVO();
        rvo.setReporttype("wantedcomment");
        rvo.setUser_userid(uid);
        rvo.setUserid(userid);
        rvo.setTitle(commentcontent);
        rvo.setOriginpostid(originpostid);
        rvo.setTargetid(targetid);

        int result = mapper.commentReport(rvo);
        System.out.println(result);
        return result;
    }

    @PostMapping("/party/wanted/commentdel")
    @ResponseBody
    public int wantedcommentdel(int commentid){
        int result = mapper.deleteWantedComment(commentid);
        System.out.println(result);
        return result;
    }

    @PostMapping("/party/apply")
    @ResponseBody
    public int applyParty(HttpSession session, int partyid){
        String uid = (String) session.getAttribute("LogId");
        int result = mapper.applyParty(uid,partyid);
        return result;
    }
    //조석훈 끝

    // 정인식 작업
    @GetMapping("/myteam/main")
    public ModelAndView myteamMain(HttpSession session){
        ModelAndView mav = new ModelAndView();
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("logStatus");
        if (logStatus != "Y" && logId == null) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        List<PartyVO> vo = mapper.SelectPartyList(logId);

        if (vo.isEmpty()) {
            mav.addObject("msg", "가입한 파티가 없습니다.");
            mav.setViewName("myteam/party_empty_alert");
            return mav;
        }

        PartyVO myteamView = mapper.myteamSelect(vo.get(0).getPartyid());
        List<UserVO> memberList = mapper.SelectMemberList(vo.get(0).getPartyid());
        List<MemoVO> memoListView = mapper.SelectMemoListView(vo.get(0).getPartyid());
        mav.addObject("myteamView", myteamView);
        mav.addObject("memberList", memberList);
        mav.addObject("memoListView", memoListView);
        mav.addObject("pvo",vo);
        mav.addObject("tempno",vo.get(0).getPartyid());
        mav.setViewName("myteam/myteam_main");


        return mav;
    }
    // 정인식 작업 ( 파티 정보 출력 )
    @GetMapping("/myteamView")
    @ResponseBody
    public PartyVO myteamView(@RequestParam("no") int partyid){
        PartyVO myteamView = mapper.myteamSelect(partyid);
        return myteamView;
    }
    @GetMapping("/memberList")
    @ResponseBody
    public List<UserVO> memberList(@RequestParam("no") int partyid){
        List<UserVO> memberList = mapper.SelectMemberList(partyid);
        return memberList;
    }
    @GetMapping("/memoListView")
    @ResponseBody
    public List<MemoVO> memoListView(@RequestParam("no") int partyid){
        List<MemoVO> memoListView = mapper.SelectMemoListView(partyid);
        return memoListView;
    }
    @PostMapping("/memoWriteOK")
    @ResponseBody
    public int memoWriteOK(@RequestParam("no") int partyid,
                              @RequestParam("content") String content,
                              HttpSession session){
        System.out.println("!!"+partyid+", "+content);
        String logId = (String) session.getAttribute("LogId");
           int a =  mapper.InsertMemo(partyid, content, logId);
        return a;
    }

    @PostMapping("/memoDeleteOk")
    @ResponseBody
    public int memoDeleteOk(@RequestParam("target") int target){
        System.out.println("aa");
       int a = mapper.DeleteMemo(target);
       return a;
    }

    @PostMapping("/myteam/create")
    public ModelAndView createTeam(@RequestParam("input_name") String partyname,
                             @RequestParam("ex_file") MultipartFile file,
                             @RequestParam("input_objective") String objective,
                             @RequestParam("input_intro") String intro,
                             HttpSession session){
        ModelAndView mav = new ModelAndView();
        String logId = (String) session.getAttribute("LogId");

        List<PartyVO> vo = mapper.SelectPartyList(logId);
        System.out.println(vo.size());
        if(vo.size() >= 5){
            mav.addObject("msg", "파티는 5개 이하로 가입 및 생성 가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        PartyVO temp = new PartyVO();
        temp.setPartyname(partyname);
        temp.setPartygoal(objective);
        temp.setPartycomment(intro);
        temp.setUser_userid(logId);

        int partyid = mapper.InsertCreateTeam(temp);
        System.out.println(temp.getPartyid());

        if (file.isEmpty()) {
            mapper.InsertPartyImg("/partyimg/default.png", temp.getPartyid());
            mapper.InsertMember(temp.getPartyid(), logId, "done");
            mav.setViewName("redirect:/myteam/main");
            return mav;
        }

        //파일저장시작
        String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String extension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String newFileName = temp.getPartyid() + "_"+currentTime+extension;
        String projectDir = new File("").getAbsolutePath();
        File directory = new File(projectDir + "/upload/partyimg");
        if (!directory.exists()) {
            directory.mkdirs(); // 디렉토리 생성
        }

        Path path = Paths.get(directory.getAbsolutePath(), newFileName); // 절대 경로를 사용

        try {
            file.transferTo(new File(path.toString()));
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("파일저장실패");
            mav.addObject("msg", "파일 저장을 실패하였습니다. 다시 시도해주세요.");
            mav.setViewName("alert_page");
            return mav;
        }
        //파일저장 끝

        //db에 경로넣기
        String imgsrc = "/partyimg/" + newFileName;
        mapper.InsertPartyImg(imgsrc, temp.getPartyid());
        //db에 경로넣기 끝
        // 이제 신청이 완료되었음 하고 로그인으로 보내든 해야함

        mapper.InsertMember(temp.getPartyid(), logId, "done");

        mav.setViewName("redirect:/myteam/main");
        return mav;
    }
    @GetMapping("party/create")
    public ModelAndView signup_end( HttpSession session){
        ModelAndView mav = new ModelAndView();
        String logId = (String) session.getAttribute("LogId");

        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mav.addObject("pvo",vo);
        System.out.println(vo.size());
        if(vo.size() >= 5){
            mav.addObject("msg", "파티는 5개 이하로 가입 및 생성 가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        mav.setViewName("myteam/myteam_create");
        return mav;
    }

    @PostMapping("party/nameCheck")
    @ResponseBody
    public int name_check(@RequestParam("name") String partyname,
                          @RequestParam(required = false, defaultValue = "0") int no){

        int result = mapper.CheckPartyName(partyname);
        if(result==1){
            if(partyname.equals(mapper.myteamSelect(no).getPartyname())){
                result=0;
            }
        }
        return result;
    }

    @GetMapping("party/edit")
    public ModelAndView partyEdit(@RequestParam("no") int partyid,
                                  HttpSession session){
//        ModelAndView mav = new ModelAndView();
//        String logId = (String) session.getAttribute("LogId");
//        List<PartyVO> vo = mapper.SelectPartyList(logId);
//        System.out.println(vo.size());
//        mav.addObject("pvo",vo);
//        PartyVO pvo = mapper.myteamSelect(partyid);
//
//        if(logId!= ){
//            mav.addObject("msg", "파티장만 수정가능합니다.");
//            mav.setViewName("alert_page");
//        }
//        mav.addObject("partyvo",pvo);
//        mav.setViewName("/myteam/myteam_infoEdit");
//        return mav;
        ModelAndView mav = new ModelAndView();
        String logId = (String) session.getAttribute("LogId");
        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mav.addObject("pvo",vo);

        PartyVO pvo = mapper.myteamSelect(partyid);
        boolean isPartyLeader = false;

        for(PartyVO vo1 : vo){
            if(vo1.getUser_userid().equals(logId)){
                isPartyLeader = true;
                break;
            }
        }

        if(!isPartyLeader){
            mav.addObject("msg", "파티장만 수정가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }

        mav.addObject("partyvo",pvo);
        mav.setViewName("/myteam/myteam_infoEdit");
        return mav;
    }
    @PostMapping("party/nameUpdate")
    @ResponseBody
    public int nameUpdate(  @RequestParam("name") String partyname,
                            @RequestParam("no") int partyid,
                            HttpSession session){
        String logId = (String) session.getAttribute("LogId");
        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mapper.UpdatePartyName(partyname, partyid);
        return 1;
    }

    @PostMapping("party/objectiveUpdate")
    @ResponseBody
    public int objectiveUpdate(  @RequestParam("no") int partyid,
                            @RequestParam("objective") String partygoal,
                            HttpSession session){
        String logId = (String) session.getAttribute("LogId");
        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mapper.UpdatePartyObjective(partyid, partygoal);

        return 1;
    }

    @PostMapping("party/introUpdate")
    @ResponseBody
    public int introUpdate(  @RequestParam("no") int partyid,
                            @RequestParam("intro") String partycomment,
                            HttpSession session){
        String logId = (String) session.getAttribute("LogId");
        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mapper.UpdatePartyIntro(partyid, partycomment);

        return 1;
    }

}
