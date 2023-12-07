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
            border: 1px #73351F solid;
            background: #D9D9D9;
            padding: 40px;
        }

        .board_category {
            background-color: #ddd;
            width: 150px;
            text-align: center;
            border-radius: 10px;
        }

        .board_title {
            margin-top: 20px;
            font-size: 2em;
            font-weight: bold;
            margin-bottom: 20px;

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
            width: 60px;
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
            margin-left: 3px;
            margin-bottom: 3px;
            margin-top: 3px;
        }

        .comment_write_ok {
            width: 10%;
            height: 100px;
        }

        /* 댓글 리스트 */
        .comment_main{

        }
        .comment_list{
            background:  #A69668;

        }
        .comment_list li {
            float: none;
        }
        .comment_list_content {
            padding-top: 10px;
            padding-bottom: 10px;
            border: 0.5px #73351F solid;
        }

        .list_img {
            width: 50px;
            height: 50px;
            border-radius: 15px;
        }

        .comment_writer, .comment_date {
            display: inline-block;
        }

        .comment_writer {
            padding: 0 5px;
        }
        .reply_content{
            background: #D9D9D9;
            margin-bottom: 15px;
        }
        .reply_content > div {
            display: inline-block;
        }

        .reply {
            padding: 10px;
            width: 85%;
            height: 50px;
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
    <section>
        <div class="board_category">
            기업과제
        </div>

        <div class="board_title">
            ${Svo.subjecttitle}
        </div>
    <div class="board_main">
        <div class="board_info">
            <div class="board_writer">
                ${Svo.username}
            </div>
            <div class="board_date">
                ${Svo.date}
            </div>
        </div>
        <div class="board_content">
            <div class="content_text">
                ${Svo.subjectcontent}
            </div>
            <div class="content_recommend"
                 style="width: 100%; display : flex; justify-content: space-between; align-items: center">
                <div></div>
                <button type="button" style="color: white" onclick="applySubject()"
                   class="btn btn-primary"><i class="fa-solid fa-hand"></i>&nbsp제출</button>
                <div class="d-flex">
                    <c:if test="${LogId==Svo.user_userid}">
                        <a style="height: fit-content" class=" btn btn-outline-danger btn-sm" id="del_post"
                           onclick="window.open('${pageContext.servletContext.contextPath}/subject/del?subjectid=${Svo.subjectid}', '팝업', 'width=600, height=300') ">삭제 신청</a>
<%--                        onclick="location.href='${pageContext.servletContext.contextPath}/subject/del?subjectid=${Svo.subjectid}'--%>
                    </c:if>
                </div>
            </div>
        </div>
        <div>

            <div style="height: 30px; margin: 0px; background: #D9C8A9;">
            </div>
        </div>
    </div>



        <script>

            function applySubject(){
                var no = ${Svo.subjectid};
                if(confirm("과제명 : ${Svo.subjecttitle} \n제출 하시겠습니까?")){
                    $.ajax({
                       url:"${pageContext.servletContext.contextPath}/subject/apply",
                        data:{
                           no:no
                        },
                        type:'post',
                        success:function(result){
                           console.log(result);
                           alert("제출되었습니다.");
                        },
                        error:function (error){
                           console.log(error.responseText);
                        }
                    });
                }
            }
        </script>
    </section>
</article>
<footer></footer>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>