<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 내용 보기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/6caf283963.js" crossorigin="anonymous"></script>
    <style>

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        article {
            width: 1200px;
            margin: 0 auto;
            margin-top: 30PX;
            border-width: 3px 1px 3px 1px;
            border-style: solid;
            border-color:  #73351F;;
            background: #F2F2F2;
        }

        .board_category {
            background-color: #ddd;
            width: 150px;
            text-align: center;
            border-radius: 10px;
        }

        .board_title {
            display: flex;
            text-align: center;
            align-items: center;
            height: 80px;
            font-size: 2em;
            font-weight: bold;
            border-bottom: 2px solid #73351F;
            padding-left: 20px;
            background: #A69668;
        }

        /* 게시물 정보( 작성자, 날짜, 조회수, 추천수) */
        .board_main{
            border-bottom: 3px solid #73351F;
            border-top: 3px solid #73351F;
            border-left: 1px solid #73351F;
            border-right: 1px solid #73351F;
        }
        .board_info {
            display: flex;
            background:  #D9C8A9;
            align-items: center;
            height: 30px;
        }

        .board_writer {
            display: flex;
            padding-right: 10px;
            border-right: 1px solid darkgray;
            text-align: center;
        }

        .board_date {
            padding-left: 10px;

        }

        .board_info > div:nth-child(n+3) {
            padding-left: 10px;
        }

        .board_view {
            width: 70px;
            text-align: center;
            margin: auto 0 0 auto;
        }

        .board_recommend {
            width: 60px;
            text-align: center;
        }

        /* 게시글 내용 */
        .board_content {
            margin-top: 10px;
        }

        .content_text {
            padding: 10px 20px;
            min-height: 300px;
        }

        .content_recommend {
            width: 80px;
            margin: 0 auto;
            margin-bottom: 20px;
        }

        /* 댓글쓰기 */
        .comment_write {
            margin-top: 15px;
            display: flex;
            border-bottom: 1px solid #ddd;
        }

        .comment_content {
            border: 1px solid #ddd;
            width: 90%;
            height: 100px;
            min-height: 100px;
        }

        .comment_write_ok {
            width: 10%;
            height: 100px;
        }

        /* 댓글 리스트 */
        .comment_main{

        }
        .comment_list{

        }
        .comment_list li {
            float: none;
        }
        .comment_list_content {
            background: #A69668;
            border: 0.5px #73351F solid;
            margin-bottom: 5px;
        }

        .list_img {
            padding: 5px;
            width: 40px;
            height: 40px;
            radius: 50%;
            object-fit: cover;
            border-radius: 70%
        }

        .comment_writer, .comment_date {
            display: inline-block;
        }

        .comment_writer {
            padding: 0 5px;
        }
        .reply_content{
            background: #D9D9D9;
            display: flex;
        }
        /*
        .reply_content > div {
            display: inline-block;
        }
        */
        .reply {
            padding: 10px;
            width: 85%;
            height: 50px;
        }
        .container_bottom{
            display: flex;
            background: #A69668;
            height: 10px;
            margin-top: 10px;
        }
        .reply_btn{
            display: flex;
            align-items: flex-start;
            width: fit-content;
            margin-top: 7.5px;
        }

        /* IE9 이하를 위한 css */
        input::placeholder{
            display: flex;
            text-align: center;
            align-items: center;
        }

    </style>
</head>
<body>
<article>
    <div class="board_title">
        ${wvo.wantedtitle}
    </div>
    <section style="padding: 20px;">
        <div class="board_category" style="margin-bottom: 20px">
            파티홍보 게시판
        </div>
    <div class="board_main">
        <div class="board_info">
            <div class="board_writer">
                ${wvo.username}
            </div>
            <div class="board_date">
                ${wvo.date}
            </div>
            <div class="board_view">
                조회수
            </div>
            <div class="board_view_no">
                ${wvo.view}
            </div>
        </div>
        <div class="board_content">
            <div class="content_text">
                ${wvo.wantedcontent}
            </div>
            <div class="content_recommend"
                 style="width: 100%; display : flex; justify-content: space-between; align-items: center">
                <div></div>
                <button type="button" style="color: white" onclick="applyParty()"
                   class="btn btn-primary"><i class="fa-solid fa-hand"></i>&nbsp신청</button>
                <div class="d-flex" style="margin-right: 10px;">
                    <c:if test="${LogStatus=='Y'}">
                    <a style="height: fit-content; margin-right: 10px" class=" btn btn-outline-danger btn-sm" id="report_post">파티 신고</a>
                    </c:if>
                    <c:if test="${LogId==wvo.user_userid}">
                        <a style="height: fit-content" class=" btn btn-outline-danger btn-sm" id="del_post">삭제</a>
                    </c:if>
                </div>
            </div>
        </div>
        <div>
            <div class="comment_write">
                <input type="hidden" id="wantedid" name="wantedid" value="${wvo.wantedid}">
                <textarea class="comment_content" placeholder="욕설, 비방, 비아냥, 음란, 사행성, 스팸, 광고 댓글은 필터링 또는 삭제됩니다."
                          style="resize: none;"></textarea>
                <button type="button" class="btn btn-secondary comment_write_ok" style="border-radius: 0%; margin: 3px 3px 3px 0px; padding: 0px;"> 댓글 등록</button>
            </div>
            <div style="height: 30px; margin: 0px; background: #D9C8A9;">
            </div>
        </div>
    </div>
    </section>
    <hr style="border: 2px dashed #73351F">
    <section>
        <div style="padding: 20px">
            <div class="comment_main">
                <div class="comment_list">
                    <ul class="comment_list_real">
                    </ul>
                </div>
            </div>
        </div>
        <script>
            function commentList() {
                var no = ${wvo.wantedid};
                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/party/commentLoad",
                    data: {
                        no: no
                    },
                    type: 'post',
                    success: function (result) {//리절트는 commentvo 리스트에 담겨서
                        $(".comment_list_real").empty();
                        for (var i = 0; i < result.length; i++) {
                            var comment = result[i];
                            var marginLeft = comment.depth == 1 ? '70px' : '10px';
                            var htmltag = '<li style="margin-left: ' + marginLeft + '"><div class="comment_list_content"><img src = ${pageContext.servletContext.contextPath}/upload' + comment.profileimg + ' class="list_img"><a href ="${pageContext.servletContext.contextPath}/profile/portfolio?uid=' + comment.user_userid + '" "class="comment_writer">';
                            htmltag += comment.username + '</a> &nbsp<div style="font-size: 12px" class="comment_date">(' + comment.date + ')</div><div class="reply_content"><div class="reply">' + comment.commentcontent;
                            htmltag += '</div><div class="reply_btn">';
                            htmltag += '<input type="hidden" id="commentidForReply" value="' + comment.commentid + '"/>'
                            if (comment.depth == 0) {
                                htmltag += '<div style="margin-right: 10px" id="replyreply"  class="btn btn-outline-secondary btn-sm">답글</div>';
                            }
                            if(${LogStatus=='Y'}){
                                htmltag+='<div style="margin-right: 10px" id="reply_report" class="btn btn-outline-danger btn-sm report_comment">신고</div>';
                            }
                            if ('${LogId}' == comment.user_userid) {
                                htmltag += '<div class="btn btn-outline-danger btn-sm" id="comment_del">삭제</div>';
                            }
                            if (comment.isdelete == 1) {
                                htmltag = '<li style="margin-left: ' + marginLeft + '"><div class="comment_list_content"><div class="comment_writer">';
                                htmltag += '</div><div style="font-size: 12px" class="comment_date">('+comment.date + ')</div><div class="reply_content"><div class="reply">' + comment.commentcontent;
                                htmltag += '</div><div class="reply_btn">';
                            }
                            htmltag += '</div></li>';
                            var commentBlock = $(htmltag);
                            $(".comment_list_real").append(commentBlock);
                            if (${LogStatus!='Y'}) {
                                $("#replyreply").remove();
                            }
                        }
                    }
                });
            }

            $(function () {
                commentList();

                $(".comment_list_real").on('click', '#replyreply', function () {
                    var contentdiv = $(this).parent().parent().parent().parent(); //여기 뒤에 답글 폼 붙여야함.
                    var target_parent = $(this).parent().find('input[type="hidden"]').val();
                    var wantedid = ${wvo.wantedid};
                    var replyform = $(
                        '<div class= "reply-form" style="margin: 5px; width: 100%;">' +
                        '<form id = "reply-reply" style="display: flex; ">' +
                        '<div style="width: 20%"></div>' +
                        '<textarea class="comment_content" id="reply-comment" placeholder="욕설, 비방, 비아냥, 음란, 사행성, 스팸, 광고 댓글은 필터링 또는 삭제됩니다." style="resize:none; width: 70%"></textarea>' +
                        '<input type="hidden" name="postid" value="' + wantedid + '">' +
                        '<input type="hidden" name="target_parent" value="' + target_parent + '" >' +
                        '<button id="replyreplybtn" class="btn btn-secondary comment_write_ok">댓글 등록</button>' +
                        '</form>' +
                        '</div>'
                    );
                    $('.reply-form').remove();
                    contentdiv.after(replyform);
                    $("#reply-reply").on('submit', function () {
                        event.preventDefault();
                        if ($("#reply-comment").val() == "") {
                            alert('답글 내용을 입력 후 시도해주세요');
                            return false;
                        }
                        $.ajax({
                            url: "${pageContext.servletContext.contextPath}/party/commentWrite",
                            data: {
                                commentcontent: $("#reply-comment").val(),
                                target_parent: target_parent,
                                partywanted_wantedid: wantedid
                            },
                            type: 'post',
                            success: function (result) {//리절트는 결국 들어갔냐 안들어갔냐임
                                console.log(result);
                                commentList();
                            }
                        });
                    });
                });

                $(".comment_list_real").on('click','#comment_del',function () {
                    console.log(123);
                    var del_target = $(this).parent().find('input[type="hidden"]').val();
                    if (confirm("정말 댓글을 삭제하시겠습니까?")) {
                        $.ajax({
                            url: "${pageContext.servletContext.contextPath}/party/wanted/commentdel",
                            data: {
                                commentid: del_target
                            },
                            type: 'post',
                            success: function (r) {
                                alert("삭제되었습니다.");
                                commentList();
                            },
                            error: function (e) {
                                console.log(e.responseText);
                            }
                        });
                    }
                });

                $(".comment_write_ok").on('click', function () {
                    if ($(".comment_content").innerText == "") {
                        alert("댓글 작성 후 등록해주세요");
                        return false;
                    }
                    $.ajax({
                        url: "${pageContext.servletContext.contextPath}/party/commentWrite",
                        data: {
                            partywanted_wantedid: $("#wantedid").val(),
                            depth: $("#depth").val(),
                            commentcontent: $(".comment_content").val()
                        },
                        type: 'post',
                        success: function (result) {
                            commentList();
                            $(".comment_content").val("");
                        },
                        error: function (error) {
                            console.log(error.responseText);
                        }
                    });
                });

                $("#del_post").on('click',function(){
                    if(confirm("정말 글을 삭제하시겠습니까?")){
                        var target_id = ${wvo.wantedid};
                        $.ajax({
                            url : "${pageContext.servletContext.contextPath}/party/wanteddel",
                            data:{
                                wantedid : target_id
                            },
                            type:'post',
                            success:function(result){
                                alert("삭제되었습니다.");
                                location.href="${pageContext.servletContext.contextPath}/party/wanted";
                            },
                            error:function(error){
                                console.log(error.responseText);
                            }
                        });
                    }
                });
                $("#report_post").on('click',function(){
                    if(confirm("정말 글을 신고하시겠습니까?")){
                        $.ajax({
                           url : "${pageContext.servletContext.contextPath}/party/wanted/report",
                            data:{
                               target_id:${wvo.wantedid},
                                target_userid:'${wvo.user_userid}',
                                target_title:'${wvo.wantedtitle}'
                            },
                            type:'post',
                            success:function(result){
                               console.log(result);
                               alert("신고되었습니다");
                            },
                            error:function(error){
                               console.log(error.responseText);
                            }

                        });
                    }

                });

                $(".comment_list_real").on('click','.report_comment',function(){
                    if(confirm("정말 댓글을 신고하시겠습니까?")){
                        //원글번호, 대상댓글번호는 미리 따놔야함
                        var originpostid= ${wvo.wantedid};
                        var targetid = $(this).parent().find('input[type="hidden"]').val();
                        $.ajax({
                            url:"${pageContext.servletContext.contextPath}/party/comment/report",
                            data:{
                                originpostid:originpostid,
                                targetid:targetid
                            },
                            type:'post',
                            success:function(result){
                                console.log("신고됨");
                                alert("신고되었습니다.");
                            },
                            error:function(error){
                                console.log(error.responseText);
                            }
                        });
                    }
                });
            });
            function applyParty(){
                var partyid = ${wvo.party_partyid};
                if(confirm("정말 ${wvo.partyname}에 지원하시겠습니까?")){
                    $.ajax({
                       url:"${pageContext.servletContext.contextPath}/party/apply",
                        data:{
                           partyid:partyid
                        },
                        type:'post',
                        success:function(result){
                           console.log(result);
                           alert("신청되었습니다.");
                        },
                        error:function (error){
                           console.log(error.responseText);
                        }
                    });
                }
            }
        </script>
    </section>
    <div class="container_bottom"></div>
</article>
<footer></footer>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>