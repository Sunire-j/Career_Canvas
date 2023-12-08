<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="./header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
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

        .title {
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

        /* Main */

        /* Banner */

        .carousel {
            width: 100%;
            margin: 0 auto;
        }

        .carousel-item {
            position: relative;
            width: 100%;
            height: 500px;
            overflow: hidden;
        }

        .carousel-item img {
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
        }

        .custom {
            height: 500px;
            position: relative;
        }

        .custom img {
            object-fit: cover;
            height: 500px;
            width: 100%
        }

        /* BestPopol */

        .bestPopol_wrapper {
            width: 1000px;
        }

        .bestPopol_wrapper > p {
            text-align: center;
            margin-top: 100px;
            font-weight: bold;
            font-size: 1.2rem;
        }

        .bestPopolList {
            width: 1200px;
            margin-top: 50px;
            display: flex;
            justify-content: space-around;
        }

        .bestPopol {
            display: flex;
            flex-direction: column;
            text-align: left;
        }

        .bestPopol img {
            width: 220px;
            height: 170px;
            margin-bottom: 10px;
        }

        .bestPopol p {
            margin: 0;
        }

        .owner img {
            width: 25px;
            height: 25px;
        }

        /* Homework */
        .homework_wrapper {
            width: 1000px;
            margin-top: 50px;
            margin-bottom: 200px;
            border-top: solid 1px #ddd;
        }

        .homeworkList {
            width: 1000px;
            margin-top: 50px;
            display: flex;
            justify-content: space-around;
        }

        .homework {
            display: flex;
            flex-direction: column;
            text-align: left;
        }

        .homework > img {
            width: 220px;
            height: 170px;
        }

        .homework_wrapper > p {
            text-align: center;
            margin-top: 50px;
            padding-top: 50px;
        }

        .homework > p {
            margin-bottom: 0px;
        }

        .img_C {
            width: 235px;
            margin-left: 30px;
        }

        .content_category, .content_title {
            display: inline;
            height: 40px;
            line-height: 40px;
        }

        .content_category {
            height: 30px;
            margin-top: 10px;
            margin-right: 10px;
            background-color: #ddd;
            border-radius: 5px;
            text-align: center;
            padding: 5px 5px 5px 10px;
        }

        .content img {
            width: 235px;
            height: 235px;
            border-radius: 30px;

        }

        .content_info {
            width: 235px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div id="carouselExampleIndicators" class="carousel slide">
    <div class="carousel-indicators">
        <c:forEach items="${banner}" var="Banner" varStatus="status">
            <button
                    type="button"
                    data-bs-target="#carouselExampleIndicators"
                    data-bs-slide-to="${status.index}"
                    class="active"
                    aria-current="true"
                    aria-label="Slide ${status.index+1}"
            ></button>
        </c:forEach>
    </div>
    <div class="carousel-inner">
        <c:forEach items="${banner}" var="Banner" varStatus="status">
            <c:if test="${status.index==0}">
                <div class="carousel-item active custom">
                    <img src="${pageContext.servletContext.contextPath}/upload${Banner.bannerimg}"
                         class="d-block w-100"/>
                </div>
            </c:if>
            <c:if test="${status.index!=0}">
                <div class="carousel-item custom">
                    <img src="${pageContext.servletContext.contextPath}/upload${Banner.bannerimg}"
                         class="d-block w-100"/>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <button
            class="carousel-control-prev"
            type="button"
            data-bs-target="#carouselExampleIndicators"
            data-bs-slide="prev"
    >
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button
            class="carousel-control-next"
            type="button"
            data-bs-target="#carouselExampleIndicators"
            data-bs-slide="next"
    >
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>
<div class="container">
    <main class="container">
        <div style="margin-top: 50px"></div>
        <p style="text-align: center; font-weight: bold; font-size: 1.2rem">인기 포트폴리오</p>
        <div class="buttonGroup">
            <button class="btn btn-outline-primary" type="button">웹/개발</button>
            <button class="btn btn-outline-primary" type="button">
                사진/음향
            </button>
            <button class="btn btn-outline-primary" type="button">
                등등ㅋㅋ
            </button>
        </div>
        <ul class="content d-flex mt-3">
            <c:forEach items="${plist}" var="p">
                <li>
                    <a href="${pageContext.servletContext.contextPath}/pofolview?pofolid=${p.portfolioid}">
                        <div class="img_C">
                            <img src="${pageContext.servletContext.contextPath}/upload${p.imgsrc}"
                                 class="portfolio_img">
                            <!-- line 1 -->
                            <div class="content_info">
                                <div class="content_category">
                                    <c:if test="${p.category==0}">
                                        분류없음
                                    </c:if>
                                    <c:if test="${p.category==1}">
                                        IT/개발
                                    </c:if>
                                    <c:if test="${p.category==2}">
                                        디자인
                                    </c:if>
                                    <c:if test="${p.category==3}">
                                        영상/음향
                                    </c:if>
                                </div>
                                <div class="content_title">
                                        ${p.portfoliotitle}
                                </div>
                            </div>
                            <!-- line 2 -->
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div style="display: flex; align-items: center;">
                                    <img src="${pageContext.servletContext.contextPath}/upload${p.profileimg}"
                                         style="width:20px; height:20px;" alt="">
                                    <span style="margin-left:10px; width: 118px;white-space: nowrap;
                                    overflow: hidden; text-overflow: ellipsis;">${p.username}</span>
                                </div>
                                <div class="iconGroup">
                                    <i class="fa-solid fa-eye" style="color: #0d0d0d;"></i>
                                    <span>${p.view}</span>
                                    <i class="fa-solid fa-heart" style="color: #0d0d0d;"></i>
                                    <span>${p.likeCnt}</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>

        <div style="margin-top: 50px"></div>
        <p style="text-align: center; font-weight: bold; font-size: 1.2rem">최근 기업과제</p>
        <div class="buttonGroup">
            <button class="btn btn-outline-primary" type="button">웹/개발</button>
            <button class="btn btn-outline-primary" type="button">
                사진/음향
            </button>
            <button class="btn btn-outline-primary" type="button">
                등등ㅋㅋ
            </button>
        </div>

<%--        여기 내부변수 바꿔줘야함--%>
        <ul class="content d-flex mt-3">
            <c:forEach items="${plist}" var="p">
                <li>
                    <a href="${pageContext.servletContext.contextPath}/pofolview?pofolid=${p.portfolioid}">
                        <div class="img_C">
                            <img src="${pageContext.servletContext.contextPath}/upload${p.imgsrc}"
                                 class="portfolio_img">
                            <!-- line 1 -->
                            <div class="content_info">
                                <div class="content_category">
                                    <c:if test="${p.category==0}">
                                        분류없음
                                    </c:if>
                                    <c:if test="${p.category==1}">
                                        IT/개발
                                    </c:if>
                                    <c:if test="${p.category==2}">
                                        디자인
                                    </c:if>
                                    <c:if test="${p.category==3}">
                                        영상/음향
                                    </c:if>
                                </div>
                                <div class="content_title">
                                        ${p.portfoliotitle}
                                </div>
                            </div>
                            <!-- line 2 -->
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div style="display: flex; align-items: center;">
                                    <img src="${pageContext.servletContext.contextPath}/upload${p.profileimg}"
                                         style="width:20px; height:20px;" alt="">
                                    <span style="margin-left:10px; width: 118px;white-space: nowrap;
                                    overflow: hidden; text-overflow: ellipsis;">${p.username}</span>
                                </div>
                                <div class="iconGroup">
                                    <i class="fa-solid fa-eye" style="color: #0d0d0d;"></i>
                                    <span>${p.view}</span>
                                    <i class="fa-solid fa-heart" style="color: #0d0d0d;"></i>
                                    <span>${p.likeCnt}</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </main>
</div>

</body>
</html>
<%@include file="./header_footer/footer.jspf" %>

