package com.team1.careercanvas.vo;

import lombok.Data;

@Data
public class UserVO {
    private String userid;
    private String userpwd;
    private String username;
    private String date;
    private String useremail;
    private String usertel;
    private int usertype;
    private String comment;
    private String usersalt;

    private String profileimg;
}
