package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PartyVO {
    private int partyid;
    private String partyname;
    private String partycomment;
    private String partygoal;
    private String user_userid;
    private String partyimage;
    private String username;
}
