package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.CommentMapper;
import com.team1.careercanvas.vo.CommentVO;
import com.team1.careercanvas.vo.ReportVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class CommentController {

    private final CommentMapper commentMapper;

    public CommentController(CommentMapper commentMapper) {
        this.commentMapper = commentMapper;
    }

    @PostMapping("/commentLoad")
    @ResponseBody
    public List<CommentVO> replyList(int no) {
        List<CommentVO> replyList = commentMapper.replySelect(no); //service 없어졌으니 수정해야함
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();

        return replyList;
    }

    @PostMapping("/comment/editcomment")
    @ResponseBody
    public int editPostComment(int commentid, String commentcontent){
        commentMapper.UpdatePostComment(commentid, commentcontent);
        return 1;
    }

    @PostMapping("/comment/editcommentWanted")
    @ResponseBody
    public int editWantedComment(int commentid, String commentcontent){
        commentMapper.UpdateWantedComment(commentid,commentcontent);
        return 1;
    }

    @PostMapping("/commentWriteHead")
    @ResponseBody
    public int replyWrite(int postid, String content, HttpSession session,
                          @RequestParam(required = false, defaultValue = "0") int target_parent) {

        String logStatus = (String) session.getAttribute("LogStatus");
        System.out.println(logStatus);

        if(logStatus==null || !logStatus.equals("Y")){
            return -1;
        }
        CommentVO vo = new CommentVO();
        vo.setPost_postid(postid);
        vo.setCommentcontent(content);
        vo.setUser_userid((String) session.getAttribute("LogId"));
        vo.setDepth(0);
        if (target_parent > 0) {
            vo.setTarget_parent(target_parent);
            vo.setDepth(1);
        }
        System.out.println("before");
        int result = commentMapper.replyInsert(vo);
        System.out.println("after");
        System.out.println(vo.getDepth()+"!!!!");
        if (vo.getDepth() == 0) {
            commentMapper.replyInsertTP(vo);
        }
        return result;
    }

    @PostMapping("/commentdel")
    @ResponseBody
    public int replydel(int commentid){
        //댓글 삭제는 완전 삭제가 아님
        //commentcontent와 isdelete를 업데이트해주는 방향
        int result = commentMapper.replydel(commentid);
        return result;
    }

    @PostMapping("/comment/report")
    @ResponseBody
    public int replyReport(int originpostid, int targetid, HttpSession session){
        //여기서 필요한 정보 : 댓글 내용 약간, 댓글 작성자, 신고자
        //신고자:
        String user_userid = (String) session.getAttribute("LogId");
        //댓글작성자 : 쿼리로 뽑아야함
        String userid = commentMapper.getWriter(targetid);
        //댓글내용: 쿼리로 뽑아야함
        String commentcontent = commentMapper.getContent(targetid);
        if (commentcontent.length() > 40) {
            commentcontent = commentcontent.substring(0, 40);
        }
        ReportVO rvo = new ReportVO();
        rvo.setReporttype("comment");
        rvo.setUser_userid(user_userid);
        rvo.setUserid(userid);
        rvo.setTitle(commentcontent);
        rvo.setOriginpostid(originpostid);
        rvo.setTargetid(targetid);

        //db에 인설트 해줘야함
        int result = commentMapper.replyReport(rvo);

        return result;
    }

}
