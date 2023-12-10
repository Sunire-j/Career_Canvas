package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WantedVO {
    private int wantedid;
    private String partyname;
    private String wantedtitle;
    private String wantedcontent;
    private int party_partyid;
    private String user_userid;
    private String date;
    private int view;
    private int commentAmount;
    private String username;
}
