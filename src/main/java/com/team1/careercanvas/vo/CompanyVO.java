package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CompanyVO {
    private String user_userid;
    private String companyno;
    private int isaccept;
    private String authimg;
    private String companyname;
    private String date;
}
