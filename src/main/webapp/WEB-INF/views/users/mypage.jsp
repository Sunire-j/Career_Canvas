<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../header_footer/header.jspf"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        /* All */

        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            list-style: none;
            text-decoration: none;
        }

        ul,
        li {
            padding: 0;
            margin: 0;
        }
        .container {
            width: 1200px;
            margin: 0 auto;
        }

        a:link,
        a:visited {
            color: black;
            text-decoration: none;
        }
        .buttonGroup {
            text-align: center;
        }

        /* Header*/

        /* Title & Logo */

        .headTitle {
            display: flex;
            align-items: center;
        }
        .hamberger {
            display: none;
            font-size: 1.7rem;
        }
        .logo {
            height: 60px;
            line-height: 60px;
            font-size: 1.7rem;
            margin: 0;
        }
        .login {
            position: absolute;
        }

        /* NavBar */

        .nav_wrapper {
            display: flex;
            justify-content: space-between;
        }
        .navBar,
        .infoGroup {
            display: flex;
            justify-content: center;
            padding: 0;
            margin: 0;
            line-height: 50px;
        }
        .nav_wrapper li {
            padding-right: 20px;
        }

        .userInfo {
            display: none;
            position: absolute;
            background: rgba(255, 255, 255, 0.849);
            z-index: 1;
        }
        .userInfo li {
            height: 30px;
            line-height: 30px;
        }
        .userInfo.active {
            display: block;
            margin: 0;
            padding: 0;
        }
        .infoGroup img {
            width: 35px;
            height: 35px;
        }
        .carousel {
            z-index: 0;
        }

        .firstHr {
            left: 0;
            width: 100%;
        }

        /* Mypage User Info */
        .userInfo_wrapper {
            width: 75%;
            margin: 0 auto;
            margin-top: 25px;
            display: flex;
            flex-direction: row;
            justify-content: space-around;
        }
        .userIntro {
            display: flex;
            align-items: center;
            padding-bottom: 50px;
        }
        .userId {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding-bottom: 5px;
            margin-bottom: 20px;
        }
        .userIntro img {
            padding-right: 30px;
        }
        .btn-outline-primary {
            font-size: 14px;
            padding: 2px 4px;
        }
        .userIntro p {
            margin: 0px;
        }
        .web {
            background: rgb(250, 110, 133);
            border-radius: 10px;
            padding: 5px;
            color: white;
            font-size: 14px;
        }
        .picture {
            background: rgb(86, 70, 235);
            border-radius: 10px;
            padding: 5px;
            color: rgb(255, 255, 255);
            font-size: 14px;
        }
        .etc {
            background: rgb(0, 183, 255);
            border-radius: 10px;
            padding: 5px;
            color: white;
            font-size: 14px;
        }

        /* Edit Area */

        .editFrm {
            width: 50%;
            margin: 0 auto;
            text-align: center;
        }
        .editFrm p {
            font-size: 1.5rem;
            margin: 30px 0;
            color: #767676;
        }
        .changeBtn {
            margin-left: 10px;
        }
        .e-mail,
        .tel,
        .password,
        .interest,
        .pofol {
            display: flex;
            justify-content: space-between;
            padding-bottom: 10px;
        }
    </style>
</head>
<body>
<!-- Header -->
<header class="container">
    <!-- Title -->
    <div class="headTitle">
        <a class="logo" href="main.html">CAREER CANVAS</a>
        <i class="fa-solid fa-bars hamberger"></i>
    </div>
    <!-- Nav -->
    <nav class="nav_wrapper">
        <ul class="navBar">
            <li><a href="#">파티</a></li>
            <li><a href="popol.html">포트폴리오</a></li>
            <li><a href="#">기업과제</a></li>
            <li><a href="#">커뮤니티</a></li>
        </ul>
        <ul class="infoGroup">
            <!-- 로그인세션 확인 후 로그인 숨기고 닉네임,사용자아이콘 표시 -->
            <!-- 아이콘 클릭 시 드롭다운 메뉴로 프로필,마이페이지,로그아웃 나오게 -->
            <li><a href="#">로그인</a></li>
            <li>
                <a href="mypage.html"><img src="/img/bbb.png" alt="" /></a>
            </li>
            <li class="userNickname">
                Musso ▼
                <div style="background-color: white">
                    <ul class="userInfo">
                        <li>프로필</li>
                        <li>마이페이지</li>
                        <li>로그아웃</li>
                    </ul>
                </div>
            </li>
        </ul>
    </nav>
</header>
<hr class="firstHr" />

<!-- Main -->
<!-- Mypage User Info -->
<main class="container">
    <!-- Top  -->
    <div class="userInfo_wrapper">
        <!-- UserInfo Area -->
        <div class="userIntro">
            <img src="/img/bbb.png" alt="" />
            <div>
                <div class="userId">
                    <a href="mypage.html"
                    ><span style="font-size: 1.5rem">Musso</span></a
                    >
                    <a href="mypageEdit.html"
                    ><input
                            type="button"
                            class="btn btn-outline-primary"
                            value="수정"
                    />
                    </a>
                </div>
                <p>안녕하세요<br />적당히바람이시원해기분이너무좋아요<br />유후</p>
            </div>
        </div>
        <!-- Interest -->
        <div class="userInterest">
            <div>
                <p>관심분야</p>
                <span class="web">웹/개발</span>
                <span class="picture">사진/음향</span>
                <span class="etc">기타등등</span>
            </div>
        </div>
    </div>
    <hr style="margin: 0 auto; margin-top: 95px; width: 800px" />
    <!-- Edit Area -->

    <!--  -->

    <section class="editFrm">
        <p>회원정보 설정</p>
        <div class="e-mail">
            <span>이메일</span>
            <div>
                <span>Musso@multicampus.com</span>
                <button class="changeBtn btn btn-outline-primary">변경</button>
            </div>
        </div>
        <div class="password">
            <span>비밀번호</span>
            <div>
                <span>********</span>
                <button class="changeBtn btn btn-outline-primary">변경</button>
            </div>
        </div>
        <div class="tel">
            <span>휴대폰 번호</span>
            <div>
                <span>010-1234-5678</span>
                <button class="changeBtn btn btn-outline-primary">변경</button>
            </div>
        </div>

        <div class="interest">
            <span>관심분야</span>
            <div>
                <span>웹/개발, 사진/음향</span>
                <button class="changeBtn btn btn-outline-primary">변경</button>
            </div>
        </div>
        <div class="pofol">
            <span>포트폴리오 공개</span>
            <div>
                <span>On</span>
                <button class="changeBtn btn btn-outline-primary">변경</button>
            </div>
        </div>
    </section>
</main>
</div>

</body>
</html>

