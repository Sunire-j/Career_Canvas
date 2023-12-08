package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.SubjectVO;
import com.team1.careercanvas.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SubjectMapper {
    UserVO SelectCompany(String logId);

    int insertSubjectImg(String pathfordb, int Subjectid);

    int SubjectWrite(SubjectVO svo);
    SubjectVO SelectSubject(int subjectid);

    void Insertdelapply(int subjectid, String reason, String logId);

    int CountDelid(int subjectid);
}
