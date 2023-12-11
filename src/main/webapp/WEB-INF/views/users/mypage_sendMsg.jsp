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
      .container {
        margin: 0 auto;
        border-left: 1px solid #73351F;
        border-right: 1px solid #73351F;
      }
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
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        background: #f2f2f2;
        padding: 20px;
        border-radius: 30px;
        border: 1px solid #73351F;
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
        border-bottom: 2.5px solid #73351F;
        padding-bottom: 5px;
        margin-bottom: 20px;
      }
      .userIntro img {
        width: 150px;
        height: 150px;
        border-radius: 30%;
      }
      .btn-outline-primary {
        font-size: 14px;
        padding: 2px 4px;
      }
      .btn-secondary {
        font-size: 14px;
        padding: 2px 4px;
      }
      .btn-outline-secondary {
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
        align-items: center;
        justify-content: space-around;
        width: 1300px;
        background-color: white;
        height: 50px;
        line-height: 50px;
        border-radius: 10px;
        text-align: center;
        border: 1px solid #73351F;
      }
      .ajaxMenu a{
        width: 20%;
        color: #0D0D0D;
        transition: color 0.3s, background-color 0.3s;
      }
      .ajaxMenu a:hover {
        color: #73351F;
        font-weight : bold;
      }
      .ajaxView {
        float: left;
      }
      .ajaxContent {
        width: 50%;
        justify-content: center;
        margin-top: 20px;
        display: flex;
      }
      .ajaxView_wrapper {
        width: 64%;
        margin: 0 auto;
        display: flex;
        flex-wrap: wrap;
      }
      .userInterest span {
        margin-right: 5px;
      }
      .table th,
      .table tr {
        width: 15%;
        text-align: center;
      }
      .table th:nth-child(5n + 3),
      .table tr:nth-child(5n + 3) {
        width: 40%;
      }
      .paging {
        display: flex;
        justify-content: center;

      }
      .paging li {
        margin: 0 20px;
      }
      .msgStyle {
        color: red;
      }
      .container_bottom{
        display: flex;
        background: #A69668;
        height: 10px;
        margin-top: 10px;
      }
      .hr-styleset{
        border: 0;
        border-top: 2.5px dashed #73351F ;
        border-bottom: 1px dashed #D9D9D9;
      }
      .container-head{
        display: flex;
        justify-content: center;
        align-items: center;
        background: #A69668;
        height: 10px;
      }
      hr{
        border-top: 2.5px solid #73351F ;
      }
    </style>
  </head>
  <body>
    <!-- Main -->

    <!-- Mypage User Info -->
    <main  class="container" style="margin-top: 100px; border-top: 3px solid #73351F; padding: 0px; background: linear-gradient( to bottom, #D9C8A9 70%, #F2F2F2 );">
      <div class="container-head"></div>
      <div style="padding: 20px">
      <!-- Top  -->
      <div class="userInfo_wrapper">
        <!-- UserInfo Area -->
        <div class="userIntro">
          <img src="${pageContext.servletContext.contextPath}/upload${uVO.profileimg}" alt="" />
          <div style="padding-left: 20px;">
            <div class="userId">
              <a href="${pageContext.servletContext.contextPath}/mypage/myPofol">
                <span style="font-size: 1.5rem">${uVO.username }</span>
              </a>
              <a href="${pageContext.servletContext.contextPath}/mypage_edit">
                <input
                  type="button"
                  class="btn btn-outline-secondary"
                  value="수정"
                />
              </a>
            </div>
            <p>${uVO.comment }</p>
          </div>
        </div>
        <!-- Interest -->
        <div style="padding: 20px 10px 0px 30px; border-left: 2px solid #73351F">
          <p style="display: flex; justify-content: center; font-size: 1.5rem" >관심분야</p>
          <div class="userInterest" style="display: flex; flex-wrap: wrap">
            <c:forEach var="interest" items="${interest}">
              <span><input class="btn btn-outline-primary" type="button" value="${interest}"></span>
            </c:forEach>
          </div>
        </div>
      </div>
      </div>
      </div>
    </main>
      <div class="ajaxMenu_wrapper">
        <ul class="ajaxMenu">
          <li class="myPofol menu" id="myPofol">
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
          <li class="myPost menu" id="myPost">
            <a href="${pageContext.servletContext.contextPath}/mypage/myPost"
              >나의 게시글</a
            >
          </li>
          <li class="myComment menu" id="myCommen">
            <a href="${pageContext.servletContext.contextPath}/mypage/myComment"
              >나의 댓글</a
            >
          </li>
          <li class="mySendMsg" id="mySendMsg">
            <a href="#">쪽지함</a>
          </li>
        </ul>
      </div>
     <div class="container"  style="padding: 0px; border-bottom: 3px solid #73351F; background: #F2F2F2">
      <div style="padding: 10px 40px 40px 40px">
      <div style="width: 900px; margin: 0 auto">
        <div class="mt-3" style="text-align: center">
          <button class="btn btn-secondary sendMsg" onclick="location.href='${pageContext.servletContext.contextPath}/mypage/mySendMsg'">보낸 쪽지함</button>
          <button
            class="btn btn-outline-secondary receiveMsg"
            onclick="location.href='${pageContext.servletContext.contextPath}/mypage/myReceiveMsg'"
          >
            받은 쪽지함
          </button>
        </div>
        <table class="table">
          <thead class="table-dark">
            <tr>
              <th>받는사람</th>
              <th>내용</th>
              <th>날짜</th>
            </tr>
          </thead>
          <tbody>
            <div class="ajaxContent">
              <c:forEach var="mVO" items="${mVO}">
                <tr id="msgStyle">
                  <td>${mVO.user_userid1}</td>
                  <td><a style="display: inline-block; max-width: 400px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis" href="#" data-bs-toggle="tooltip" data-bs-placement="right" title="${mVO.content}">${mVO.content}</a></td>
                  <td>${mVO.date}</td>
                </tr>
              </c:forEach>
            </div>
          </tbody>
        </table>

        <!-- 페이징 -->
        <div class="pagination-container" style="margin: 0 auto; margin-top: 20px; width: fit-content">
          <div class="pagination" style="display: flex">
              <div class="paging">
                  <c:if test="${pVO.page > 1}">
                      <button class="btn btn-outline-secondary" onclick="location.href='?page=${pVO.page - 1}'
                      <c:if test="${pVO.category !=''}">
                              +'&category=${pVO.category}'
                      </c:if>
                      <c:if test="${pVO.searchWord!=''}">
                              +'&searchKey=${pVO.searchKey}'
                              +'&searchWord=${pVO.searchWord}'
                      </c:if>
                      <c:if test="${pVO.postSort!=''}">
                              +'&postSort=${pVO.postSort}'
                      </c:if>
                              "><
                      </button>
                  </c:if>
                  <c:forEach var="i" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
                      <c:if test="${i <= pVO.totalPage}">
                          <c:choose>
                              <c:when test="${i != pVO.page}">
                                  <button class="btn btn-outline-secondary" onclick="location.href='?page=${i}'
                                  <c:if test="${pVO.category !=''}">
                                          +'&category=${pVO.category}'
                                  </c:if>
                                  <c:if test="${pVO.searchWord!=''}">
                                          +'&searchKey=${pVO.searchKey}'
                                          +'&searchWord=${pVO.searchWord}'
                                  </c:if>
                                  <c:if test="${pVO.postSort!=''}">
                                          +'&postSort=${pVO.postSort}'
                                  </c:if>
                                          ">${i}</button>
                              </c:when>
                              <c:otherwise>
                                  <strong class="btn btn-outline-secondary" style="font-weight: bold">${i}</strong>
                              </c:otherwise>
                          </c:choose>
                      </c:if>
                  </c:forEach>
                  <c:if test="${pVO.page < pVO.totalPage}">
                      <button class="btn btn-outline-secondary" onclick="location.href='?page=${pVO.page + 1}'
                      <c:if test="${pVO.category !=''}">
                              +'&category=${pVO.category}'
                      </c:if>
                      <c:if test="${pVO.searchWord!=''}">
                              +'&searchKey=${pVO.searchKey}'
                              +'&searchWord=${pVO.searchWord}'
                      </c:if>
                      <c:if test="${pVO.postSort!=''}">
                              +'&postSort=${pVO.postSort}'
                      </c:if>
                              ">>
                      </button>
                  </c:if>
              </div>
          </div>
      </div>
      </div>
      <div style="width: 60%; text-align: right; margin:0 auto;">
      <input type="button" value="쪽지보내기" class="btn btn-outline-secondary" onclick="openPopup()">
          <script>
            $(function(){
              var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
              var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl)
              })
            });
            function openPopup(){

              var left = (window.innerWidth - 700) / 2;
              var top = (window.innerHeight - 600) / 2;
              var popSize = `toolbar=no,scrollbars=no,resizable=yes,status=no,menubar=no,location=no,width=700, height=600, top=${top},left=${left}`;
              window.open('${pageContext.servletContext.contextPath}/mypage/pop_sendMsg','SendMsg',popSize);
            }
          </script>
      </div>
      <!-- 검색창 -->
      <form
      class="input-group mb-3"
      style="width: 60%; margin: 20px auto"
      action="${pageContext.servletContext.contextPath}/mypage/mySendMsg"
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
      </div>
       <div class="container_bottom"></div>
     </div>
    </div>
  </body>
</html>
<%@include file="../header_footer/footer.jspf" %>
