package com.team1.careercanvas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PagingVO {
    private int onePageRecord = 10;
    private int onePageCount = 5;
    //위는 상수, 아래는 변수
    private int page = 1;
    private int totalRecord;
    private int totalPage;
    private int offsetPoint = (page-1) *onePageRecord;
    private int startPage = 1;
    private String searchKey;
    private String searchWord;
    private int category;
    private int postSort;
    private int boardcategory;

    public void setNowPage(int nowPage){
        this.page = nowPage;
        offsetPoint = (nowPage-1)*onePageRecord;
        startPage = (nowPage-1) / onePageCount*onePageCount+1;
    }
    public void setTotalRecord(int totalRecord){
        this.totalRecord = totalRecord;
        this.setTotalPage((int)Math.ceil(totalRecord/(double)onePageRecord));
    }


}
