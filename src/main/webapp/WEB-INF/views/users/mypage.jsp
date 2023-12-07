<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@include
        file="../header_footer/header.jspf" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Career Canvas</title>
    <script
            src="https://kit.fontawesome.com/2026ef433b.js"
            crossorigin="anonymous"
    ></script>
    <link
            href="	https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
            integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
    ></script>

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

        /* Mypage User Info */
        .userInfo_wrapper {
            width: 100%;
            margin: 0 auto;
            margin-top: 25px;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
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
            width: 100px;
            height: 100px;
        }

        .btn-outline-primary {
            font-size: 14px;
            padding: 2px 4px;
        }

        .userIntro p {
            margin: 0px;
        }

        .dropdown {
            display: block;
            margin: 0;
            padding: 0;
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

        /* Center ajax */
        .homeworkImg {
            width: 220px;
            height: 170px;
            padding-right: 50px;
        }

        .ajaxMenu {
            display: flex;
            margin: 0 auto;
            width: 100%;
            justify-content: space-around;
            background-color: white;
            height: 50px;
            line-height: 50px;
            border-radius: 10px;
            text-align: center;
        }

        .ajaxMenu a {
            width: 20%;
            color: black;
        }

        .ajaxView {
            float: left;
        }
        .ajaxContent img {
            width: 170px;
            height: 170px;
        }

        .ajaxView_wrapper {
            width: 70%;
            display: grid;
            grid-template-columns: repeat(4,1fr);
            column-gap: 20px;
            row-gap: 10px;
            margin: 0 auto;
            margin-top: 50px;
        }

        .userInterest span {
            margin-right: 5px;
        }
        .img_C{
            width:235px;
            margin-left: 30px;
        }
        .content_category, .content_title{
            display: inline;
            height: 40px;
            line-height: 40px;
        }
        .content_category{
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

        .profile_img>img {
            width: 160px;
            height: 160px;
            border-radius: 40px;

        }
    </style>
</head>
<body>
<!-- Main -->

<!-- Mypage User Info -->
<main class="container">
    <!-- Top  -->
    <div class="userInfo_wrapper">
        <!-- UserInfo Area -->
        <div class="userIntro">
            <img src="${pageContext.servletContext.contextPath}/upload${uVO.profileimg}" alt=""/>
            <div style="padding-left: 20px;">
                <div class="userId">
                    <a href="${pageContext.servletContext.contextPath}/mypage/myPofol">
                        <span style="font-size: 1.5rem">${uVO.username }</span>
                    </a>
                    <a href="${pageContext.servletContext.contextPath}/mypage_edit">
                        <input
                                type="button"
                                class="btn btn-outline-primary"
                                value="수정"
                        />
                    </a>
                </div>
                <p>${uVO.comment }</p>
            </div>
        </div>
        <!-- Interest -->

        <div>
            <p>관심분야</p>
            <div class="userInterest" style="display: flex; flex-wrap: wrap">
                <c:if test="${not empty interest}">
                    <c:forEach var="interest" items="${interest}">
                        <span><input class="btn btn-outline-primary" type="button" value="${interest}"></span>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Center -->
    <!-- ajax -->
    <div class="ajaxMenu_wrapper">
        <ul class="ajaxMenu">
            <li class="myPofol menu" id="myPofol menu">
                <a href="${pageContext.servletContext.contextPath}/mypage/myPofol"
                >나의 포트폴리오</a
                >
            </li>
            <li class="submitTask menu" id="submitTask">
                <a
                        href="${pageContext.servletContext.contextPath}/mypage/submitSubjectSolo"
                >제출한 과제</a
                >
            </li>
            <li class="myPost menu" id="myPost menu">
                <a href="${pageContext.servletContext.contextPath}/mypage/myPost"
                >나의 게시글</a
                >
            </li>
            <li class="myComment menu" id="myComment menu">
                <a href="${pageContext.servletContext.contextPath}/mypage/myComment"
                >나의 댓글</a
                >
            </li>
            <li class="myNote menu" id="myNote menu">
                <a href="${pageContext.servletContext.contextPath}/mypage/mySendMsg"
                >쪽지함</a
                >
            </li>
        </ul>
    </div>

    <!-- ajax View -->
    <div style="margin: 0 auto; margin-top: 30px; ">
        <ul style="width: 1100px; display: flex; flex-wrap: wrap; margin: 0 auto" class="content">
        <c:forEach var="list" items="${list}">
            <a href="${pageContext.servletContext.contextPath}/pofolview?pofolid=${list.portfolioid}">
            <div class="img_C">
                <img src="${pageContext.servletContext.contextPath}/upload${list.imgsrc}" class="portfolio_img">
                <!-- line 1 -->
                <div class="content_info">
                    <div class="content_category">
                        <c:if test="${list.category==0}">
                            분류없음
                        </c:if>
                        <c:if test="${list.category==1}">
                            IT/개발
                        </c:if>
                        <c:if test="${list.category==2}">
                            디자인
                        </c:if>
                        <c:if test="${list.category==3}">
                            영상
                        </c:if>
                    </div>
                    <div class="content_title">
                            ${list.portfoliotitle}
                    </div>
                </div>
            </div>
            </a>
        </c:forEach>
        </ul>
    </div>
    <!-- 페이징 -->
    <c:if test="${pVO.totalRecord == 0}">
        <p style="text-align: center;">작성된 포트폴리오가 없습니다</p>
    </c:if>
    <div class="paging" style="text-align: center; margin: 0 auto; text-align: center; width: 70%;">
        <c:if test="${pVO.totalRecord > 0}">

            <c:if test="${pVO.page == 1}">
                <input type="button" value="<" class="btn btn-outline-primary" disabled>
            </c:if>
            <c:if test="${pVO.page > 1}">

                <a
                        href="${pageContext.servletContext.contextPath}/mypage/myPofol?page=${pVO.page - 1}"
                ><input type="button" value="<" class="btn btn-outline-primary"></a
                >

            </c:if>

            <c:forEach
                    var="p"
                    begin="${pVO.startPage}"
                    end="${pVO.page + pVO.onePageCount -1}"
            >
                <c:if test="${p<=pVO.totalPage}">

                    <a
                            href="${pageContext.servletContext.contextPath}/mypage/myPofol?page=${p}<c:if test='${pVO.searchWord != null}'>&searchWord=${pVO.searchWord}</c:if>"
                    >
                        <button
                                type="submit"
                                class="btn btn-outline-primary"
                                style="margin: 10px"
                        >
                                ${p}
                        </button>
                    </a
                    >

                </c:if>
            </c:forEach>

            <c:if test="${pVO.page == pVO.totalPage}">
                <input type="button" value=">" class="btn btn-outline-primary" disabled>
            </c:if>
            <c:if test="${pVO.page < pVO.totalPage}">

                <a
                        href="${pageContext.servletContext.contextPath}/mypage/myPofol?page=${pVO.page + 1}"
                > <input type="button" value=">" class="btn btn-outline-primary"></a
                >

            </c:if>
            </ul>
        </c:if>
        <!-- 글쓰기 -->
        <input
                type="button"
                class="btn btn-outline-primary"
                value="글쓰기"
                onclick="location.href='${pageContext.servletContext.contextPath}/mypage/myPofol/write'"
        />
    </div>


    <!-- 페이징2 -->
    <div>
        <ul class="pagination">
            <c:if test="${pVO.page==1}">
                <li class="page-item"><a class="page-link">Previous</a></li>
            </c:if>
            <c:if test="${pVO.page>1}">
                <li class="page-item"><a class="page-link"
                                         href="${pageContext.servletContext.contextPath}/mypage/myPofol?page=${pVO.page-1}">Previous</a>
                </li>
            </c:if>
            <c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount -1}">
                <c:if test="${p <= pVO.totalPage}">
                    <li class="page-item"><a class="page-link"
                                             href="${pageContext.servletContext.contextPath}/mypage/myPofol?page=${p}">${p}</a>
                    </li>
                </c:if>
            </c:forEach>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
        </ul>
    </div>


    <!-- search -->
    <form
            class="input-group mb-3"
            style="width: 70%; margin: 20px auto"
            action="${pageContext.servletContext.contextPath}/mypage/myPofol"
            method="GET"
    >
        <input
                type="text"
                class="form-control"
                name="searchWord"
                placeholder="Search"
        />
        <button class="btn btn-success" type="submit">Go</button>
    </form>
</main>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>