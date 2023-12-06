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
    <script>
        $(function () {
            var stackedLine = null;

            // 최근 30일 일 별 신규 가입자 라인 차트
            var labels = [];
            for (var i = 0; i < 30; i++) {
                var date = new Date();
                date.setDate(date.getDate() - 29);
                date.setDate(date.getDate() + i);
                var yyyy = String(date.getFullYear());
                var mm = String(date.getMonth() + 1).padStart(2, '0');
                var dd = String(date.getDate()).padStart(2, '0');
                labels.push(yyyy + '-' + mm + '-' + dd);
            }
            var datas = [];
            labels.forEach(function (date) {
                var found = false;
                <c:forEach items="${newMember}" var="item">
                if (date == "${item.date}") {
                    datas.push(${item.userid});
                    found = true;
                }
                </c:forEach>
                if (!found) {
                    datas.push(0);
                }
            });

            function lineChart(datas) {
                var data = {
                    labels: labels,
                    datasets: [{
                        label: "최근 30일 일 별 신규 가입자",
                        data: datas,
                        fill: false,
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1
                    }]
                };
                stackedLine = new Chart(document.getElementById("newMember"), {
                    type: 'line',
                    data: data,
                    options: {
                        scales: {
                            y: {
                                stacked: true
                            }
                        }
                    }
                });
            }

            lineChart(datas);

            var Adatas = [];
            labels.forEach(function (date) {
                var found = false;
                <c:forEach items="${accessor}" var="item">
                if (date == "${item.date}") {
                    Adatas.push(${item.count});
                    found = true;
                }
                </c:forEach>
                if (!found) {
                    Adatas.push(0);
                }
            });

            function accessorChart(Adatas) {
                var data = {
                    labels: labels,
                    datasets: [{
                        label: "최근 30일 일 별 접속자",
                        data: Adatas,
                        fill: false,
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1
                    }]
                };
                stackedLine = new Chart(document.getElementById("accessor"), {
                    type: 'line',
                    data: data,
                    options: {
                        scales: {
                            y: {
                                stacked: true
                            }
                        }
                    }
                });
            }

            accessorChart(Adatas);

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

        .top {
            width: 100%;
            display: flex;
            justify-content: center;
            height: 100px;
            align-items: center;
        }

        .top div {
            flex: 1;
            text-align: center;
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
        <a href="${pageContext.servletContext.contextPath}/admin/user/stats"> 유저 현황 </a>
        <a href="${pageContext.servletContext.contextPath}/admin/board/stats"> 게시판 현황 </a>
        <a href="${pageContext.servletContext.contextPath}/" style="position: absolute; bottom: 90px;">메인 페이지 이동</a>
        <p style="position: absolute; bottom: 50px;">당일 접속 유저 : 500명</p>
        <p style="position: absolute; bottom: 20px;">누적 접속 유저 : 50만명ㅋ</p>
    </div>
    <!-- 관리자 페이지 만드실 때 margin-left 여기 참고하시면 됩니다 -->
    <div style="margin-left: 250px; width: 100%; height: 100%; padding: 20px;">
        <div class="top">
            <div>일반회원 : ${member}</div>
            <div>기업회원 : ${company}</div>
        </div>
        <div style="width: 50%; display: flex;">
            <canvas id="accessor"></canvas>
            <canvas id="newMember"></canvas>
        </div>
    </div>
</div>
</body>
</html>