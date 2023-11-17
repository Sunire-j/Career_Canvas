<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        li {
            float: left;
        }

        article {
            width: 1000px;
            height: 1500px;
            margin: 0 auto;
            margin-top: 30PX;
        }

        .board_category{
            background-color: #ddd;
            width: 100px;
            text-align: center;
            border-radius: 10px;
        }

        .board_title{
            margin-top: 20px;
            font-size: 2em;
            font-weight: bold;
            margin-bottom: 20px;

        }

        /* 게시물 정보( 작성자, 날짜, 조회수, 추천수) */
        .board_info{
            display: flex;
        }
        .board_writer{
            padding-right: 10px;
            border-right: 1px solid darkgray;
        }
        .board_date{
            padding-left: 10px;
        }
        .board_info>div:nth-child(n+3){
            padding-left: 10px;
        }
        .board_view{
            width: 60px;
            text-align: center;
            margin: auto 0 0 auto;
        }
        .board_recommend{
            width: 60px;
            text-align: center;
        }

        /* 게시글 내용 */
        .board_content{
            margin-top: 20px;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
        }
        .content_text{
            padding: 10px 20px;
            min-height: 300px;
        }
        .content_recommend{
            width: 80px;
            margin: 0 auto;
            margin-bottom: 20px;
        }

        /* 댓글쓰기 */
        .comment_write{
            margin-top: 20px;
            display: flex;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }

        .comment_content{
            border: 1px solid #ddd;
            border-radius: 15px;
            width: 90%;
            min-height: 100px;
            padding: 10px;
            margin-right: 10px;
        }
        .comment_write_ok{
            width: 10%;
            border-radius: 15px;
        }

        /* 댓글 리스트 */
        .comment_list li{
            float: none;
        }
        .comment_list_content{
            padding-top: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        .list_img{
            width: 50px;
            height: 50px;
            border-radius: 15px;
        }
        .comment_writer, .comment_date{
            display: inline-block;
        }
        .comment_writer{
            padding:0 5px;
        }
        .reply_content>div{
            display: inline-block;
        }
        .reply{
            padding: 10px;
            width: 89%;
            height: 50px;
        }
        .comment_del, .comment_reply{
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <article>
        <section>
            <div class="board_category">
                <c:if test="${bvo.boardcategory==0}">
                    자유
                </c:if>
                <c:if test="${bvo.boardcategory==1}">
                    질문
                </c:if>
                <c:if test="${bvo.boardcategory==2}">
                    노하우
                </c:if>
                    게시판

            </div>
            <div class="board_title">
                ${bvo.posttitle}
            </div>

            <div class="board_info">
                <div class="board_writer">
                    ${bvo.user_userid}
                </div>
                <div class="board_date">
                    ${bvo.date}
                </div>
                <div class="board_view">
                    조회수
                </div>
                <div class="board_view_no">
                    ${bvo.views}
                </div>
                <div class="board_recommend">
                    추천수
                </div>
                <div class="board_recommend_no">
                    ${postlike}
                </div>
            </div>

            <div class="board_content">
                <div class="content_text">
                    ${bvo.postcontent}
                </div>
                <div class="content_recommend">
                    <a href="${pageContext.servletContext.contextPath}/board/like?no=${bvo.postid}" class="btn btn-primary"><i class="fa-solid fa-thumbs-up"></i>&nbsp추천</a>
                </div>
            </div>
            <form>
                <div class="comment_write">
                    <textarea class="comment_content" placeholder="욕설, 비방, 비아냥, 음란, 사행성, 스팸, 광고 댓글은 필터링 또는 삭제됩니다." style="resize: none;"></textarea>
                    <button type="button" class="btn btn-secondary comment_write_ok"> 댓글 등록</button>
                </div>
            </form>
            <div class="comment_list">
                <ul>
                    <li>
                        <div class="comment_list_content">
                            <img src="profile.PNG" class="list_img"/>
                            <div class="comment_writer">
                                홍**
                            </div>
                            <div class="comment_date">
                                ( 23.11.10 )
                            </div>
                            <div class="reply_content">
                                <div class="reply">
                                    저랑 ㄱㄱ
                                </div>
                                <div class="reply_btn">
                                    <button type="button" class="btn btn-secondary btn-sm comment_del">삭제</button>
                                    <button type="button" class="btn btn-secondary btn-sm comment_reply">답글</button>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="comment_list_content">
                            <img src="profile.PNG" class="list_img"/>
                            <div class="comment_writer">
                                홍**
                            </div>
                            <div class="comment_date">
                                ( 23.11.10 )
                            </div>
                            <div class="reply_content">
                                <div class="reply">
                                    출근이나 해 ㅋㅋ
                                </div>
                                <div class="reply_btn">
                                    <button type="button"  class="btn btn-secondary btn-sm comment_del">삭제</button>
                                    <button type="button"  class="btn btn-secondary btn-sm comment_reply">답글</button>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </section>
    </article>
<footer> </footer>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>