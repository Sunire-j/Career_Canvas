<%@ page contentType="text/html;charset=UTF-8" language="java"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@include
file="../header_footer/header.jspf"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
      .dropdown {
        display: block;
        margin: 0;
        padding: 0;
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

      /* Center ajax */
      .homeworkImg {
        width: 220px;
        height: 170px;
        padding-right: 50px;
      }
      .ajaxMenu {
        display: flex;
        margin: 0 auto;
        width: 65%;
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

      .ajaxMenu_wrapper {
        margin-top: 50px;
      }
      .ajaxView_wrapper {
        margin: 0 auto;
      }
      .ajaxView {
        float: left;
      }
      .ajaxContent {
        width: 50%;
        justify-content: center;
        margin-top: 80px;
        display: flex;
      }
      .ajaxView_wrapper {
        width: 75%;
        display: flex;
        flex-wrap: wrap;
      }
      .userInterest span {
        margin-right: 5px;
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
          <img src="#" alt="" />
          <div>
            <div class="userId">
              <a href="${pageContext.servletContext.contextPath}/mypage">
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
            <span class="web">웹/개발</span>
            <span class="picture">사진/음향</span>
            <span class="etc">기타등등</span>
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
      <div class="ajaxView_wrapper">
        <c:forEach var="pVO" items="${list}">
          <div class="ajaxContent">
            <a
              href="#"
              style="border: solid 1px #ddd; width: 220px; height: 170px"
              ><img src="/img/bbb.png" alt=""
            /></a>
            <div>
              <a href="#"><p>${pVO.portfoliotitle}</p></a>
            </div>
          </div>
        </c:forEach>
      </div>
      <!-- 페이징 -->
      <div class="paging" style="width: 50%; margin: 0 auto; text-align: center;">
        <c:forEach var ="i" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
          <c:if test="${i <= pVO.totalPage}">
            <c:choose>
            <c:when test="${i != pVO.page}">
              <button class="btn btn-outline-primary" onclick="location.href='?page=${i}'
              <c:if test="${pVO.searchText != ''}">
                +'&searchText=${pVO.searchText}'
</c:if>
              ">${i}</button>
            </c:when>
            <c:otherwise>
              <strong class="btn btn-outline-primary" style="font-weight:  bold;">${i}</strong>
            </c:otherwise>
          </c:choose>
          </c:if>
        </c:forEach>
        <c:if test="${pVO.page < pVO.totalPage}">
                        <button class="btn btn-outline-secondary" onclick="location.href='?page=${pVO.page + 1}'

                        <c:if test="${pVO.searchWord!=''}">
                                +'&searchWord=${pVO.searchWord}'
                        </c:if>
                                ">>
                        </button>
                    </c:if>
                    <!-- 글쓰기 -->
                    <input type="button" value="글쓰기"onclick="location.href='${pageContext.servletContext.contextPath}/mypage/myPofol/write'">
      </div>
      
      

      <!-- search -->
      <form
        class="input-group mb-3"
        style="width: 60%; margin: 20px auto"
        action="${pageContext.servletContext.contextPath}/mypage/myPofol"
        method="GET"
      >
        <input
          type="text"
          class="form-control"
          name="searchText"
          placeholder="Search"
        />
        <button class="btn btn-success" type="submit">Go</button>
      </form>
    </main>
  </body>
</html>
<%@include file="../header_footer/footer.jspf" %>
