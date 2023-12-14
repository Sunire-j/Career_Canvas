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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">

    <script>
        $(function () {
            $(".forevent").on('click', "#deletion", function () {
                var del_target = $(this).attr("title");
                var del_type = $(this).val();
                location.href = "${pageContext.servletContext.contextPath}/report/delete?targetid=" + del_target + "&reporttype=" + del_type;
            });

            $(".forevent").on('click', "#dismiss", function () {
                var dis_target = $(this).attr("title");
                location.href = "${pageContext.servletContext.contextPath}/report/dismiss?targetid=" + dis_target;
            });
            // 부모속성,    이벤트이름, 실제로 클릭 된 자식, 이벤트 발생 시 호출함수
            $(".forevent").on('click', "#deletionUser", function () {
                var target_id = $(this).attr("title");
                var del_type = $(this).val();
                location.href = "${pageContext.servletContext.contextPath}/report/delete/user?target_id=" + target_id + "&reporttype=" + del_type;
            });
        });
    </script>
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
        <h1 style="padding: 15px;">게시판관리-신고 게시글 관리</h1>
        <table class="table table-hover">
            <tr>
                <th>번호</th>
                <th>신고자ID</th>
                <th>카테고리</th>
                <th>제목</th>
                <th>작성자ID</th>
                <th>게시글 확인</th>
                <th>처분</th>
            </tr>
            <c:forEach var="rvo" items="${rVO}">
                <tr class="forevent">
                    <td>${rvo.reportid}</td>
                    <td>${rvo.user_userid}</td>
                    <td>${rvo.reporttype}</td>
                    <td style="max-width: 400px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis">${rvo.title}</td>
                    <td>${rvo.userid}</td>
                    <td>
                        <button type="button" class="btn btn-primary btn-sm"
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
                    <td>
                        <button type="button" class="btn btn-danger btn-sm" id="deletionUser" title="${rvo.targetid}" value="${rvo.reporttype}">탈퇴
                        </button>
                        <button type="button" style="color: black" class="btn btn-warning btn-sm" id="deletion" title="${rvo.targetid}" value="${rvo.reporttype}">삭제
                        </button>
                        <button type="button" class="btn btn-success btn-sm" id="dismiss" title="${rvo.targetid}">기각</button>
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
                            onclick="location.href='${pageContext.servletContext.contextPath}/admin/report?page=${pVO.page-1}'"><
                    </button>
                </c:if>
                <c:forEach var="pvo" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
                    <c:if test="${pvo <= pVO.totalPage}">
                        <button class="btn btn-secondary"
                                onclick="location.href='${pageContext.servletContext.contextPath}/admin/report?page=${pvo}'">${pvo}</button>
                    </c:if>
                </c:forEach>
                <c:if test="${pVO.totalPage==pVO.page}">
                    <button class="btn btn-secondary">></button>
                </c:if>
                <c:if test="${pVO.totalPage>pVO.page}">
                    <button class="btn btn-secondary"
                            onclick="location.href='${pageContext.servletContext.contextPath}/admin/report?page=${pVO.page+1}'">>
                    </button>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
