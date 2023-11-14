<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../header_footer/header.jspf"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Career Canvas</title>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
      integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>
    <script
      src="https://kit.fontawesome.com/2026ef433b.js"
      crossorigin="anonymous"
    ></script>
    <link
      href="	https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link
      href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
      rel="stylesheet"
    />
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

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
      .dropdown {
        display: block;
        padding: 0px;
        margin: 0px;
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
      .nickName,
      .e-mail,
      .tel,
      .password,
      .interest,
      .pofol,
      .passwordCheck,
      .profileImg,
      .e-mailCheck {
        display: flex;
        justify-content: space-between;
        padding-bottom: 20px;
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
          <img src="/img/bbb.png" alt="" />
          <div>
            <div class="userId">
              <a href="mypage.html"
                ><span style="font-size: 1.5rem">${uVO.username }</span></a
              >
              <a href="mypageEdit.html"
                ><input
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
      <hr style="margin: 0 auto; margin-top: 95px; width: 800px" />

      <!-- Edit Area -->

      <form class="editFrm" action="mypageEditOk" method="post" onsubmit ="return frmCheck()">
        <p>회원정보 설정</p>
        <div class="nickName">
          <span>닉네임</span>
          <div>
            <input
              class="form-control"
              type="text"
              name="nickName"
              id="nickName"
              value="${uVO.username }"
            />
          </div>
        </div>
        <div class="e-mail">
          <span>이메일</span>
          <div>
            <input
              class="form-control"
              type="text"
              name="e-mail"
              id="e-mail"
              value="${uVO.useremail }"
            />
          </div>
        </div>
        <div class="e-mailCheck">
          <span>이메일 인증번호</span>
          <div>
            <input
              class="form-control"
              type="text"
              name="e-mailCheck"
              id="e-mail"
              value=""
            />
          </div>
        </div>
        <div class="password">
          <span>비밀번호</span>
          <div>
            <input
              class="form-control"
              type="password"
              name="password"
              value=""
              id="password"
            />
          </div>
        </div>
        <div class="passwordCheck">
          <span>비밀번호 확인</span>
          <div>
            <input
              class="form-control"
              type="password"
              name="passwordCheck"
              value=""
              id="passwordCheck"
            />
          </div>
        </div>
        <div class="tel">
          <span>휴대폰 번호</span>
          <div>
            <input
              class="form-control"
              type="text"
              name="tel"
              id="tel"
              value="${uVO.usertel }"
            />
          </div>
        </div>

        <div class="interest">
          <span>관심분야</span>
          <div>
            <input
              class="form-control"
              type="text"
              name="interest"
              id="interest"
              value="웹/개발, 사진/음향"
            />
          </div>
        </div>

        <div class="profileImg">
          <span>프로필</span>
          <div>
            <input type="button" value="변경" class="btn btn-outline-primary" />
          </div>
        </div>

        <div class="pofol">
          <span>포트폴리오 공개</span>
          <div>
            <input
              type="checkbox"
              checked
              data-toggle="toggle"
              data-onstyle="primary"
            />
          </div>
        </div>

        <div class="comment" style="text-align: left">
          <span>소개글</span>
          <div>
            <textarea
              name="comment"
              class="form-control"
              style="resize: none; margin: 20px 0px"
              id="comment"
              cols="30"
              rows="5"
            >${uVO.comment }</textarea>
          </div>
        </div>

        <input
          type="submit"
          class="btn btn-outline-primary"
          value="수정 완료"
          style="width: 100%; margin-top: 30px; height: 40px"
        />
      </form>
    </main>
    <script>
      const toggleBtn = document.querySelector(".hamberger");
      const menu = document.querySelector(".nav_wrapper");
      const userNickname = document.querySelector(".userNickname");
      const userInfo = document.querySelector(".userInfo");
      const ajaxMenu = document.querySelector(".menuClick");

      toggleBtn.addEventListener("click", () => {
        menu.classList.toggle("dropdown"); // on/off
      });

      userNickname.addEventListener("click", () => {
        userInfo.classList.toggle("dropdown");
      });
      

	 function frmCheck(){
		 alert('rkwlak');
		 return false; 
	  }
		  
	  
    </script>
  </body>
</html>
<%@include file="../header_footer/footer.jspf" %>