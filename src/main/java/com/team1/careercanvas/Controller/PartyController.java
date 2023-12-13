package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.ChatMapper;
import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.mapper.UserMapper;
import com.team1.careercanvas.vo.*;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.List;

@Controller
public class PartyController {
    private final PartyMapper mapper;
    private final ChatMapper chatmapper;
    private final UserMapper userMapper;

    public PartyController(PartyMapper mapper, ChatMapper chatmapper, UserMapper userMapper) {
        this.mapper = mapper;
        this.chatmapper = chatmapper;
        this.userMapper = userMapper;
    }

    // 조석훈 시작

    @GetMapping("/party/wanted/edit")
    public ModelAndView partywantedEdit(HttpSession session,
                                        @RequestParam(required = false, defaultValue = "0") int no) {
        ModelAndView mav = new ModelAndView();

        if(no==0){
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }

        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }

        //글 주인인지 확인
        String userid = (String) session.getAttribute("LogId");

        WantedVO wvo = mapper.GetWantedView(no);

        if(!wvo.getUser_userid().equals(userid)){
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }

        wvo.setPartyname(mapper.getPartyName(wvo.getParty_partyid()));
        mav.addObject("wvo", wvo);

        mav.setViewName("party/party_wanted_edit");
        return mav;
    }

    @PostMapping("/party/wanted/editOk")
    public String wantedEditOk(WantedVO wVO, HttpSession session) {
        wVO.setUser_userid((String) session.getAttribute("LogId"));
        mapper.UpdateWanted(wVO);
        return "redirect:/party/wanted/view?no="+wVO.getWantedid();
    }



    @GetMapping("/party/wanted")
    public ModelAndView partywanted(HttpSession session,
            @RequestParam(required = false, defaultValue = "1") int page,
            @RequestParam(required = false) String searchWord,
            @RequestParam(required = false) String searchKey,
            @RequestParam(required = false, defaultValue = "1") int postSort) {
        // 파티모집에서 필터할 것, 검색타입(제목, 내용, 파티명), 검색어, 소트(최신, 조회), 카테고리

        ModelAndView mav = new ModelAndView();
        PagingVO pvo = new PagingVO();

        pvo.setOnePageRecord(15);
        pvo.setPage(page);
        if (searchWord != null || searchWord != "") {
            pvo.setSearchKey(searchKey);
            pvo.setSearchWord(searchWord);
        }
        pvo.setPostSort(postSort);
        pvo.setTotalRecord(mapper.getWantedListCount(pvo));
        List<WantedVO> wvo = mapper.GetWantedList(pvo);
        mav.addObject("wVO", wvo);
        mav.addObject("pVO", pvo);
        mav.setViewName("party/party_wanted");

        return mav;
    }

    @GetMapping("/party/wanted/write")
    public ModelAndView partywantedwrite(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }

        // 로그인한 아이디가 파티장인지 여부 확인 겸 파티장인 파티목록 확인
        List<PartyVO> partylist = mapper.getMineParty((String) session.getAttribute("LogId"));
        if (partylist.size() == 0) {
            mav.addObject("msg", "파티장만 글 작성이 가능합니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }
        mav.addObject("pVO", partylist);
        mav.setViewName("party/party_wanted_write");
        return mav;
    }

    @PostMapping("/party/wanted/writeOk")
    public String wantedWriteOk(WantedVO wVO, HttpSession session) {
        wVO.setUser_userid((String) session.getAttribute("LogId"));
        // 준비 끝 db보내고 게시판으로 보내주면 됨.
        mapper.InsertWanted(wVO);
        return "redirect:/party/wanted";
    }

    @GetMapping("/party/wanted/view")
    public ModelAndView wantedView(int no) {
        ModelAndView mav = new ModelAndView();
        // no글 선택
        mapper.increseView(no);
        WantedVO wvo = mapper.GetWantedView(no);
        wvo.setPartyname(mapper.getPartyName(wvo.getParty_partyid()));
        mav.addObject("wvo", wvo);
        mav.setViewName("party/party_wanted_view");

        return mav;
    }

    @PostMapping("/party/commentLoad")
    @ResponseBody
    public List<CommentVO> commendLoad(int no) {
        List<CommentVO> list = mapper.commentLoad(no);
        return list;
    }

    @PostMapping("/party/commentWrite")
    @ResponseBody
    public int commentWrite(HttpSession session,
            CommentVO cvo) {
        String logStatus = (String) session.getAttribute("logStatus");
        String logid = (String) session.getAttribute("LogId");
        if(logid==null && logStatus != "Y"){
            return -1;
        }
        cvo.setUser_userid((String) session.getAttribute("LogId"));
        cvo.setDepth(0);
        if (cvo.getTarget_parent() > 0) {
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
    public String wanteddel(int wantedid) {
        int result = mapper.DeleteWanted(wantedid);
        return "";
    }

    @PostMapping("/party/wanted/report")
    @ResponseBody
    public int reportwanted(int target_id, String target_userid, String target_title,
            HttpSession session) {
        // 신고자
        String userid = (String) session.getAttribute("LogId");
        int result = mapper.reportWanted(target_id, target_userid, target_title, userid);

        return result;
    }

    @PostMapping("/party/comment/report")
    @ResponseBody
    public int reportwantedcomment(int originpostid, int targetid, HttpSession session) {
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
        return result;
    }

    @PostMapping("/party/wanted/commentdel")
    @ResponseBody
    public int wantedcommentdel(int commentid) {
        int result = mapper.deleteWantedComment(commentid);
        return result;
    }

    @PostMapping("/party/apply")
    @ResponseBody
    public int applyParty(HttpSession session, int partyid) {
        String uid = (String) session.getAttribute("LogId");
        String status =  mapper.SelectmemberStatus(partyid, uid);
        String logStatus = (String) session.getAttribute("logStatus");
        List<PartyVO> vo = mapper.SelectPartyList(uid);
        if(uid==null && logStatus!="Y"){
            return 4;
        }
        if(vo.size()>5){
            return 3;
        }
        if(status!=null){
            return 1;
        }

        int usertype = mapper.getUsertype(uid);

        if(usertype==1){
            return 2;
        }



        int result = mapper.applyParty(uid, partyid);
        return 0;
    }

    @GetMapping("myteam/chat")
    public ModelAndView partychat(int no, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }

        // 파티가 존재하는지 확인
        if (no == 0) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }
        int count = mapper.CheckpartyId(no);

        if (count == 0) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }

        // 파티원인지 확인
        int temp = 0;
        List<UserVO> memberlist = mapper.SelectMemberList(no);
        for (int i = 0; i < memberlist.size(); i++) {
            if (memberlist.get(i).getUserid().equals(session.getAttribute("LogId"))) {
                temp = 1;
                break;
            }
        }
        if (temp == 0) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }

        String logId = (String) session.getAttribute("LogId");

        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mav.addObject("pvo", vo);
        mav.addObject("no", no);
        PartyVO partyvo = mapper.myteamSelect(no);
        mav.addObject("teamname", partyvo.getPartyname());
        // 여기에서 db에 이전 채팅내역 불러오는게 있어야함.
        mav.setViewName("/myteam/myteam_chat");

        return mav;
    }

    @MessageMapping("/chatting/{partyid}")
    @SendTo("/topic/{partyid}")
    public ChattingVO send(ChattingVO vo, @DestinationVariable String partyid) {

        String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        vo.setDate(time);
        // db에 저장
        chatmapper.InsertChat(vo);
        // username이랑 profileimg추가
        vo.setUsername(userMapper.getUserInfo(vo.getUser_userid()).getUsername());
        vo.setProfileimg(userMapper.getUserInfo(vo.getUser_userid()).getProfileimg());

        return vo;
    }

    @PostMapping("/myteam/getChat")
    @ResponseBody
    public List<ChattingVO> getChat(int partyid) {
        List<ChattingVO> list = chatmapper.getChat(partyid);
        return list;
    }
    // 조석훈 끝

    // 정인식 작업
    @GetMapping("/myteam/main")
    public ModelAndView myteamMain(HttpSession session,
            @RequestParam(required = false, defaultValue = "0") int partyid) {
        ModelAndView mav = new ModelAndView();
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("logStatus");

        if (logStatus != "Y" && logId == null) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }
        List<PartyVO> vo = mapper.SelectPartyList(logId);

        if (vo.isEmpty()) {
            mav.setViewName("myteam/party_empty_alert");
            return mav;
        }

        int temp = 0;

        if (partyid != 0) {
            temp = -1;
            for (int i = 0; i < vo.size(); i++) {
                if (vo.get(i).getPartyid() == partyid) {
                    List<UserVO> memberList = mapper.SelectMemberList(vo.get(i).getPartyid());
                    for (int j = 0; j < memberList.size(); j++) {
                        if (memberList.get(j).getUserid().equals(logId)) {
                            temp = i;
                            break;
                        }
                    }
                    if (temp != -1)
                        break;
                }
                if (temp != -1)
                    break;
            }
            if (temp == -1) {
                mav.addObject("msg", "잘못된 접근입니다.");
                mav.addObject("isBack", 0);
                mav.setViewName("improve_alert");
                return mav;
            }
        }

        PartyVO myteamView = mapper.myteamSelect(vo.get(temp).getPartyid());
        List<UserVO> memberList = mapper.SelectMemberList(vo.get(temp).getPartyid());
        List<MemoVO> memoListView = mapper.SelectMemoListView(vo.get(temp).getPartyid());
        mav.addObject("myteamView", myteamView);
        mav.addObject("memberList", memberList);
        mav.addObject("memoListView", memoListView);
        mav.addObject("pvo", vo);
        mav.addObject("tempno", vo.get(temp).getPartyid());
        mav.setViewName("myteam/myteam_main");

        return mav;
    }

    // 정인식 작업 ( 파티 정보 출력 )
    @PostMapping("/myteamView")
    @ResponseBody
    public PartyVO myteamView(@RequestParam("no") int partyid) {
        PartyVO myteamView = mapper.myteamSelect(partyid);
        return myteamView;
    }

    @PostMapping("/memberList")
    @ResponseBody
    public List<UserVO> memberList(@RequestParam("no") int partyid) {
        List<UserVO> memberList = mapper.SelectMemberList(partyid);
        return memberList;
    }

    @PostMapping("/memoListView")
    @ResponseBody
    public List<MemoVO> memoListView(@RequestParam("no") int partyid) {
        List<MemoVO> memoListView = mapper.SelectMemoListView(partyid);
        return memoListView;
    }

    @PostMapping("/memoWriteOK")
    @ResponseBody
    public int memoWriteOK(@RequestParam("no") int partyid,
            @RequestParam("content") String content,
            HttpSession session) {
        String logId = (String) session.getAttribute("LogId");
        int a = mapper.InsertMemo(partyid, content, logId);
        return a;
    }

    @PostMapping("/memoDeleteOk")
    @ResponseBody
    public int memoDeleteOk(@RequestParam("target") int target) {
        int a = mapper.DeleteMemo(target);
        return a;
    }

    @PostMapping("/myteam/create")
    public ModelAndView createTeam(@RequestParam("input_name") String partyname,
            @RequestParam("ex_file") MultipartFile file,
            @RequestParam("input_objective") String objective,
            @RequestParam("input_intro") String intro,
            HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");

        List<PartyVO> vo = mapper.SelectPartyList(logId);
        if (vo.size() >= 5) {
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

        if (file.isEmpty()) {
            mapper.InsertPartyImg("/partyimg/default.png", temp.getPartyid());
            mapper.InsertMember(temp.getPartyid(), logId, "done");
            mav.setViewName("redirect:/myteam/main");
            return mav;
        }

        // 파일저장시작
        String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String extension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String newFileName = temp.getPartyid() + "_" + currentTime + extension;
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
            mav.addObject("msg", "파일 저장을 실패하였습니다. 다시 시도해주세요.");
            mav.setViewName("alert_page");
            return mav;
        }
        // 파일저장 끝

        // db에 경로넣기
        String imgsrc = "/partyimg/" + newFileName;
        mapper.InsertPartyImg(imgsrc, temp.getPartyid());
        // db에 경로넣기 끝
        // 이제 신청이 완료되었음 하고 로그인으로 보내든 해야함

        mapper.InsertMember(temp.getPartyid(), logId, "done");

        mav.setViewName("redirect:/myteam/main");
        return mav;
    }

    // 파티 생성 페이지
    @GetMapping("party/create")
    public ModelAndView signup_end(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }
        String logId = (String) session.getAttribute("LogId");

        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mav.addObject("pvo", vo);
        if (vo.size() >= 5) {
            mav.addObject("msg", "파티는 5개 이하로 가입 및 생성 가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        mav.setViewName("myteam/myteam_create");
        return mav;
    }

    // 파티명 중복검사 (파티생성 및 파티 정보수정)
    @PostMapping("party/nameCheck")
    @ResponseBody
    public int name_check(@RequestParam("name") String partyname,
            @RequestParam(required = false, defaultValue = "0") int no) {

        int result = mapper.CheckPartyName(partyname);
        if (result == 1) {
            if (partyname.equals(mapper.myteamSelect(no).getPartyname())) {
                result = 0;
            }
        }
        return result;
    }

    // 파티 정보 수정 페이지
    @GetMapping("party/edit")
    public ModelAndView partyEdit(@RequestParam("no") int partyid,
            HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }

        String logId = (String) session.getAttribute("LogId");
        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mav.addObject("pvo", vo);
        PartyVO pvo = mapper.myteamSelect(partyid);

        if (!logId.equals(pvo.getUser_userid())) {
            mav.addObject("msg", "파티장만 수정가능합니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }
        mav.addObject("partyvo", pvo);
        mav.setViewName("/myteam/myteam_infoEdit");
        return mav;
    }

    // 파티 정보 수정 ( 파티명 )
    @PostMapping("party/nameUpdate")
    @ResponseBody
    public int nameUpdate(@RequestParam("name") String partyname,
            @RequestParam("no") int partyid,
            HttpSession session) {
        String logId = (String) session.getAttribute("LogId");
        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mapper.UpdatePartyName(partyname, partyid);
        return 1;
    }

    // 파티 정보 수정 ( 파티목표 )
    @PostMapping("party/objectiveUpdate")
    @ResponseBody
    public int objectiveUpdate(@RequestParam("no") int partyid,
            @RequestParam("objective") String partygoal,
            HttpSession session) {
        String logId = (String) session.getAttribute("LogId");
        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mapper.UpdatePartyObjective(partyid, partygoal);

        return 1;
    }

    // 파티 정보 수정 ( 파티소개 )
    @PostMapping("party/introUpdate")
    @ResponseBody
    public int introUpdate(@RequestParam("no") int partyid,
            @RequestParam("intro") String partycomment,
            HttpSession session) {
        String logId = (String) session.getAttribute("LogId");
        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mapper.UpdatePartyIntro(partyid, partycomment);

        return 1;
    }

    @PostMapping("party/profileUpdate")
    public String profileUpdate(@RequestParam("no") int partyid,
            @RequestParam("ex_file") MultipartFile file) {

        if (file != null||!file.isEmpty()) {
            // 파일저장시작
            String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
            String extension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            String newFileName = partyid + "_" + currentTime + extension;
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
                return "404pages";
            }
            // 파일저장 끝

            // 기존파일 삭제
            String oldFileName = mapper.getpartyimg(partyid);
            if (oldFileName != null || oldFileName != "") {
                File fileToDelete = new File(directory, oldFileName.substring(oldFileName.lastIndexOf('/') + 1));
                boolean result = fileToDelete.delete();
            }

            // db에 경로넣기
            String imgsrc = "/partyimg/" + newFileName;

            mapper.UpdatePartyImg(imgsrc, partyid);
            // db에 경로넣기 끝

        }
        return "redirect:/party/edit?no=" + partyid;
    }

    // 파티 회원 관리 페이지
    @GetMapping("party/memberEdit")
    @ResponseBody
    public ModelAndView memberEdit(@RequestParam("no") int partyid,
            HttpSession session) {
        ModelAndView mav = new ModelAndView();

        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }

        String logId = (String) session.getAttribute("LogId");

        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mav.addObject("pvo", vo);

        PartyVO pvo = mapper.myteamSelect(partyid);
        mav.addObject("partyvo", pvo);
        if (!logId.equals(pvo.getUser_userid())) {
            mav.addObject("msg", "파티장만 수정가능합니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }

        List<UserVO> memberList1 = mapper.SelectMemberList(partyid);
        mav.addObject("memberList", memberList1);

        List<UserVO> waitingList1 = mapper.SelectWaitingList(partyid);
        mav.addObject("waitingList", waitingList1);

        mav.setViewName("/myteam/myteam_memberEdit");
        return mav;
    }

    // 파티 멤버 제명
    @PostMapping("party/memberDel")
    @ResponseBody
    public String memberDel(@RequestParam("no") int partyid,
            @RequestParam("memberId") String user_userid) {
        mapper.DeleteMember(partyid, user_userid);

        return "redirect:party/memberEdit";
    }

    // 파티 가입 승인
    @PostMapping("party/memberApprove")
    @ResponseBody
    public String memberApprove(@RequestParam("no") int partyid,
            @RequestParam("memberId") String user_userid) {
        mapper.ApproveMember(partyid, user_userid);

        return "redirect:party/memberEdit";
    }

    // 파티 가입 거절
    @PostMapping("party/memberRefuse")
    @ResponseBody
    public String memberRefuse(@RequestParam("no") int partyid,
            @RequestParam("memberId") String user_userid) {
        mapper.RefuseMember(partyid, user_userid);

        return "redirect:party/memberEdit";
    }

    @GetMapping("party/portpolio")
    @ResponseBody
    public ModelAndView partyportpolio(@RequestParam("no") int partyid,
            HttpSession session,
            @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();

        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }

        // 파티가 존재하는지 검사

        int count = mapper.CheckpartyId(partyid);

        if (count == 0) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }

        PagingVO pagingvo = new PagingVO();

        pagingvo.setOnePageRecord(12);
        pagingvo.setPage(page);

        int totalrecord = mapper.getpofolamountforparty(partyid);
        pagingvo.setTotalRecord(totalrecord);

        mav.addObject("no", partyid);
        String logId = (String) session.getAttribute("LogId");

        int temp = 0;
        List<UserVO> list = mapper.SelectMemberList(partyid);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getUserid().equals(logId)) {
                temp = 1;
                break;
            }
        }
        if (temp == 0) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }

        List<PartyVO> vo = mapper.SelectPartyList(logId);
        mav.addObject("pvo", vo);
        pagingvo.setSearchWord(String.valueOf(partyid));

        List<PofolVO> pofolvo = mapper.SelectPofolList(pagingvo);
        mav.addObject("Povo", pofolvo);
        mav.addObject("Pagingvo", pagingvo);
        mav.setViewName("myteam/myteam_portpolio");
        return mav;
    }

    @GetMapping("party/pofolWrite")
    public ModelAndView partypofolwrite(HttpSession session,
            @RequestParam("no") int partyid) {
        ModelAndView mav = new ModelAndView();

        if (session.getAttribute("LogStatus") == null || session.getAttribute("LogStatus").equals("N")) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.addObject("isBack", 1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }

        int count = mapper.CheckpartyId(partyid);

        if (count == 0) {
            mav.addObject("msg", "잘못된 접근입니다.");
            mav.addObject("isBack", 0);
            mav.setViewName("improve_alert");
            return mav;
        }
        mav.addObject("no", partyid);

        String logId = (String) session.getAttribute("LogId");

        PartyVO pvo = mapper.myteamSelect(partyid);
        mav.addObject("partyvo", pvo);

        if (!logId.equals(pvo.getUser_userid())) {
            mav.addObject("msg", "파티장만 등록 가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }

        List<UserVO> memberList1 = mapper.SelectMemberList(partyid);
        mav.addObject("memberList", memberList1);

        mav.setViewName("myteam/myteam_pofol_write");
        return mav;
    }

    @PostMapping("myteam/pofolWriteOk")
    public String partyfolwriteOk(HttpSession session,
            @RequestParam("posttitle") String title,
            @RequestParam("postcontent") String content,
            @RequestParam("category") String category,
            @RequestParam("member") String[] member,
            @RequestParam("no") int partyid) throws IOException {
        String logId = (String) session.getAttribute("LogId");

        PofolVO pvo = new PofolVO();
        pvo.setPortfoliotitle(title);
        pvo.setPortfoliocontent(content);
        pvo.setCategory(category);
        pvo.setUser_userid(logId);
        pvo.setPartyid(partyid);

        int result = mapper.pofolWrite(pvo);

        // 1. pofolcont에 참여한 멤버 추가
        for (int i = 0; i < member.length; i++) {
            mapper.addPofolMember(pvo.getPortfolioid(), member[i]);
        }

        if (content.contains("<img src=")) {
            int index = content.indexOf("<img src=");
            String first = content.substring(index + 10);
            String second = first.substring(0, first.indexOf("\""));// mime 포함 src내 전체 코드
            String mimeType = second.split(",")[0].split(";")[0].split(":")[1];
            String base64Data = second.split(",")[1];

            String extension = mimeType.split("/")[1];

            byte[] data = Base64.getDecoder().decode(base64Data);

            String userid = String.valueOf(pvo.getPortfolioid());
            String newFileName = userid + "." + extension;

            String projectDir = new File("").getAbsolutePath();
            File directory = new File(projectDir + "/upload/pofolimg");
            if (!directory.exists()) {
                directory.mkdirs();
            }

            Path path = Paths.get(directory.getAbsolutePath(), newFileName);
            OutputStream outputStream = new FileOutputStream(path.toString());
            outputStream.write(data);
            outputStream.close();

            String pathfordb = "/pofolimg/" + newFileName;
            // 여기서 db에 path만 넣어주면 됨.
            int dbresult = mapper.insertPofolImg(pathfordb, pvo.getPortfolioid());

        }
        return "redirect:/party/portpolio?no=" + partyid;
    }
}
