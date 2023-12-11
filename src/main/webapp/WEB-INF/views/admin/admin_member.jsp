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
                location.href = "${pageContext.servletContext.contextPath}/delete/user?userid=" + del_target;
            });

            $(".forevent").on('click', "#changeUsername", function () {
                var change_target = $(this).attr("title");
                location.href = "${pageContext.servletContext.contextPath}/change/user?username=" + change_target;
            });

            $("#postSort").change(function () {
                var sortValue = $(this).val();
                location.href = "${pageContext.servletContext.contextPath}/admin/member?postSort=" + sortValue;
            });

            $("#searchBtn").on('click', function () {
                location.href = "${pageContext.servletContext.contextPath}/admin/member?postSort=" + $("#postSort").val()
                    + "&searchKey=" + $("#searchKey").val() + "&searchWord=" + $("#searchWord").val();
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

        .btn {
            color: white;
        }

        #sideBar a,
        #sideBar a:visited,
        #sideBar a:link {
            color: black;
            text-decoration: none;
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
        <h3><a href="${pageContext.servletContext.contextPath}/admin/home">관리자 홈</a></h3>
        <h3>회원관리</h3>
        <a href="${pageContext.servletContext.contextPath}/admin/member"> 일반회원관리 </a>
        <a href="${pageContext.servletContext.contextPath}/admin/company"> 기업회원관리 </a>
        <h3>게시글관리</h3>
        <a href="${pageContext.servletContext.contextPath}/admin/board"> 게시판 모니터링 </a>
        <a href="${pageContext.servletContext.contextPath}/admin/report"> 신고 게시글 관리 </a>
        <a href="${pageContext.servletContext.contextPath}/admin/delete"> 과제 삭제 신청 목록 </a>
        <h3>배너관리</h3>
        <a href="${pageContext.servletContext.contextPath}/admin/banner"> 배너 관리 </a>
        <h3>통계</h3>
        <a href="${pageContext.servletContext.contextPath}/admin/user/stats"> 유저 현황 </a>
        <a href="${pageContext.servletContext.contextPath}/admin/board/stats"> 게시판 현황 </a>
        <a href="${pageContext.servletContext.contextPath}/" style="position: absolute; bottom: 90px;">메인 페이지 이동</a>
        <p style="position: absolute; bottom: 50px;">당일 접속 유저 : ${today}명</p>
        <p style="position: absolute; bottom: 20px;">누적 접속 유저 : ${all}명</p>
    </div>
    <!-- 관리자 페이지 만드실 때 margin-left 여기 참고하시면 됩니다 -->
    <div style="margin-left: 250px; width: 100%; height: 100%; padding: 20px;">
        <h1 style="padding: 15px;">회원관리-일반회원관리</h1>
        <select style="width: fit-content" class="form-select" name="postSort" id="postSort">
            <option value="1" <c:if test="${pVO.postSort==1}">
                selected
            </c:if>>이름
            </option>
            <option value="2"
                    <c:if test="${pVO.postSort==2}"> selected
                    </c:if>>아이디
            </option>
            <option value="3" <c:if test="${pVO.postSort==3}">
                selected
            </c:if>>최신순
            </option>
        </select>
        <table class="table table-hover">
            <tr>
                <th>회원ID</th>
                <th>회원 닉네임</th>
                <th>가입일자</th>
                <th>프로필</th>
                <th>처분</th>
            </tr>
            <c:forEach var="uvo" items="${uVO}">
                <tr class="forevent">
                    <td>${uvo.userid}</td>
                    <td>${uvo.username}</td>
                    <td>${uvo.date}</td>
                    <td><a class="btn btn-sm btn-primary"
                           href="${pageContext.servletContext.contextPath}/profile/portfolio?uid=${uvo.userid}">바로가기</a></td>
                    <td>
                        <button type="button" class="btn btn-danger btn-sm deletion" id="deletion" title="${uvo.userid}">강제탈퇴</button>
                        <button type="button" style="color: black" class="btn btn-warning btn-sm" id="changeUsername" title="${uvo.userid}">닉네임 변경</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <div class="pagination-container" style="margin: 0 auto; margin-top: 20px; width: fit-content">
            <div class="pagination">
                <c:if test="${pVO.page==1}">
                    <button class="btn btn-secondary"><</button>
                </c:if>
                <c:if test="${pVO.page>1}">
                    <button class="btn btn-secondary"
                            onclick="location.href='${pageContext.servletContext.contextPath}/admin/member?page=${pVO.page-1}&postSort=${pVO.postSort}&SearchKey=${pVO.searchKey}&SearchWord=${pVO.searchWord}'">
                        <
                    </button>
                </c:if>
                <c:forEach var="pvo" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
                    <c:if test="${pvo <= pVO.totalPage}">
                        <button class="btn btn-secondary"
                                onclick="location.href='${pageContext.servletContext.contextPath}/admin/member?page=${pvo}&postSort=${pVO.postSort}&SearchKey=${pVO.searchKey}&SearchWord=${pVO.searchWord}'">${pvo}</button>
                    </c:if>
                </c:forEach>
                <c:if test="${pVO.totalPage==pVO.page}">
                    <button class="btn btn-secondary">></button>
                </c:if>
                <c:if test="${pVO.totalPage>pVO.page}">
                    <button class="btn btn-secondary"
                            onclick="location.href='${pageContext.servletContext.contextPath}/admin/member?page=${pVO.page+1}&postSort=${pVO.postSort}&SearchKey=${pVO.searchKey}&SearchWord=${pVO.searchWord}'">
                        >
                    </button>
                </c:if>
            </div>
        </div>
        <div class="search-container" style="display: flex">
            <select style="width: fit-content" class="form-select" name="searchKey" id="searchKey">
                <option value="username">이름</option>
                <option value="userid">아이디</option>
            </select>
            <input type="text" name="searchWord" class="form-control" id="searchWord" placeholder="검색어를 입력하세요." style="width: 200px"/>
            <button id="searchBtn" class="btn btn-primary">검색</button>
        </div>
    </div>
</div>
</body>
</html>
