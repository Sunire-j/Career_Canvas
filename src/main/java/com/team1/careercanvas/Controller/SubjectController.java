package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.ApplyMapper;
import com.team1.careercanvas.mapper.SubjectMapper;
import com.team1.careercanvas.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.List;

@Controller
public class SubjectController {

    private final SubjectMapper mapper;

    private final ApplyMapper applymapper;

    public SubjectController(SubjectMapper mapper, ApplyMapper applymapper) {
        this.mapper = mapper;
        this.applymapper = applymapper;
    }

    @GetMapping("/subject/write")
    public ModelAndView subjectWrite(HttpSession session){
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("logStatus");

        UserVO uvo = mapper.SelectCompany(logId);

        if (logStatus != "Y" && logId == null) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        if (uvo == null) {
            mav.addObject("msg", "기업회원만 작성 가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }
        mav.setViewName("company/subjectWrite");

        return mav;
    }

    @PostMapping("/subject/writeOk")
    public String subjectWriteOk(HttpSession session,
                                 @RequestParam("posttitle") String title,
                                 @RequestParam("postcontent") String content,
                                 @RequestParam("category") int category
                                 )throws IOException {
        String logId = (String) session.getAttribute("LogId");

        SubjectVO svo = new SubjectVO();
        svo.setSubjecttitle(title);
        svo.setSubjectcontent(content);
        svo.setCategory(category);
        svo.setUser_userid(logId);

        int result = mapper.SubjectWrite(svo);

        if (content.contains("<img src=")) {
            int index = content.indexOf("<img src=");
            String first = content.substring(index + 10);
            String second = first.substring(0, first.indexOf("\""));// mime 포함 src내 전체 코드
            String mimeType = second.split(",")[0].split(";")[0].split(":")[1];
            String base64Data = second.split(",")[1];

            String extension = mimeType.split("/")[1];

            byte[] data = Base64.getDecoder().decode(base64Data);

            String userid = String.valueOf(svo.getSubjectid());
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
            int dbresult = mapper.insertSubjectImg(pathfordb, svo.getSubjectid());

        }

        return "";
    }

    @GetMapping("subject/view")
    public ModelAndView subjectView(HttpSession session,
                                    @RequestParam("no") int subjectid){
        ModelAndView mav = new ModelAndView();
        String logId = (String) session.getAttribute("LogId");

        SubjectVO svo = mapper.SelectSubject(subjectid);
        mav.addObject("Svo", svo);

        int delidCount = mapper.CountDelid(subjectid);
        mav.addObject("delcount", delidCount);


        mav.setViewName("company/subjectView");
        return mav;
    }

    @GetMapping("subject/del")
    public ModelAndView subjectdel(HttpSession session,
                             int subjectid){
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");

        SubjectVO svo = mapper.SelectSubject(subjectid);
        mav.addObject("Svo", svo);

        mav.setViewName("company/delPopup");
        return mav;
    }

    @PostMapping("subject/delOk")
    @ResponseBody
    public int subjectdelOk(HttpSession session,
                            @RequestParam("subjectid") int subjectid,
                            @RequestParam("reason") String reason){
        String logId = (String) session.getAttribute("LogId");

        mapper.Insertdelapply(subjectid, reason, logId);

        return 0;
    }

    @GetMapping("subject/submit")
    public ModelAndView subjectSubmit(HttpSession session,
                                      @RequestParam("subjectid") int subjectid){
        ModelAndView mav = new ModelAndView();
        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("logStatus");

        if (logStatus != "Y" && logId == null) {
            mav.addObject("msg", "로그인 후 이용가능합니다.");
            mav.setViewName("alert_page");
            return mav;
        }

        SubjectVO svo = mapper.SelectSubject(subjectid);
        mav.addObject("Svo", svo);

        // 파티 목록
        List<PartyVO> partyvo = mapper.SelectPartyList(logId);
        mav.addObject("pvo", partyvo);

        mav.setViewName("subject/subjectSubmitWrite");
        return mav;
    }

    @PostMapping("/subject/memberList")
    @ResponseBody
    public List<UserVO> memberList(@RequestParam("partyid") int partyid) {
        List<UserVO> memberList;
        memberList = mapper.SelectMemberList(partyid);
        return memberList;
    }

    @PostMapping("subject/submitwriteOk")
    public String submutWriteOk(HttpSession session,
                                @RequestParam("subjectid") int subjectid,
                                @RequestParam("postcontent") String content,
                                @RequestParam("isteam") int isteam,
                                @RequestParam(value = "partyid", required = false) int partyid,
                                @RequestParam(value = "member",required = false) String[] member,
                                HttpServletResponse response) throws IOException {

        String logId = (String) session.getAttribute("LogId");

        ApplyVO avo = new ApplyVO();

        avo.setSubject_subjectid(subjectid);
        avo.setApplycontent(content);
        avo.setIsteam(isteam);
        avo.setUser_userid(logId);
        int result = mapper.InsertSubjectApply(avo);

        if(isteam==0){
            mapper.Insertpartyid(avo.getApplyid(), partyid);
            for(int i = 0; i<member.length;i++){
                mapper.addApplyMember(avo.getApplyid(), member[i]);
            }
        }

        if (content.contains("<img src=")) {
            int index = content.indexOf("<img src=");
            String first = content.substring(index + 10);
            String second = first.substring(0, first.indexOf("\""));// mime 포함 src내 전체 코드
            String mimeType = second.split(",")[0].split(";")[0].split(":")[1];
            String base64Data = second.split(",")[1];

            String extension = mimeType.split("/")[1];

            byte[] data = Base64.getDecoder().decode(base64Data);

            String userid = String.valueOf(avo.getApplyid());
            String newFileName = userid + "." + extension;

            String projectDir = new File("").getAbsolutePath();
            File directory = new File(projectDir + "/upload/applyimg");
            if (!directory.exists()) {
                directory.mkdirs();
            }

            Path path = Paths.get(directory.getAbsolutePath(), newFileName);
            OutputStream outputStream = new FileOutputStream(path.toString());
            outputStream.write(data);
            outputStream.close();

            String pathfordb = "/applyimg/" + newFileName;
            // 여기서 db에 path만 넣어주면 됨.
            int dbresult = mapper.insertApplyImg(pathfordb, avo.getApplyid());
        }

        if(result>0){
            String alertMessage = "제출 완료 하였습니다.";
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('" + alertMessage + "'); location.href='view?no=" + subjectid + "';</script>");
            response.getWriter().flush();
            response.getWriter().close();
        }else{
            String alertMessage = "제출 실패 하였습니다.";
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('" + alertMessage + "'); location.href='view?no=" + subjectid + "';</script>");
            response.getWriter().flush();
            response.getWriter().close();
        }
        return null;
        //return "redirect:view?no="+subjectid;
    }

    @GetMapping("subject/applyView")
    public ModelAndView subjectApplyView(@RequestParam("applyid") int applyid){
        ModelAndView mav = new ModelAndView();

        ApplyVO avo = applymapper.SelectApply(applyid);
        mav.addObject("avo", avo);

        SubjectVO svo = applymapper.SelectSubject(avo.getSubject_subjectid());
        mav.addObject("svo", svo);

        List<UserVO> member = applymapper.SelectsubjectMember(applyid);
        mav.addObject("member", member);

        mav.setViewName("subject/subjectSubmitView");
        return mav;
    }
}
