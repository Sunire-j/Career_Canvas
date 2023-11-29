<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(function () {
            $(".forevent").on('click', "#deletion", function () {
                var del_target = $(this).attr("title");
                location.href = "${pageContext.servletContext.contextPath}/board/delete?postid=" + del_target;
            });

            $(".forevent").on('click', "#userDeletion", function () {
                var post_id = $(this).attr("title");
                location.href = "${pageContext.servletContext.contextPath}/board/delete/user?postid=" + post_id;
            });
        });
    </script>
    <style>
        #sideBar {
            width: 250px;
            position: fixed;
            height: 100%;
            background-color: #ddd;
            padding: 20px;
        }

        #sideBar h3 {
            margin: 15px 0px;
        }

        #sideBar a {
            width: 100%;
            display: flex;
            height: 30px;
            align-items: center;
        }

        .table {
            width: 100%;
            text-align: center;
            margin-top: 35px;
        }

        td {
            vertical-align: middle;
        }

        .pagination-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
            text-align: center;
        }

        .pagination {
            display: inline-block;
        }

        .btn {
            color: white;
        }
    </style>
</head>
<body>
<div style="display:flex;">
    <div id="sideBar">
        <div style="text-align: center;">
            <h4>관리자 ${name}</h4>
            <a href="${pageContext.servletContext.contextPath}/"
               style="color: red; text-align: center; display: block; margin: 0 auto;">로그아웃</a>
        </div>
        <hr/>
        <h3>회원관리</h3>
        <a href="${pageContext.servletContext.contextPath}/admin/member"> 일반회원관리 </a>
        <a href="${pageContext.servletContext.contextPath}/admin/company"> 기업회원관리 </a>
        <h3>게시글관리</h3>
        <a href="${pageContext.servletContext.contextPath}/admin/board"> 게시판 모니터링 </a>
        <a href="${pageContext.servletContext.contextPath}/admin/report"> 신고 게시글 관리 </a>
        <a href="${pageContext.servletContext.contextPath}/admin/delete"> 과제 삭제 신청 목록 </a>
        <h3>배너관리</h3>
        <a href=""> 배너 관리 </a>
        <h3>통계</h3>
        <a href=""> 유저 현황 </a>
        <a href=""> 게시판 현황 </a>
        <a href="${pageContext.servletContext.contextPath}/" style="position: absolute; bottom: 90px;">메인 페이지 이동</a>
        <p style="position: absolute; bottom: 50px;">당일 접속 유저 : 500명</p>
        <p style="position: absolute; bottom: 20px;">누적 접속 유저 : 50만명ㅋ</p>
    </div>
    <!-- 관리자 페이지 만드실 때 margin-left 여기 참고하시면 됩니다 -->
    <div style="margin-left: 250px; width: 100%; height: 100%; padding: 20px;">
        <h1 style="padding: 15px;">게시판관리-게시판 모니터링</h1>
        <table class="table table-hover">
            <tr>
                <th>글번호</th>
                <th>게시판 종류</th>
                <th>제목</th>
                <th>게시글 확인</th>
                <th>처분</th>
            </tr>
            <c:forEach var="bvo" items="${bVO}">
                <tr class="forevent">
                    <td>${bvo.postid}</td>
                    <td>${bvo.category}</td>
                    <td>${bvo.posttitle}</td>
                    <td>
                        대기중
                        <button type="button" class="btn btn-info" onclick="window.open('${pageContext.servletContext.contextPath}/board/view?no=${bvo.postid}')">이동</button>
                    </td>
                    <td>
                        <button type="button" class="btn btn-danger" id="deletion" title="${bvo.postid}">강제삭제</button>
                        <button type="button" class="btn btn-danger" id="userDeletion" title="${bvo.postid}">강제탈퇴</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <div class="pagination-container">
            <div class="pagination">
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">4</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>