package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentVO {
    private int commentid;
    private String user_userid;
    private int post_postid;
    private int partywanted_wantedid;
    private String commentcontent;
    private int target_parent;
    private int isdelete;
    private String date;
    private int depth;
    private String profileimg;
    private String username;
}
