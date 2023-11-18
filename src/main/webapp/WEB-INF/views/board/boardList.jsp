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
        var selectedValue;
        $(function () {
            if (${boardcat=="free"}) {
                $(".free").addClass("btn-primary").removeClass("btn-outline-primary");
                $(".ask").addClass("btn-outline-primary").removeClass("btn-primary");
                $(".tip").addClass("btn-outline-primary").removeClass("btn-primary");
            } else if (${boardcat=="ask"}) {
                $(".ask").addClass("btn-primary").removeClass("btn-outline-primary");
                $(".free").addClass("btn-outline-primary").removeClass("btn-primary");
                $(".tip").addClass("btn-outline-primary").removeClass("btn-primary");
            } else if (${boardcat=="tip"}) {
                $(".tip").addClass("btn-primary").removeClass("btn-outline-primary");
                $(".ask").addClass("btn-outline-primary").removeClass("btn-primary");
                $(".free").addClass("btn-outline-primary").removeClass("btn-primary");
            }
            $('#category-select').val(${pVO.category});
            $('#category-select').change(function () {
                selectedValue = $(this).val();
                if (selectedValue == 0) {
                    window.location.href = "${pageContext.servletContext.contextPath}/board/${boardcat}";
                } else {
                    window.location.href = "${pageContext.servletContext.contextPath}/board/${boardcat}?category=" + selectedValue;
                }
            });
            $("#postSort").change(function () {
                var sortvalue = $(this).val();
                window.location.href = "${pageContext.servletContext.contextPath}/board/${boardcat}?category=${pVO.category}&postSort=" + sortvalue + "&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}";


            });
        })
    </script>
</head>
<body>
<div class="container">
    <div class="button-container">
        <button class="btn btn-outline-primary free"
                onclick="location.href='${pageContext.servletContext.contextPath}/board/free'">자유 게시판
        </button>
        <button class="btn btn-outline-primary ask"
                onclick="location.href='${pageContext.servletContext.contextPath}/board/ask'">질문 게시판
        </button>
        <button class="btn btn-outline-primary tip"
                onclick="location.href='${pageContext.servletContext.contextPath}/board/tip'">노하우 게시판
        </button>
    </div>
    <div class="d-flex" style="justify-content: space-between; margin-top: 30px">
        <h2>전체 게시판</h2>
        <select class="form-select" style="width: fit-content" id="postSort" name="postSort">
            <option value="1">최신순</option>
            <option value="2">댓글순</option>
            <option value="3">추천순</option>
        </select>
    </div>
    <select class="form-select" id="category-select" style="width: fit-content; margin-top: 50px" name="category">
        <option value="0">카테고리</option>
        <option value="1">IT/프로그래밍</option>
        <option value="2">디자인</option>
        <option value="3">영상음향</option>
    </select>
    <div class="board-container">
        <div class="board-header">
            <div class="header-row">
                <div id="num" style="width: 7%" class="list">번호</div>
                <div id="title" style="width: 50%; text-align: left; padding: 0 20px;" class="list">제목
                </div>
                <div id="user" style="width: 12%" class="list">작성자</div>
                <div id="view" style="width: 7%" class="list">조회수</div>
                <div id="comment" style="width: 7%" class="list">댓글</div>
                <div id="like" style="width: 7%" class="list">좋아요</div>
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
                <div style="width: 7%" class="list">댓글수X</div>
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
        <div class="pagination-container">
            <div class="pagination" style="display: flex">
                <div class="paging">
                    <c:if test="${pVO.page > 1}">
                        <button onclick="location.href='?page=1'">첫 페이지</button>
                        <button onclick="location.href='?page=${pVO.page - 1}'">이전 페이지</button>
                    </c:if>
                    <c:forEach var="i" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
                        <c:if test="${i <= pVO.totalPage}">
                            <c:choose>
                                <c:when test="${i != pVO.page}">
                                    <button onclick="location.href='?page=${i}'">${i}</button>
                                </c:when>
                                <c:otherwise>
                                    <strong>${i}</strong>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pVO.page < pVO.totalPage}">
                        <button onclick="location.href='?page=${pVO.page + 1}'">다음 페이지</button>
                        <button onclick="location.href='?page=${pVO.totalPage}'">마지막 페이지</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>