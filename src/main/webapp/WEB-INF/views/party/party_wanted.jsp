<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }

        h2 {
            float: left;
        }

        .container {
            text-align: center;
        }

        .button-container {
            margin-top: 20px;
        }

        .board-container {
            padding: 10px;
            border-radius: 5px;
            margin-top: 20px;
        }

        .board-header {
            font-weight: bold;
        }

        .board-row {
            display: flex;
            width: 100%;
        }

        .header-row {
            display: flex;
        }

        .search-container, .search-button {
            display: inline-block;
        }

        .search-container {
            background-color: #f2f2f2;
        }

        .search-box {
            width: 150px;
            display: inline-block;
            color: #000;
            font-size: 12px;
            border: 1px solid #ddd;
        }


        .pagination-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 20px;
            text-align: center;
        }

        .pagination {
            display: inline-block;
        }

        .pagination a {
            color: black;
            float: left;
            padding: 6px 12px;
            text-decoration: none;
        }

        .pagination a.active {
            background-color: #4CAF50;
            color: white;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
    </style>

    <script>
        $("#postSort").change(function () {
            var sortvalue = $(this).val();
            window.location.href = "${pageContext.servletContext.contextPath}/party/wanted/${boardcat}?category=${pVO.category}&postSort=" + sortvalue + "&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}";
        });
    </script>
</head>
<body>
<div class="container">
    <div class="mypartyvalue">
        <input type="button" class="btn btn-secondary partyvaluebutton1" value="파티 모집"
               onclick="location.href='${pageContext.servletContext.contextPath}/party/wanted'">
        <input type="button" class="btn btn-outline-secondary partyvaluebutton2" value="내 파티"
               onclick="location.href='${pageContext.servletContext.contextPath}/myteam/main'">
    </div>
    <div class="d-flex" style="justify-content: space-between; margin-top: 30px">
        <h2>파티홍보 게시판</h2>
        <select class="form-select" style="width: fit-content" id="postSort" name="postSort">
            <option value="1"
                    <c:if test="${pVO.postSort==1}">
                        selected
                    </c:if>
            >최신순
            </option>
            <option value="2" <c:if test="${pVO.postSort==2}">
                selected
            </c:if>>조회순
            </option>
        </select>
    </div>
    <div class="board-container">
        <div class="board-header">
            <div class="header-row">
                <div id="num" style="width: 7%" class="list">번호</div>
                <div id="partyid" style="width: 17%">파티명</div>
                <div id="title" style="width: 40%; text-align: left; padding: 0 20px;" class="list">제목
                </div>
                <div id="user" style="width: 12%" class="list">작성자</div>
                <div id="view" style="width: 7%" class="list">조회수</div>
                <div id="comment" style="width: 7%" class="list">댓글</div>
                <div id="date" style="width: 10%" class="list">게시일</div>
            </div>
        </div>
        <hr>
        <c:forEach items="${bVO}" var="bvo">
            <div class="board-row">
                <div style="width: 7%" class="list">${bvo.postid}</div>
                <div style="width: 50%; text-align: left; padding: 0 20px;" class="list"><a
                        href="${pageContext.servletContext.contextPath}/board/view?no=${bvo.postid}">${bvo.posttitle}</a>
                </div>
                <div style="width: 12%" class="list">${bvo.user_userid}</div>
                <div style="width: 7%" class="list">${bvo.views}</div>
                <div style="width: 7%" class="list">${bvo.commentAmount}</div>
                <div style="width: 7%" class="list">${bvo.likeAmount}</div>
                <div style="width: 10%" class="list">${bvo.date}</div>
            </div>
            <hr>
        </c:forEach>


        <div class="search-container">
            <form action="${pageContext.request.contextPath}/board/${boardcat}" class="d-flex" method="get">
                <select class="form-select" style="width: fit-content" name="searchKey">
                    <option value="all">전체</option>
                    <option value="title">제목</option>
                    <option value="author">작성자</option>
                    <option value="content">글내용</option>
                </select>
                <input type="text" class="form-control" name="searchWord" placeholder="검색어를 입력하세요">
                <input type="submit" class="btn btn-success" value="검색">
                <input type="hidden" name="category" value="${pVO.category}"/>
            </form>
        </div>

        <div style="display: flex; justify-content: space-between">
            <div></div>
            <div>
                <!-- 페이징 있어야하는 자리 -->
            </div>
            <a style="margin-top: 20px; color: white"
               href="${pageContext.servletContext.contextPath}/party/wanted/write" class="btn-primary btn">글 작성</a>
        </div>
    </div>
</div>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>