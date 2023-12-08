package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.ApplyVO;
import com.team1.careercanvas.vo.PartyVO;
import com.team1.careercanvas.vo.SubjectVO;
import com.team1.careercanvas.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SubjectMapper {
    UserVO SelectCompany(String logId);

    int insertSubjectImg(String pathfordb, int Subjectid);

    int SubjectWrite(SubjectVO svo);
    SubjectVO SelectSubject(int subjectid);

    void Insertdelapply(int subjectid, String reason, String logId);

    int CountDelid(int subjectid);

    List<PartyVO> SelectPartyList(String logId);

    List<UserVO> SelectMemberList(int partyid);

    int InsertSubjectApply(ApplyVO avo);

    void Insertpartyid(int Applyid, int partyid);
    void addApplyMember(int getApplyid, String member);

    int insertApplyImg(String pathfordb, int Applyid);
}
