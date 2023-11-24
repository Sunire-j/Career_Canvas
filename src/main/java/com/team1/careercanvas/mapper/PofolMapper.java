package com.team1.careercanvas.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.team1.careercanvas.vo.PagingVO;
import com.team1.careercanvas.vo.PofolVO;

@Mapper
public interface PofolMapper {
	// 권혁준 작업
	List<PofolVO> getPofol(PagingVO pVO);

	int getPofolCount(PagingVO pVO);

	// 김효준작업
	int getpofolamount(String userid);

	List<PofolVO> getPofolInfo(String userid);
}
