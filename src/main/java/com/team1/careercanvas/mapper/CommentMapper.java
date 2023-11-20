package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.CommentVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommentMapper {

    List<CommentVO> replySelect(int no);
}
