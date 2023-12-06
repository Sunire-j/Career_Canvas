package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.PagingVO;
import com.team1.careercanvas.vo.PofolVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PofolMapper {
	// 권혁준 작업
	List<PofolVO> getPofol(PagingVO pVO);

	int getPofolCount(PagingVO pVO);

	// 김효준작업
	int getpofolamount(String userid);

	List<PofolVO> getPofolInfo(PagingVO pvo);

	int isLike(int no, String userid);

	void pofolLike(int no, String userid);

	void reportPofol(int target_id, String userid, String title, String user_userid);

	int deletePofol(int pofolid);

	PofolVO getPofolall(int pofolid);

	int getpofollike(int pofolid);

	int insertImg(String path, int pofolid);

	// 권혁준 작업

	List<PofolVO> getPublicSoloPofol(PagingVO pVO);

	List<PofolVO> getPublicTeamPofol(PagingVO pVO);

	int getTotalSoloPofol(PagingVO pVO);

	int getTotalTeamPofol(PagingVO pVO);

}
