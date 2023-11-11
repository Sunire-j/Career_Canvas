package com.team1.careercanvas.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    int LoginCheck(String userid, String userpwd);
    int idCheck(String input);
    int namecheck(String input);
    int emailcheck(String input);
}
