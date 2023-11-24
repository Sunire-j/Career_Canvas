package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.MemoVO;
import com.team1.careercanvas.vo.PartyVO;
import com.team1.careercanvas.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PartyMapper {
    List<PartyVO> SelectPartyList(String logId);
    PartyVO myteamSelect(int partyid);
    List<UserVO> SelectMemberList(int partyid);
    List<MemoVO> SelectMemoListView(int partyid);
    int InsertMemo(int partyid, String content, String logid);

    int DeleteMemo(int partymemo);
}
