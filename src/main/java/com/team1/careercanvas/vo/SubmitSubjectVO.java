package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubmitSubjectVO {
    private int applyid;
    private String subjecttitle;
    private String applyimg;
    private String party_partyid;
}
