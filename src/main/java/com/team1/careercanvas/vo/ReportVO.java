package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportVO {
    private int reportid;
    private String title;
    private String user_userid;
    private String reporttype;
    private int targetid;
    private String date;
    private String reason;
    private String userid;
}
