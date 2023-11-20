package com.team1.careercanvas.Controller;

import com.team1.careercanvas.mapper.CommentMapper;
import com.team1.careercanvas.vo.CommentVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class CommentController {

    private final CommentMapper commentMapper;

    public CommentController(CommentMapper commentMapper) {
        this.commentMapper = commentMapper;
    }

    @PostMapping("/board/commentLoad")
    @ResponseBody
    public List<CommentVO> replyList(int no){
        List<CommentVO> replyList =commentMapper.replySelect(no); //service 없어졌으니 수정해야함
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();

        for(CommentVO rvo : replyList){
            LocalDateTime writeDate = LocalDateTime.parse(rvo.getDate(), dtf);
            if(writeDate.getYear() != now.getYear()){
                rvo.setDate(writeDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")));
            } else if(writeDate.getMonthValue() != now.getMonthValue()){
                rvo.setDate(writeDate.format(DateTimeFormatter.ofPattern("MM/dd")));
            } else if(writeDate.getDayOfMonth() != now.getDayOfMonth()){
                rvo.setDate(writeDate.format(DateTimeFormatter.ofPattern("MM/dd")));
            } else {
                rvo.setDate(writeDate.format(DateTimeFormatter.ofPattern("HH:mm")));
            }
        }
        return replyList;
    }
}
