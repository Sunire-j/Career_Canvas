package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.ApplyVO;
import com.team1.careercanvas.vo.PagingVO;
import com.team1.careercanvas.vo.SubjectVO;
import com.team1.careercanvas.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ApplyMapper {

    List<ApplyVO> getApplyInfo(PagingVO pvo);

    int getApplyamountSolo(String userid);

    int getSubjectAmount(String userid);
    List<SubjectVO> getSubjectList(PagingVO pvo);

    ApplyVO SelectApply(int applyid);

    SubjectVO SelectSubject(int subjectid);
    List<UserVO> SelectsubjectMember(int applyid);
}
