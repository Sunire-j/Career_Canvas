package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChattingVO {
    private int party_partyid;
    private String user_userid;
    private String date;
    private String partychatcontent;
    private String profileimg;
    private String username;
}
