package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubjectCommentVO {
    private int scid;
    private int applyid;
    private String userid;
    private String sccontent;
    private String date;
    private String username;
    private String img;
}
