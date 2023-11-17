package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MessageVO {
    private String user_userid;
    private String user_userid1;
    private String date;
    private String content;
    private int ischeck;

}
