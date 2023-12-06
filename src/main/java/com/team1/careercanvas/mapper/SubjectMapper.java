package com.team1.careercanvas.mapper;

import com.team1.careercanvas.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SubjectMapper {
    UserVO SelectCompany(String logId);
}
