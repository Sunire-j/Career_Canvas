<%@ page contentType="text/html;charset=UTF-8" language="java"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@include
file="../header_footer/header.jspf" %>
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
    <script>
      /* 이미지 파일 집어넣는 위치*/
      function uploadImage() {
        var fileInput = document.getElementById("fileInput");
        var previewImage = document.getElementById("previewImage");

        var files = fileInput.files;

        if (files.length > 0) {
          var selectedFile = files[0];
          var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;

          if (allowedExtensions.exec(selectedFile.name)) {
            var formData = new FormData();
            formData.append("file", selectedFile);

            // 서버로 이미지 업로드
            fetch("/upload", {
              method: "POST",
              body: formData,
            })
              .then((response) => response.json())
              .then((data) => {
                // 서버에서 반환된 데이터를 처리하거나 알림을 표시할 수 있습니다.
                console.log(data);
              })
              .catch((error) => console.error("Error:", error));

            // 이미지를 미리보기로 표시
            var reader = new FileReader();
            reader.onload = function (e) {
              previewImage.src = e.target.result;
            };
            reader.readAsDataURL(selectedFile);
          } else {
            alert("jpg, jpeg, png 파일만 선택 가능합니다.");
          }
        }
      }
    </script>
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
      .btn-primary, .btn-outline-primary, .btn-secondary, .btn-outline-secondary
      ,.btn-info ,.btn-outline-info, .btn-danger ,.btn-outline-danger{
        font-size: 14px;
        padding: 2px 4px;
        margin: 5px;
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
        width: 90%;
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
      .tel,
      .password,
      .interest,
      .pofol,
      .passwordCheck {
        display: flex;
        justify-content: space-between;
        padding-bottom: 20px;
        text-align: center;
      }

      .profileImg {
        margin: 0 auto;
        height: 80px;
        display: flex;
        justify-content: space-between;
        padding-bottom: 20px;
        align-items: center;
      }

      .profilebox {
        display: flex;
        justify-content: center;
        justify-content: space-between;
        text-align: center;
        width: 200px;
      }

      .profiletext {
        display: flex;
        align-items: center;
        text-align: left;
        margin-right: 20px;
      }

      .userInterest span {
        margin-right: 5px;
      }

      #previewImage {
        max-width: 50px; /* 이미지 최대 너비 지정 */
        max-height: 50px; /* 이미지 최대 높이 지정 */
        border-radius: 30%;
      }
      input[type="checkbox"] {
        opacity: 0;
        position: absolute;
      }
      .container_bottom{
        display: flex;
        background: #A69668;
        height: 10px;
        margin-top: 10px;
      }
       {
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
            <img
              src="${pageContext.servletContext.contextPath}/upload${uVO.profileimg}"
              alt=""
            />
            <div style="padding-left: 20px">
              <div class="userId">
                <a href="mypage.html"
                  ><span style="font-size: 1.5rem">${uVO.username }</span></a
                >
              </div><p>${uVO.comment }</p>
            </div>
          </div>
          <!-- Interest -->

          <div style="padding: 20px 10px 0px 30px; border-left: 2px solid #73351F">
            <p style="display: flex; justify-content: center; font-size: 1.5rem" >관심분야</p>
            <div class="userInterest" style="display: flex; flex-wrap: wrap">
              <c:forEach var="interest" items="${interest}">
                <span><input type="button" class="btn btn-outline-primary" value="${interest}"></span>
              </c:forEach>
            </div>
          </div>
        </div>
      </div>
    </main>
      <!-- Edit Area -->
    <section class="container" style="padding: 0px; border-bottom: 3px solid #73351F; background: #F2F2F2">
      <div style="padding: 10px 40px 40px 40px">
      <form
        class="editFrm"
        action="${pageContext.servletContext.contextPath}/mypageEditOk"
        method="post"
        onsubmit="return frmCheck()"
        enctype="multipart/form-data"
      >
        <p>회원정보 설정</p>

        <div class="nickName">
          <span>닉네임</span>
          <div>
            <input
              class="form-control"
              type="text"
              name="nickName"
              id="nickName"
              pattern="^[a-zA-Z0-9가-힣]{2,12}$"
              required
              value="${uVO.username }"
            />
            <div id="nicknameResult"></div>
          </div>
        </div>

        <div class="password">
          <span>비밀번호</span>
          <div>
            <input
              class="form-control"
              type="password"
              name="password"
              pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,20}$"
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
              pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,20}$"
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
              pattern="01[016789]-([0-9]{3}|[0-9]{4})-[0-9]{4}"
              required
              value="${uVO.usertel }"
            />
          </div>
        </div>

        <div class="interest">
          <span>관심분야</span>
          <div style="width: 80%;  text-align: right;">
            <label for="industry"
              ><span class="btn btn-outline-danger">산업디자인</span>
              <input type="hidden" name="color" value="danger"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="industry"
              value="산업디자인"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="character"
              ><span class="btn btn-outline-danger">캐릭터&일러스트</span>
              <input type="hidden" name="color" value="danger"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="character"
              value="캐릭터&일러스트"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="calligraphy"
              ><span class="btn btn-outline-danger">캘리그라피</span>
              <input type="hidden" name="color" value="danger"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="calligraphy"
              value="캘리그라피"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="architecture"
              ><span class="btn btn-outline-danger">공간&건축</span>
              <input type="hidden" name="color" value="danger"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="architecture"
              value="공간&건축"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="fassion"
              ><span class="btn btn-outline-danger">패션디자인</span>
              <input type="hidden" name="color" value="danger"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="fassion"
              value="패션디자인"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <br>
            <label for="uxui"
              ><span class="btn btn-outline-primary">UX/UI</span>
              <input type="hidden" name="color" value="primary"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="uxui"
              value="UX/UI"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="mobile"
              ><span class="btn btn-outline-primary">모바일개발</span>
              <input type="hidden" name="color" value="primary"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="mobile"
              value="모바일개발"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="web"
              ><span class="btn btn-outline-primary">웹개발</span>
              <input type="hidden" name="color" value="primary"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="web"
              value="웹개발"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="program"
              ><span class="btn btn-outline-primary">프로그램</span>
              <input type="hidden" name="color" value="primary"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="program"
              value="프로그램"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="ai"
              ><span class="btn btn-outline-primary">인공지능</span>
              <input type="hidden" name="color" value="primary"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="ai"
              value="인공지능"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="picture"
              ><span class="btn btn-outline-info">사진</span>
              <input type="hidden" name="color" value="info"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="picture"
              value="사진"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="sound"
              ><span class="btn btn-outline-info">음향</span>
              <input type="hidden" name="color" value="info"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="sound"
              value="음향"
              class="checkbox"
              onclick="return checkedCount()"
            />
            <label for="video"
              ><span class="btn btn-outline-info">영상</span>
              <input type="hidden" name="color" value="info"
            /></label>
            <input
              type="checkbox"
              name="interest"
              id="video"
              value="영상"
              class="checkbox"
              onclick="return checkedCount()"
            />
          </div>
        </div>

        <div class="profileImg">
          <div class="profilebox" style="align-items: center">
            <div class="profiletext">프로필</div>
            <div id="previewContainer">
              <img
                id="previewImage"
                src="upload/staticimage/staticprofile.png"
                alt="프로필 이미지"
              />
            </div>
          </div>
          <label class="btn btn-outline-primary changeimgbtn">
            변경
            <input
              type="file"
              accept=".jpg, .jpeg, .png"
              id="fileInput"
              name="fileInput"
              style="display: none"
              onchange="uploadImage()"
            />
          </label>
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
            >${uVO.comment}</textarea>
          </div>
        </div>
        <p onclick="leave()">탈퇴하기</p>
        <input
          type="submit"
          class="btn btn-outline-primary"
          value="수정 완료"
          style="width: 100%; margin-top: 30px; height: 40px"
        />
      </form>
      </div>
      </div>
      </div>
      <div class="container_bottom"></div>
    </section>
    <script>
      $(function () {
        // 닉네임유효성 함수
        $("#nickName").on("input blur", function () {
          var $this = $(this);
          if (this.checkValidity()) {
            $(this).removeClass("is-invalid").addClass("invalid");
            $.ajax({
              url: "${pageContext.servletContext.contextPath}/nickNameCheck",
              type: "POST",
              data: {
                nickname: $(this).val(),
              },
              success: function (rsp) {
                if (rsp == 0) {
                  $("#nicknameResult").html("사용 가능한 닉네임 입니다");
                }
                if (rsp == 1) {
                  $("#nicknameResult").html("이미 가입된 닉네임 입니다");
                }
              },
              error: function (e) {
                console.log(e.responseText);
              },
            });
          } else {
            console.log("!!!!!!!!!!!!!!!" + $this.val());
            if ($this.val() == "") {
              $("#nicknameResult").text("닉네임 입력하세요");
            } else {
              $("#nicknameResult").text("형식을 확인하세요");
            }
          }
        });
        $(".checkbox").on("change", function () {
          if (this.checked) {
            var color = $(this).prev("label").find("span").next().val();
            $(this)
              .prev("label")
              .find("span")
              .addClass("btn-" + color)
              .removeClass("btn-outline-" + color);
          } else {
            var color = $(this).prev("label").find("span").next().val();
            $(this)
              .prev("label")
              .find("span")
              .addClass("btn-outline-" + color)
              .removeClass("btn-" + color);
          }
        });
      }); // $(function() 끝

      // 폼체크 함수
      function frmCheck() {
        let password = $("#password").val();
        let passwordCheck = $("#passwordCheck").val();

        if (passwordCheck) {
          if (password != passwordCheck) {
            alert("비밀번호를 확인하세요");
            return false;
          }
          return true;
        }
      }

      // leave함수
      function leave() {
        if (confirm("탈퇴하시겠습니까?")) {
          location.href =
            "${pageContext.servletContext.contextPath}/mypage/leave";
        }
      }
      
      function checkedCount() {
        var checkedCount = 0;

        var checkboxes = document.getElementsByName("interest");
        for(var i=0; i<checkboxes.length; i++){
          if(checkboxes[i].checked){
            checkedCount++;
          }
        }

        if(checkedCount > 3){
          alert("관심분야는 3개를 초과할 수 없습니다");
          return false;
          };

          return true;
        }
      
        
    </script>
  </body>
</html>
<%@include file="../header_footer/footer.jspf" %>
