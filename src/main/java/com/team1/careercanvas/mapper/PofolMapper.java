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

	List<PofolVO> getPofolInfo(String userid);

	int insertImg(String path, int pofolid);

	// 권혁준 작업

	List<PofolVO> getBestPofol(String category);
}
