package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PofolVO {
	private int portfolioid;
	private String user_userid;
	private String portfoliotitle;
	private String portfoliocontent;
	private int ispublic;
	private String category;
	private int view;
	private String imgsrc;
	private int isteam;
	private int partyid;
	private int likeCnt;
}
