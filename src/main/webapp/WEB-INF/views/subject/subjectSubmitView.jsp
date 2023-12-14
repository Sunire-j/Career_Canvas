<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@include
        file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>글 내용 보기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script
            src="https://kit.fontawesome.com/6caf283963.js"
            crossorigin="anonymous"
    ></script>
    <style>
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        article {
            width: 1200px;
            margin: 0 auto;
            margin-top: 30px;
            border-width: 3px 1px 3px 1px;
            border-style: solid;
            border-color: #73351f;
            background: #f2f2f2;
        }

        .board_category {
            background-color: #ddd;
            width: 170px;
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
            border-bottom: 2px solid #73351f;
            padding-left: 20px;
            background: #a69668;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        /* 게시물 정보( 작성자, 날짜, 조회수, 추천수) */
        .board_main {
            border-bottom: 3px solid #73351f;
            border-top: 3px solid #73351f;
            border-left: 1px solid #73351f;
            border-right: 1px solid #73351f;
        }

        .board_info {
            display: flex;
            background: #d9c8a9;
            align-items: center;
            height: 30px;
        }

        .board_writer {
            display: flex;
            padding-right: 10px;

            text-align: center;
        }

        .board_date {
            padding-left: 10px;
            border-left: 1px solid darkgray;
        }

        .board_info > div:nth-child(n + 3) {
            padding-left: 10px;
        }

        .board_view {
            width: 70px;
            text-align: center;
            margin: auto 0 0 auto;
        }

        .board_recommend {
            width: 70px;
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
        .comment_main {
        }

        .comment_list {
        }

        .comment_list li {
            float: none;
        }

        .comment_list_content {
            background: #a69668;
            border: 0.5px #73351f solid;
            margin-bottom: 5px;
        }

        .list_img {
            width: 50px;
            height: 50px;
            border-radius: 15px;
        }

        .comment_writer,
        .comment_date {
            display: inline-block;
        }

        .comment_writer {
            padding: 0 5px;
        }

        .reply_content {
            background: #d9d9d9;
            display: flex;
        }

        .reply {
            padding: 10px;
            width: 85%;
        }

        .container_bottom {
            display: flex;
            background: #a69668;
            height: 10px;
            margin-top: 10px;
        }

        .reply_btn {
            display: flex;
            align-items: flex-start;
            width: fit-content;
        }

        .memberlist {
            display: flex;
        }

        .membername {
            margin: 0 5px;
        }

        figure img {
            max-width: 1116px;
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
        .comment_main {
        }

        .comment_list {
        }

        .comment_list li {
            float: none;
        }

        .comment_list_content {
            background: #a69668;
            border: 0.5px #73351f solid;
            margin-bottom: 5px;
        }

        .list_img {
            padding: 5px;
            width: 40px;
            height: 40px;
            radius: 50%;
            object-fit: cover;
            border-radius: 70%;
        }

        .comment_writer,
        .comment_date {
            display: inline-block;
        }

        .comment_writer {
            padding: 0 5px;
        }

        .reply_content {
            background: #d9d9d9;
            display: flex;
        }

        .reply {
            padding: 10px;
            width: 85%;
        }

        .container_bottom {
            display: flex;
            background: #a69668;
            height: 10px;
            margin-top: 10px;
        }

        .reply_btn {
            display: flex;
            align-items: flex-start;
            width: fit-content;
            margin-top: 7.5px;
        }

        figure img {
            max-width: 1116px;
        }
    </style>
</head>
<body>
<article>
    <div class="board_title" style="text-align: center">
        과제명 : ${svo.subjecttitle}
    </div>
    <section style="padding: 20px">
        <div style="display: flex">
            <div class="board_category" style="margin-bottom: 20px">
                기업과제 제출 게시판
            </div>
            <c:if test="${svo.category>0}">
                <div style="background: black; width: 90px; margin-left : 10px;text-align: center; color: white; border-radius: 10px; margin-bottom: 20px">
                    <c:if test="${svo.category==1}">
                        IT/개발
                    </c:if>
                    <c:if test="${svo.category==2}">
                        디자인
                    </c:if>
                    <c:if test="${svo.category==3}">
                        영상/음향
                    </c:if>
                </div>
            </c:if>
        </div>
        <div class="board_main">
            <div class="board_info">
                <div class="board_writer">
                    <a
                            href="${pageContext.servletContext.contextPath}/profile/portfolio?uid=${avo.user_userid}"
                    >${avo.username}</a
                    >
                </div>
                <div class="board_date">
                    <c:if test="${avo.isteam==1}"> </c:if>
                    <c:if test="${avo.isteam==0}"> 파티명 : ${partyname}&nbsp </c:if>
                </div>
            </div>

            <div class="board_content">
                <div class="content_text">${avo.applycontent}</div>
                <div class="memberlist" style="margin-left: 20px">
                    <c:if test="${avo.isteam==0}">
                        <div class="membername">
                            참여 인원 :
                            <c:forEach var="uvo" items="${member}">
                                <a
                                        class="badge rounded-pill bg-primary"
                                        style="color: white; font-size: 15px"
                                        href="${pageContext.servletContext.contextPath}/profile/portfolio?uid=${uvo.userid}"
                                >${uvo.username}</a
                                >
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
                <div
                        class="content_recommend"
                        style="
                width: 100%;
                display: flex;
                justify-content: space-between;
                align-items: center;
              "
                >
                    <div style="width: 200px"></div>
                    <button
                            type="button"
                            class="btn btn-success"
                            onclick="location.href='${pageContext.servletContext.contextPath}/subject/view?no=${avo.subject_subjectid}'"
                    >
                        해당 기업과제 공고보기
                    </button>
                    <div class="d-flex" style="margin-right: 10px; width: 200px; justify-content: flex-end">
                        <c:if test="${LogStatus=='Y'}">
                            <a
                                    style="height: fit-content; margin-right: 10px"
                                    class="btn btn-outline-danger btn-sm"
                                    id="report_post"
                            >게시글 신고</a
                            >
                        </c:if>
                        <c:if test="${LogId==avo.user_userid}">
                            <a
                                    style="height: fit-content"
                                    class="btn btn-outline-danger btn-sm"
                                    id="del_post"
                            >게시글 삭제</a
                            >
                        </c:if>
                    </div>
                </div>
            </div>
            <c:set var="matchFound" value="false" />
                <c:forEach items="${member}" var="m">
                    <c:if test="${LogId==m.userid}">
                        <c:set var="matchFound" value="true" />
                    </c:if>
                </c:forEach>
            <c:if test="${LogId==avo.user_userid}">
                <c:set var="matchFound" value="true"/>
            </c:if>
            <c:if test="${matchFound || LogId==CompanyId}">
            <!-- 개인이면 아이디만 비교하면 끝, 팀이면 멤버 다 허용해주기-->
            <p style="font-size: 1.5rem; margin-left: 10px; margin-top:30px; font-weight: bold">과제 코멘트</p>
            <c:if test="${LogId==CompanyId}">
            <div class="comment_write">
                <input type="hidden" id="postid" name="applyid" value="${avo.applyid}"/>
                <textarea class="comment_content" placeholder="본 과제에 관한 코멘트를 남겨주세요. 코멘트는 과제제출 기업, 과제 참여자만 확인이 가능합니다."
                          style="resize: none"></textarea>
                <button type="button" class="btn btn-secondary comment_write_ok" style="border-radius: 0%">
                    코멘트 등록
                </button>
            </div>
    </c:if>
            <div style="height: 30px; margin: 0px; background: #d9c8a9"></div>
        </div>
    </section>
    <hr style="border: 2px dashed #73351f"/>
    <!-- 여기서부터 코멘트 리스트영역 -->
    <section>
        <div style="padding: 20px">
            <div class="comment_main">
                <div class="comment_list">
                    <ul class="comment_list_real"></ul>
                </div>
            </div>
        </div>
    </section>
    </c:if>
    <script>
        $(function () {
            if ($('.comment_list_real').length) {
                console.log("존재함");
                reloadComment();
            } else {
                console.log("없음");
            }

            function reloadComment() {
                //로드 구현하고 c:if문 조건 or절 추가해줘야함
                //어차피 존재하는건 알았으니 바로 코멘트 불러와주면 됨
                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/subject/comment/load",
                    data: {
                        applyid:${avo.applyid}
                    },
                    type: 'post',
                    success: function (result) {
                        //갔다왔음
                        $(".comment_list_real").empty();
                        for (var i = 0; i < result.length; i++) {
                            var comment = result[i];
                            var htmltag = '<li style="margin-left: 10px"><div class="comment_list_content"><img src = ${pageContext.servletContext.contextPath}/upload' + comment.img + ' class="list_img"><a href ="${pageContext.servletContext.contextPath}/profile/portfolio?uid=' + comment.userid + '" "class="comment_writer">';
                            htmltag += comment.username + '</a> &nbsp<div style="font-size: 12px" class="comment_date">(' + comment.date + ')</div>&nbsp;'
                            htmltag += '<div class="reply_content"><div class="reply">' + comment.sccontent;
                            htmltag += '</div></li>';
                            var commentBlock = $(htmltag);
                            $(".comment_list_real").append(commentBlock);
                        }
                    }
                });
            }

            //만들어야할 것 : 코멘트 등록+리로드만, 나머지는 안할거임 아니 못함 ㅅㅂ
            $(".comment_write_ok").on('click', function () {
                //공백 체크해야함
                if ($(".comment_content").val() == "") {
                    alert("내용을 입력 후 시도해주세요");
                    return false;
                }
                if (!confirm("등록 후에는 수정/삭제가 불가능합니다. 정말 등록하시겠습니까?")) {
                    return false;
                }
                var applyid = $("#postid").val();
                var content = $(".comment_content").val();

                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/subject/comment/write",
                    data: {
                        applyid: applyid,
                        sccontent: content
                    },
                    type: 'post',
                    success: function () {
                        $(".comment_content").val("");
                        reloadComment();
                    }
                })
            })

            $("#del_post").on('click', function () {
                if (confirm("정말 글을 삭제하시겠습니까?")) {
                    var target_id = ${avo.applyid};
                    $.ajax({
                        url: "${pageContext.servletContext.contextPath}/subject/applydel",
                        data: {
                            applyid: target_id
                        },
                        type: 'post',
                        success: function (result) {
                            alert("삭제되었습니다.");
                            location.href = "${pageContext.servletContext.contextPath}/subject/apply";
                        }
                    });
                }
            });

            $("#report_post").on('click', function () {
                if (confirm("정말 글을 신고하시겠습니까?")) {
                    $.ajax({
                        url: "${pageContext.servletContext.contextPath}/subject/applyreport",
                        data: {
                            target_id:${avo.applyid},
                            target_userid: '${avo.user_userid}'
                        },
                        type: 'post',
                        success: function (result) {
                            alert("신고되었습니다");
                        }
                    });
                }

            });
        });
    </script>
    <div class="container_bottom"></div>
</article>
<footer></footer>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>
