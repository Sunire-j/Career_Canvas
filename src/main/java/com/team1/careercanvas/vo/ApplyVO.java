package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class ApplyVO {
    private int applyid;
    private int subject_subjectid;
    private String applycontent;
    private int isteam;
    private int party_partyid;
    private String user_userid;
    private String applyimg;
    private String subjecttitle;
    private int category;
    private String profileimg;
}
