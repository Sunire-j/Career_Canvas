package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.CommentMapper;
import com.team1.careercanvas.vo.CommentVO;
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

    @PostMapping("/commentWriteHead")
    @ResponseBody
    public int replyWrite(int postid, String content, HttpSession session,
                          @RequestParam(required = false, defaultValue = "0") int target_parent) {
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

}
