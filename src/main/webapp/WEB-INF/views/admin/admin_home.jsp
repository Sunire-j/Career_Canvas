<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">

    <style>
        *{font-family: 'Noto Sans KR', sans-serif;}
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
        }

        td {
            vertical-align: middle;
        }

        .top {
            width: 100%;
            display: flex;
            justify-content: center;
            height: 100px;
            align-items: center;
            margin: 30px 0;
            font-size: 20px;
        }

        .top div {
            flex: 1;
            text-align: center;
        }

        #sideBar a,
        #sideBar a:visited,
        #sideBar a:link {
            color: black;
            text-decoration: none;
        }
        a:visited, a:link {
            text-decoration: none;
            color: black;
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
        <div class="top">
            <div class="container p-5 my-5 bg-secondary text-white">오늘 신고된 게시글 : ${rToday}</div>
            <div class="container p-5 my-5 bg-secondary text-white">오늘 신규 가입자 : ${newMember}</div>
        </div>
        <div style="margin-bottom: 20px; height: 363px; border: solid 2px;">
        <h5 style="padding: 15px; text-decoration-line: none;"><a href="${pageContext.servletContext.contextPath}/admin/report">최근 신고글</a></h5>
        <table class="table table-hover">
            <tr>
                <th>번호</th>
                <th>신고자ID</th>
                <th>카테고리</th>
                <th>제목</th>
                <th>작성자ID</th>
                <th>게시글 확인</th>
            </tr>
            <c:forEach var="rvo" items="${rVO}">
                <tr class="forevent">
                    <td>${rvo.reportid}</td>
                    <td>${rvo.user_userid}</td>
                    <td>${rvo.reporttype}</td>
                    <td>${rvo.title}</td>
                    <td>${rvo.userid}</td>
                    <td>
                        <button type="button" class="btn btn-dark btn-sm"
                                <c:if test="${rvo.reporttype=='board'}">
                                    onclick="window.open('${pageContext.servletContext.contextPath}/board/view?no=${rvo.targetid}')">이동
                                </c:if>
                                <c:if test="${rvo.reporttype=='comment'}">
                                    onclick="window.open('${pageContext.servletContext.contextPath}/board/view?no=${rvo.originpostid}')">이동
                                </c:if>
                                <c:if test="${rvo.reporttype=='wanted'}">
                                    onclick="window.open('${pageContext.servletContext.contextPath}/party/wanted/view?no=${rvo.targetid}')">이동
                                </c:if>
                                <c:if test="${rvo.reporttype=='wantedcomment'}">
                                    onclick="window.open('${pageContext.servletContext.contextPath}/party/wanted/view?no=${rvo.originpostid}')">이동
                                </c:if>
                                <c:if test="${rvo.reporttype=='pp'}">
                                    onclick="window.open('${pageContext.servletContext.contextPath}/pofolview?pofolid=${rvo.targetid}')">이동
                                </c:if>
                                <c:if test="${rvo.reporttype=='subject'}">
                                    onclick="window.open('${pageContext.servletContext.contextPath}/subject/applyView?applyid=${rvo.targetid}')">이동
                                </c:if>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        </div>
        <div style="display: flex">
            <div style="width: 50%; height: 363px; border: solid 2px; margin-right: 20px;">
                <h5 style="padding: 15px; text-decoration-line: none;"><a href="${pageContext.servletContext.contextPath}/admin/board">최신 글</a></h5>
                <table class="table table-hover">
                    <tr>
                        <th>글번호</th>
                        <th>게시판 종류</th>
                        <th>제목</th>
                        <th>게시글 확인</th>
                    </tr>
                    <c:forEach var="bvo" items="${bVO}">
                        <tr class="forevent">
                            <td>${bvo.postid}</td>
                            <td>
                                <c:if test="${bvo.boardcategory==0}">
                                    자유 게시판
                                </c:if>
                                <c:if test="${bvo.boardcategory==1}">
                                    질문 게시판
                                </c:if>
                                <c:if test="${bvo.boardcategory==2}">
                                    노하우 게시판
                                </c:if>
                            </td>
                            <td>${bvo.posttitle}</td>
                            <td>
                                <button type="button" class="btn btn-dark btn-sm"
                                        onclick="window.open('${pageContext.servletContext.contextPath}/board/view?no=${bvo.postid}')">이동
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div style="width: 50%; height: 363px; border: solid 2px;">
                <h5 style="padding: 15px; text-decoration-line: none;"><a href="${pageContext.servletContext.contextPath}/admin/company">승인 대기중인 기업 목록</a></h5>
                <table class="table table-hover">
                    <tr>
                        <th>회원ID</th>
                        <th>법인명</th>
                        <th>사업자등록번호</th>
                        <th>승인여부</th>
                        <th>처분</th>
                    </tr>
                    <c:forEach items="${cVO}" var="cvo">
                        <tr>
                            <td>${cvo.user_userid}</td>
                            <td>${cvo.companyname}</td>
                            <td>${cvo.companyno}</td>
                            <td>
                                <c:if test="${cvo.isaccept==1}">
                                    대기중
                                </c:if>
                                <c:if test="${cvo.isaccept==0}">
                                    승인
                                </c:if>
                                <button onclick="window.open('${pageContext.servletContext.contextPath}/admin/company/check?uid=${cvo.user_userid}')"
                                        type="button" class="btn btn-dark btn-sm">증빙확인
                                </button>
                            </td>
                            <td>
                                <c:if test="${cvo.isaccept==1}">
                                    <button onclick="accept('${cvo.user_userid}')" type="button" class="btn btn-primary btn-sm">승인</button>
                                    <button onclick="deny('${cvo.user_userid}')" type="button" class="btn btn-danger btn-sm">거절</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>