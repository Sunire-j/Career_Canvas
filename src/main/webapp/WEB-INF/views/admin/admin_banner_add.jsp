<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
           prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">

    <script>
        $(function () {
            $(".forevent").on("click", "#deletion", function () {
                var del_target = $(this).attr("title");
                location.href =
                    "${pageContext.servletContext.contextPath}/board/delete?postid=" +
                    del_target;
            });

            $(".forevent").on("click", "#userDeletion", function () {
                var post_id = $(this).attr("title");
                location.href =
                    "${pageContext.servletContext.contextPath}/board/delete/user?postid=" +
                    post_id;
            });
        });
    </script>
    <style>
        *{
            font-family: 'Noto Sans KR', sans-serif;
        }
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

        #sideBar a,
        #sideBar a:visited,
        #sideBar a:link {
            color: black;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div style="display: flex">
    <div id="sideBar">
        <div style="text-align: center">
            <h4>관리자 ${name}</h4>
            <a
                    href="${pageContext.servletContext.contextPath}/"
                    style="
              color: red;
              text-align: center;
              display: block;
              margin: 0 auto;
            "
            >로그아웃</a
            >
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
    <div style="margin-left: 250px; width: 100%; height: 100%; padding: 20px">
        <h1 style="padding: 15px">배너 추가</h1>

        <form method="post" action="${pageContext.servletContext.contextPath}/admin/banner/addOk" enctype="multipart/form-data">
            <label>
                시작날짜 :
                <input type="date" name="startdate" id="startdate">
            </label>
            <label>
                종료날짜 :
                <input type="date" name="deadline" id="deadline">
            </label>
            <br/>
            <label>
                광고주 : <input type="text" class="form-control" name="owner" id="owner" placeholder="광고주">
            </label>
            <input type="file" name="bannerimg" id="bannerimg" accept="image/jpeg,image/png,image/jpg">
            <br/>
            <input type="submit" style="margin-top: 25px" value="배너 추가" disabled/>
        </form>

        <script>
            $(function () {
                var submitBtn = $('input[type="submit"]');
                var startdate = $('#startdate');
                var deadline = $('#deadline');
                var owner = $('#owner');
                var bannerimg = $('#bannerimg');

                function checkForm() {
                    var today = new Date().toISOString().split('T')[0];
                    var isStartDateValid = startdate.val() >= today;
                    var isDeadlineValid = deadline.val() > startdate.val();
                    var isOwnerValid = owner.val().trim() !== "";
                    var isFileValid = bannerimg[0].files.length > 0 &&
                        ["image/jpeg", "image/png", "image/jpg"].includes(bannerimg[0].files[0].type);

                    if (isStartDateValid && isDeadlineValid && isOwnerValid && isFileValid) {
                        submitBtn.prop('disabled', false);
                    } else {
                        submitBtn.prop('disabled', true);
                    }
                }

                startdate.on('change', checkForm);
                deadline.on('change', checkForm);
                owner.on('input blur', checkForm);
                bannerimg.on('change', checkForm);
            });
        </script>

    </div>
</div>
</body>
</html>
