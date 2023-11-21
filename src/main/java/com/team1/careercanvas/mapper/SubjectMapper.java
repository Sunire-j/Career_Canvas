package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.SubjectVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SubjectMapper {

    List<SubjectVO> getSubjectInfo(String userid);

}
