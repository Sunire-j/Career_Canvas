package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.PartyMapper;
import com.team1.careercanvas.mapper.PofolMapper;
import com.team1.careercanvas.vo.PofolVO;
import com.team1.careercanvas.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.List;

@Controller
public class PofolpolioController {

    private final PofolMapper pofolmapper;
    private final PartyMapper partymapper;
    public PofolpolioController(PofolMapper pofolmapper, PartyMapper partymapper) {
        this.pofolmapper = pofolmapper;
        this.partymapper = partymapper;
    }


    @GetMapping("/pofolview")
    public ModelAndView pofolview(HttpSession session,
                                  @RequestParam(required = false, defaultValue = "0") int pofolid){
        ModelAndView mav = new ModelAndView();
        if(pofolid==0){
            mav.addObject("msg","잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        //포폴이 진짜 있는지 확인
        PofolVO pofolVO = pofolmapper.getPofolall(pofolid);
        if(pofolVO==null){
            mav.addObject("msg","삭제되거나 존재하지 않은 포트폴리오입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        if(pofolVO.getIsteam()==0){//파티일경우
            String partyname = partymapper.getPartyName(pofolVO.getPartyid());
            mav.addObject("partyname",partyname);
            // 정인식 작업
            List<UserVO> member = pofolmapper.getSelectMemberList(pofolid);
            mav.addObject("member", member);
            // 정인식 작업 끝
        }
        // 조회수 증가
        pofolmapper.ViewsCount(pofolid);
        //추천수조회
        int thumbsup = pofolmapper.getpofollike(pofolid);

        mav.addObject("pVO", pofolVO);
        mav.addObject("likeamount",thumbsup);

        mav.setViewName("pofol/pofolview");
        return mav;
    }

    @GetMapping("/portfolio/edit")
    public ModelAndView pofolEdit(HttpSession session, int no){
        ModelAndView mav = new ModelAndView();
        String logStatus = (String) session.getAttribute("LogStatus");
        //로그인상태확인
        if(logStatus==null){
            mav.addObject("msg", "로그인 후 가능합니다.");
            mav.addObject("isBack",1);
            mav.addObject("alert_page","login");
            mav.setViewName("improve_alert");
            return mav;
        }

        PofolVO pofolVO = pofolmapper.getPofolall(no);
        //포폴주인 맞는지 확인해야함

        String LogId = (String) session.getAttribute("LogId");
        if(!pofolVO.getUser_userid().equals(LogId)){
            mav.addObject("msg","잘못된 접근입니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }

        //파티랑 솔로랑 viewname을 바꿔서 보내줘야함
        //파티를 먼저하자
        if(pofolVO.getIsteam()==0){
            String partyname = partymapper.getPartyName(pofolVO.getPartyid());
            mav.addObject("partyname",partyname);
            List<UserVO> member = pofolmapper.getMemberList(pofolVO.getPartyid());//기존멤버
            mav.addObject("memberList", member);
            List<UserVO> originmember = pofolmapper.getMemberListForEdit(pofolVO.getPortfolioid());//참여멤버
            mav.addObject("originmember", originmember);
            //준비물 끝


            mav.setViewName("myteam/myteam_pofol_edit");
        }else{
            //개인은 그냥 바로 가면 끝임
            mav.setViewName("users/mypage_pofolEdit");
        }
        mav.addObject("pofolVO", pofolVO);
        return mav;
    }

    @PostMapping("/portfolio/pofolEditOk")
    public ModelAndView pofolEditOk(HttpSession session,
                                    @RequestParam("posttitle") String title,
                                    @RequestParam("postcontent") String content,
                                    @RequestParam(value = "member", required = false) String[] member,
                                    int portfolioid) throws IOException {

        ModelAndView mav = new ModelAndView();
        //파티의 경우
        PofolVO pofolVO = pofolmapper.getPofolall(portfolioid);
        pofolVO.setPortfoliotitle(title);
        pofolVO.setPortfoliocontent(content);
        if(pofolVO.getIsteam()==0){
            //내용을 먼저 수정시키고
            pofolmapper.updatePofol(pofolVO);
            //멤버날리고 새로 추가
            pofolmapper.deletePofolCont(pofolVO);
            for (int i = 0; i < member.length; i++) {
                partymapper.addPofolMember(pofolVO.getPortfolioid(), member[i]);
            }
        }else{
            pofolmapper.updatePofol(pofolVO);
        }



        //여기에서 썸네일 처리 한번 해줘야함
        //썸네일 있으면 다 자르고 확인하고 업데이트까지
        //그럼 날짜를 붙여줘야함
        if (content.contains("<img src=")) {
            int index = content.indexOf("<img src=");
            String first = content.substring(index + 10);
            String second = first.substring(0, first.indexOf("\""));// mime 포함 src내 전체 코드
            String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
            String mimeType = second.split(",")[0].split(";")[0].split(":")[1];
            String base64Data = second.split(",")[1];

            String extension = mimeType.split("/")[1];

            byte[] data = Base64.getDecoder().decode(base64Data);

            String userid = String.valueOf(pofolVO.getPortfolioid());
            String newFileName = userid + "_"+currentTime+ "." + extension;

            String projectDir = new File("").getAbsolutePath();
            File directory = new File(projectDir + "/upload/pofolimg");
            if (!directory.exists()) {
                directory.mkdirs();
            }

            Path path = Paths.get(directory.getAbsolutePath(), newFileName);
            OutputStream outputStream = new FileOutputStream(path.toString());
            outputStream.write(data);
            outputStream.close();

            String oldFileName = pofolmapper.getOldImg(pofolVO.getPortfolioid());//수정해야함
            if (oldFileName != null || (!oldFileName.equals("") && !oldFileName.equals("/pofolimg/staticpofolimg.png"))) {
                File fileToDelete = new File(directory, oldFileName.substring(oldFileName.lastIndexOf('/') + 1));
                boolean result = fileToDelete.delete();
            }

            String pathfordb = "/pofolimg/" + newFileName;
            // 여기서 db에 path만 넣어주면 됨.
            pofolmapper.updateImg(pathfordb, pofolVO.getPortfolioid());

        }else{
            pofolmapper.updateImg("/pofolimg/staticpofolimg.png", pofolVO.getPortfolioid());
        }

        mav.setViewName("redirect:/pofolview?pofolid="+pofolVO.getPortfolioid());
        return mav;
    }

    @GetMapping("/pofol/like")
    public ModelAndView pofollike (HttpSession session, int no){
        ModelAndView mav = new ModelAndView();

        String logId = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("logStatus");

        if(logStatus != "Y"&&logId==null){
            mav.addObject("msg", "로그인 후 추천이 가능합니다.");
            mav.addObject("isBack",1);
            mav.addObject("alert_page", "login");
            mav.setViewName("improve_alert");
            return mav;
        }
        String userid = (String) session.getAttribute("LogId");

        int result = pofolmapper.isLike(no, userid);
        if(result == 1){
            mav.addObject("msg", "추천은 한번만 가능합니다.");
            mav.addObject("isBack",0);
            mav.setViewName("improve_alert");
            return mav;
        }
        pofolmapper.pofolLike(no, userid);

        mav.setViewName("redirect:/pofolview?pofolid="+no);
        return mav;
    }
    @PostMapping("/pofol/pofol_report")
    @ResponseBody
    public int pofol_report(int target_id, String target_userid, String target_title, HttpSession session){

        String userid = (String)session.getAttribute("LogId");
        pofolmapper.reportPofol(target_id, target_userid, target_title, userid);

        return 0;
    }
    @PostMapping("/pofol/postdel")
    @ResponseBody
    public int deletePost(int pofolid) {
        int result = pofolmapper.deletePofol(pofolid);

        return result;
    }
}
