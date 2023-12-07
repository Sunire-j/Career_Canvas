package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubjectVO {
    private int subjectid;
    private String subjecttitle;
    private String subjectcontent;
    private String date;
    private String user_userid;
    private String imgsrc;
    private int category;
    private String username;
}
