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

    <script>
        $(function () {
            var stackedLine = null;
            var piechart = null;

            // 최근 30일 일 별 게시글 라인 차트
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
            var Bdatas = [];
            labels.forEach(function (date) {
                var found = false;
                <c:forEach items="${month}" var="item">
                if (date == "${item.date}") {
                    Bdatas.push(${item.postid});
                    found = true;
                }
                </c:forEach>
                if (!found) {
                    Bdatas.push(0);
                }
            });

            lineChart(Bdatas);

            function lineChart(Bdatas) {
                var data = {
                    labels: labels,
                    datasets: [{
                        label: "최근 30일 일 별 게시글",
                        data: Bdatas,
                        fill: false,
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1
                    }]
                };
                if (stackedLine != null) {
                    stackedLine.destroy();
                }
                stackedLine = new Chart(document.getElementById("board_chart"), {
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
                $("#board_chart").css("width",'1000px');
                $("#board_chart").css("height",'500px');
            }

            // 카테고리 별 등록된 게시글 파이 차트
            var Pdatas = [];
            var Plabels = ['자유게시판', '질문게시판', '노하우게시판'];
            <c:forEach items="${category}" var="item">
            Pdatas.push(${item.postid});
            </c:forEach>

            pieChart(Pdatas);

            function pieChart(Pdatas) {
                var data = {
                    labels: Plabels,
                    datasets: [{
                        label: "게시판 카테고리별 현황",
                        data: Pdatas,
                        backgroundColor: [
                            'rgb(255, 99, 132)',
                            'rgb(54, 162, 235)',
                            'rgb(255, 205, 86)'
                        ]
                    }]
                };
                if (piechart != null) {
                    piechart.destroy();
                }
                piechart = new Chart(document.getElementById("board_pie"), {
                    type: 'pie',
                    data: data,
                    options: {
                        responsive: false
                    }
                });
            }

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

        .top {
            width: 100%;
            display: flex;
            justify-content: center;
            height: 100px;
            align-items: center;
            margin-bottom: 30px;
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
    </style>
</head>
<body>
<div style="display:flex;">
    <div id="sideBar">
        <div style="text-align: center;">
            <h4>관리자 ${name}</h4>
            <a href="${pageContext.servletContext.contextPath}/logout"
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
    <div style="margin-left: 250px; width: 100%; height: 100%">
        <div class="top">
            <div class="container p-5 my-5 bg-secondary text-white">전체 게시글 : ${bVO}</div>
            <div class="container p-5 my-5 bg-secondary text-white">오늘 업로드 된 게시글 : ${today}</div>
            <div class="container p-5 my-5 bg-secondary text-white">신고 된 게시글 : ${rVO}</div>
        </div>
        <div>
            <div style="display: flex; width: 100%; align-items: center; padding-top: 50px; justify-content: space-evenly;">
                <div>
                    <h2 style="text-align: center">한달간 일별 게시글 근황</h2>
                    <canvas id="board_chart" style="display: block; box-sizing: border-box; height: 500px; width: 1000px;"></canvas>
                </div>
                <div>
                    <h2 style="text-align: center">카테고리별 게시글 근황</h2>
                    <canvas id="board_pie" style="display: block;box-sizing: border-box;width: 500px;"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>