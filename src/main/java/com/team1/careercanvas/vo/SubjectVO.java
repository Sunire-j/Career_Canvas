package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class SubjectVO {
    private int subjectid;
    private String subjecttitle;
    private String subjectcontent;
    private String date;
    private String user_userid;
    private String imgsrc;
}
