<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/users/boardList.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        h2 {
            float: left;
        }

        .container {
            text-align: center;
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
            width: 500px;
            height: 40px;
        }

        h2 {
            float: left;
        }

        .button-container {
            margin-top: 20px;
        }

        .board-container {
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
        $(function(){
            $("#postSort").change(function () {
                var sortvalue = $(this).val();
                console.log(sortvalue);
                window.location.href = "${pageContext.servletContext.contextPath}/party/wanted?postSort=" + sortvalue + "&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}";
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="container-top">
        <div class="container-head" style="height: 80px; border-bottom: 2px solid #73351F">
            <div class="mypartyvalue">
                <h2 class="main-title" style="margin-top: 0px; font-weight: bold; font-size: 35px">파티홍보 게시판</h2>
            </div>
        </div>
        <div class="d-flex" style="display: flex; padding: 5px; justify-content: center">
            <div style="justify-content: center; text-align: center">
            <input type="button" class="btn btn-secondary partyvaluebutton1" value="파티 모집"
                   onclick="location.href='${pageContext.servletContext.contextPath}/party/wanted'">
            <input type="button" class="btn btn-outline-secondary partyvaluebutton2" value="내 파티" style="margin-left: 20px;"
                   onclick="location.href='${pageContext.servletContext.contextPath}/myteam/main'">
            </div>
            <select class="form-select" style="width: fit-content; margin-left: 820px" id="postSort" name="postSort">
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
    </div>
    <div class="board-container">
        <div class="board-container-set">
        <div class="board-header">
            <div class="header-row">
                <div id="num" style="width: 7%" class="list">번호</div>
                <div id="partyid" style="width: 17%">파티명</div>
                <div id="title" style="width: 40%; text-align: left; padding: 0 20px;" class="list">제목
                </div>
                <div id="user" style="width: 12%" class="list">작성자</div>
                <div id="view" style="width: 7%" class="list">조회수</div>
                <div id="comment" style="width: 7%" class="list">댓글</div>
                <div id="date" style="width: 20%" class="list">게시일</div>
            </div>
        </div>
            <hr class="hr-styleset">
        <c:forEach items="${wVO}" var="bvo">
            <div class="board-row">
                <div style="width: 7%" class="list">${bvo.wantedid}</div>
                <div style="width: 17%">${bvo.partyname}</div>
                <div style="width: 40%; text-align: left; padding: 0 20px;" class="list"><a
                        href="${pageContext.servletContext.contextPath}/party/wanted/view?no=${bvo.wantedid}">${bvo.wantedtitle}</a>
                </div>
                <div style="width: 12%" class="list">${bvo.user_userid}</div>
                <div style="width: 7%" class="list">${bvo.view}</div>
                <div style="width: 7%" class="list">${bvo.commentAmount}</div>
                <div style="width: 20%" class="list">${bvo.date}</div>
            </div>
            <hr class="hr-styleset">
        </c:forEach>


        <div class="search-container">
            <form action="${pageContext.request.contextPath}/board/wanted/" class="d-flex board-bottom" method="get">
                <select class="form-select" style="width: fit-content; margin-right: 10px" name="searchKey">

                    <option value="all">전체</option>
                    <option value="title">제목</option>
                    <option value="author">작성자</option>
                    <option value="content">글내용</option>
                    <option value="partyname">파티명</option>
                </select>
                <input type="text" class="form-control" name="searchWord" placeholder="검색어를 입력하세요" style="margin-right: 10px">
                <input type="submit" class="btn btn-secondary" value="검색">
            </form>
        </div>

        <div style="display: flex; justify-content: space-between">
            <div style="width: 80px"></div>
            <div>
                <div class="pagination-container" style="margin: 0 auto; margin-top: 20px; width: fit-content">
                    <div class="pagination" style="display: flex">
                        <div class="paging">
                            <ul class="pagination justify-content-center d-flex">
                            <c:if test="${pVO.page > 1}">
                                <li class="page-item"><a class="page-link" href="'?page=${pVO.page - 1}'
                                <c:if test="${pVO.searchWord!=''}">
                                        +'&searchKey=${pVO.searchKey}'
                                        +'&searchWord=${pVO.searchWord}'
                                </c:if>
                                <c:if test="${pVO.postSort!=''}">
                                        +'&postSort=${pVO.postSort}'
                                </c:if>
                                        "><
                                </a></li>
                            </c:if>
                            <c:forEach var="i" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
                                <c:if test="${i <= pVO.totalPage}">
                                    <c:choose>
                                        <c:when test="${i != pVO.page}">
                                                    <li class="page-item"><a class="page-link" href='?page=${i}'
                                            <c:if test="${pVO.searchWord!=''}">
                                                    +'&searchKey=${pVO.searchKey}'
                                                    +'&searchWord=${pVO.searchWord}'
                                            </c:if>
                                            <c:if test="${pVO.postSort!=''}">
                                                    +'&postSort=${pVO.postSort}'
                                            </c:if>
                                                    ">${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                <li class="page-item"><a class="page-link active" href="">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                            <c:if test="${pVO.page < pVO.totalPage}">
                                <li class="page-item"><a class="page-link" href="'?page=${pVO.page + 1}'
                                <c:if test="${pVO.searchWord!=''}">
                                        +'&searchKey=${pVO.searchKey}'
                                        +'&searchWord=${pVO.searchWord}'
                                </c:if>
                                <c:if test="${pVO.postSort!=''}">
                                        +'&postSort=${pVO.postSort}'
                                </c:if>
                                        ">>
                                </a></li>
                            </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <a style="margin-top: 20px; color: white"
               href="${pageContext.servletContext.contextPath}/party/wanted/write" class="btn btn-secondary">글 작성</a>
        </div>
    </div>
    <div class="container_bottom"></div>
    </div>
</div>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>