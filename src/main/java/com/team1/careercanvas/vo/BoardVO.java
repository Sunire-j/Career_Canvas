package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardVO {
    private int postid;
    private String posttitle;
    private String postcontent;
    private int boardcategory;
    private int category;
    private String hashtag;
    private String user_userid;
    private String date;
    private int views;
    private int likeAmount;
}
