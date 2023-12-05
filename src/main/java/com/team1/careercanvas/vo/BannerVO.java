package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BannerVO {
    private int bannerid;
    private String owner;
    private String bannerimg;
    private String startdate;
    private String deadline;
}
