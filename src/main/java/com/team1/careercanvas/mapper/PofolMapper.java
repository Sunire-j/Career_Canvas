package com.team1.careercanvas.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team1.careercanvas.vo.PofolVO;

@Mapper
public interface PofolMapper {
	List<PofolVO> getPofol(String userid);
	//김효준작업 
	int getpofolamount(String userid);

	List<PofolVO> getPofolInfo(String userid);
}
