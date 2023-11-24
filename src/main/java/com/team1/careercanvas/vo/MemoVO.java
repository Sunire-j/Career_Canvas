package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MemoVO {
    private int partymemo;
    private String datetime;
    private String partymemocontent;
    private int party_partyid;
    private  String user_userid;
    private  String username;
}
