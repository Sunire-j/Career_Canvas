<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@include
        file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
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
            border-radius: 50%;
        }

        .changeimgbtn {
            height: 30px;
            width: 50px;
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
            <img src="/img/bbb.png" alt=""/>
            <div>
                <div class="userId">
                    <a href="mypage.html"
                    ><span style="font-size: 1.5rem">${uVO.username }</span></a
                    >
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
    <hr style="margin: 0 auto; margin-top: 95px; width: 800px"/>

    <!-- Edit Area -->

    <form
            class="editFrm"
            action="mypageEditOk"
            method="post"
            onsubmit="return frmCheck()"
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
            <div class="profilebox" style="align-items: center">
                <div class="profiletext">프로필</div>
                <div id="previewContainer">
                    <img id="previewImage" src="upload/staticimage/staticprofile.png" alt="프로필 이미지">
                </div>
            </div>
            <label class="btn btn-outline-primary changeimgbtn">
                변경
                <input type="file" name="fileInput" accept=".jpg, .jpeg, .png" id="fileInput" style="display:none;" onchange="uploadImage()">
            </label>
        </div>
        <!--<i class="fas fa-user fa-3x tmpimg"></i>-->
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
            >
                ${uVO.comment }</textarea
            >
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
    function frmCheck() {
        return false;
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


</script>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>
