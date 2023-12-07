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
        <h1 style="padding: 15px;">회원관리-기업회원관리</h1>
        <select style="height: 30px" name="postSort" id="postSort">
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
            <option value="4" <c:if test="${pVO.postSort==4}">
                selected
            </c:if>>승인여부
            </option>
        </select>
        <table class="table table-hover">
            <tr>
                <th>회원ID</th>
                <th>법인명</th>
                <th>가입일자</th>
                <th>사업자등록번호</th>
                <th>승인여부</th>
                <th>처분</th>
            </tr>
            <c:forEach items="${cVO}" var="cvo">
                <tr>
                    <td>${cvo.user_userid}</td>
                    <td>${cvo.companyname}</td>
                    <td>${cvo.date}</td>
                    <td>${cvo.companyno}</td>
                    <td>
                        <c:if test="${cvo.isaccept==1}">
                        대기중
                        </c:if>
                        <c:if test="${cvo.isaccept==0}">
                            승인
                        </c:if>
                        <button onclick="window.open('${pageContext.servletContext.contextPath}/admin/company/check?uid=${cvo.user_userid}')" type="button" class="btn btn-info btn-sm">증빙확인</button>
                    </td>
                    <td>
                        <c:if test="${cvo.isaccept==1}">
                        <button onclick="accept('${cvo.user_userid}')" type="button" class="btn btn-primary btn-sm">승인</button>
                        <button onclick="deny('${cvo.user_userid}')" type="button" class="btn btn-danger btn-sm">거절</button>
                        </c:if>
                        <c:if test="${cvo.isaccept==0}">
                            <button onclick="forceDeleteCompany('${cvo.user_userid}')" type="button" class="btn btn-danger btn-sm">강제탈퇴</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <script>
                function accept(userid){
                    var url = "${pageContext.servletContext.contextPath}/admin/company/accept?uid="+userid;
                    if(confirm("정말 "+userid+"회원가입을 승인하시겠습니까?")){
                        location.href=url;
                    }
                }
                function deny(userid){
                    var url = "${pageContext.servletContext.contextPath}/admin/company/deny?uid="+userid;
                    if(confirm("정말 "+userid+"회원가입을 거절하시겠습니까?")){
                        location.href=url;
                    }
                }
                function forceDeleteCompany(userid){
                    var url = "${pageContext.servletContext.contextPath}/admin/company/forceDelete?uid="+userid;
                    if(confirm("정말"+userid+"회원을 강제탈퇴시키겠습니까?")){
                        location.href=url;
                    }
                }
                $(function(){
                    $("#postSort").change(function () {
                        var sortValue = $(this).val();
                        location.href = "${pageContext.servletContext.contextPath}/admin/company?postSort=" + sortValue;
                    });

                    $("#searchBtn").on('click', function () {
                        location.href = "${pageContext.servletContext.contextPath}/admin/company?postSort=" + $("#postSort").val()
                            + "&searchKey=" + $("#searchKey").val() + "&searchWord=" + $("#searchWord").val();
                    });
                });

            </script>
        </table>
        <div class="pagination-container">
            <div class="pagination">
                <c:if test="${pVO.page==1}">
                    <
                </c:if>
                <c:if test="${pVO.page>1}">
                    <a href="${pageContext.servletContext.contextPath}/admin/company?page=${pVO.page-1}&postSort=${pVO.postSort}&SearchKey=${pVO.searchKey}&SearchWord=${pVO.searchWord}"><</a>
                </c:if>
                <c:forEach var="pvo" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
                    <c:if test="${pvo <= pVO.totalPage}">
                        <a href="${pageContext.servletContext.contextPath}/admin/company?page=${pvo}&postSort=${pVO.postSort}&SearchKey=${pVO.searchKey}&SearchWord=${pVO.searchWord}">${pvo}</a>
                    </c:if>
                </c:forEach>
                <c:if test="${pVO.totalPage==pVO.page}">
                    >
                </c:if>
                <c:if test="${pVO.totalPage>pVO.page}">
                    <a href="${pageContext.servletContext.contextPath}/admin/company?page=${pVO.page+1}&postSort=${pVO.postSort}&SearchKey=${pVO.searchKey}&SearchWord=${pVO.searchWord}">></a>
                </c:if>
            </div>
        </div>
        <div class="search-container">
            <select style="height:30px" name="searchKey" id="searchKey">
                <option value="username">이름</option>
                <option value="userid">아이디</option>
            </select>
            <input type="text" name="searchWord" id="searchWord" placeholder="검색어를 입력하세요." style="height: 30px"/>
            <button id="searchBtn">검색</button>
        </div>
    </div>
</div>
</body>
</html>
