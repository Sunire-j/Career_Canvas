<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/6caf283963.js" crossorigin="anonymous"></script>
    <style>
        p{
            margin: 0;
        }
        ul{
            margin: 0;
        }
        body{
            margin: 0;
        }
        .container{
            width: 1200px;
        }
        .mypartyvalue{
            width: 100%;
            height: 100px;
            display: flex;
            text-align: center;
            justify-content: center;
            margin: 0 auto;
            margin-top: 10px;
        }
        .mypartylist{
            width: 150px;
        }
        .partylisttitle{
            font-size: 18px;
            margin-bottom: -10px;
        }
        .partyvaluebutton1,.partyvaluebutton2
        {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            width: 110px;
            height: 40px;
            margin-right: 10px;
        }
        .choisvalue{
            margin: 0 auto;
            width: fit-content;
        }
        /*-------------------------------------------------------------*/
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: auto;
        }


        /* 파티 목록 리스트 */
        .party_list li{
            margin-right: 20px;
            float: left;
        }
        .member_img{
            width: 70px;
            height: 70px;
            border-radius: 20px;
        }
        .party_list_name{
            text-align: center;
            font-size: 15px;
            font-weight: bold;
        }
        .new_party_btn{
            border: none;
            background: none;
        }

        section{
            width: 1000px;
            margin: 0 auto;
        }

        /*----------------- 파티 생성-----------------*/
        section a{
            font-size: 1.3em;
            font-weight: bold;
        }

        .create_name,.create_profile, .create_objective, .create_intro{
            margin: 0 auto;
            width: 800px;
            display: flex;
            padding-bottom: 30px;
            border-bottom: 1px solid #ddd;
            margin-top: 40px;
        }
        .input_name{
            margin-left: 30px;
            width: 500px;
            height: 40px;
            line-height: 40px;
            border: 1px solid #ddd;
            padding-left: 10px;
        }
        .overlap_btn{
            margin-left: 20px;
        }

        /* 프로필 업로드 */
        #ex_file {
            width: 0.1px;
            height: 0.1px;
            opacity: 0;
            overflow: hidden;
            position: absolute;
            z-index: -1;
        }

        #ex_file + label {
            background-image: url("${pageContext.servletContext.contextPath}/upload/staticimage/fileUploadImg.png");
            border-radius: 20px;
            background-size: cover;
            width: 130px;
            height: 130px;
            display: inline-block;
            cursor: pointer;
        }

        .profile_upload{
            margin-top: 10px;
            margin-left: 40px;
        }

        .upload_guide{
            margin-left: 40px;
            padding-top: 20px;
        }

        /* 파티 목표 & 소개 */
        .input_objective, .input_intro{
            margin-left: 30px;
            width: 610px;
            height: 40px;
            line-height: 40px;
            border: 1px solid #ddd;
            padding-left: 10px;
        }

        /* 파티 생성 버튼 */
        .party_create_btn{
            width: 200px;
            margin: 0 auto;
        }
        .create_btn{
            width: 100%;
            margin-top: 30px;
            margin-bottom: 30px;
        }
    </style>
    <script>
        // 파티 프로필 이미지 업로드
        function handleFileUpload() {
            const inputElement = document.getElementById('ex_file');
            const file = inputElement.files[0];
            const imgFileElement = document.getElementById('previewContainer');

            if (file) {
                const allowedExtensions = ['png', 'jpg', 'jpeg'];
                const fileNameParts = file.name.split('.');
                const fileExtension = fileNameParts[fileNameParts.length - 1].toLowerCase();
                const imgpreview = document.getElementsByClassName("imgpreview");

                // 파일 확장자가 허용된 확장자인지 확인
                if (allowedExtensions.includes(fileExtension)) {
                    const formData = new FormData();
                    formData.append('file', file);

                    // 이미지 미리보기 업데이트
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.querySelector('.imgpreview').style.backgroundImage='url('+reader.result+')';
                    }
                    reader.readAsDataURL(file);

                } else {
                    alert('지원되지 않는 파일 형식');
                    inputElement.value = ''; // 선택된 파일 제거
                    imgFileElement.innerHTML = ''; // 이미지 미리보기 지우기

                }
            } else {
                alert('파일을 선택하세요.');
                imgFileElement.innerHTML = ''; // 이미지 미리보기 지우기
                imgFileElement.style.display = 'none'; // 이미지 미리보기 숨기기
            }
        }


        $(function () {
            $(".party_list_btn").click(function () {
                no = $(this).attr('title');
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/main?partyid='+no;
            });

            $(".checkName").on('click', function (){
               var tag = $(".input_name");
               var name = tag.val();
               if(name==''){
                   alert("파티명을 입력해주세요.");
                   return false;
               }
               const regex = /^[A-Za-z가-힣0-9]{2,8}$/;
               if(!regex.test(name)){
                   alert("파티명은 2-8글자, 한글, 영문만 사용 가능합니다.");
                   return false;
               }
               $.ajax({
                  url:"${pageContext.servletContext.contextPath}/party/nameCheck",
                  data : {
                      name : name
                  },type : "post",
                   success:function (result){
                      console.log(result);
                      if(result==0){

                        tag.prop("disabled", true);
                          $(".checkName").text("사용가능");
                          $("#realName").val(name);
                          $(".create_btn").prop("disabled", false);
                      }else{
                          alert("이미 사용중입니다. 다른 파티명을 입력해주세요.");
                          tag.val("");
                      }
                   },error:function (e){
                      console.log(e.responseText);
                   }

               });
            });

        });
    </script>
</head>
<body>
<main class="container">
    <div class="mypartyvalue">
        <input type="button" class="btn btn-outline-secondary partyvaluebutton1" value="파티 모집" onclick="location.href='${pageContext.servletContext.contextPath}/party/wanted'">
        <input type="button" class="btn btn-secondary partyvaluebutton2" value="내 파티" onclick="location.href='${pageContext.servletContext.contextPath}/myteam/main'">
    </div>
    <div class="mypartylist">
        <p class="partylisttitle" style="font-weight: bold; font-size: 1.3em;">내 파티 목록</p>
        <hr>
    </div>
    <ul class="party_list">
            <c:forEach items="${pvo}" var="p">
                <li title="${p.partyid}" class="party_list_btn">
                    <img src="${pageContext.servletContext.contextPath}/upload${p.partyimage}" class="member_img">
                    <div class="party_list_name">
                            ${p.partyname}
                    </div>
                </li>
            </c:forEach>
        <li style="float: left">
            <button class="new_party_btn" onclick="location.href='${pageContext.servletContext.contextPath}/party/create'">
                <i class="fa-regular fa-square-plus fa-4x"></i><br/>
                <span style="font-weight: bold;">파티생성</span>
            </button>
        </li>
    </ul>
    <div class="choisvalue" style="margin-top: 30px;height: 38px;"></div>
    <hr>
</main>

<article>
    <section class="teamView">
        <p style="font-size: 2em; font-weight: bold; margin-top: 50px; text-align: center;">파티 생성</p>
        <hr/>
        <form id="createFrm" action="${pageContext.servletContext.contextPath}/myteam/create" enctype="multipart/form-data" method="post">
            <!-- 파티명 -->
            <div class="create_name">
                <a style="line-height: 40px; padding-left:10px;">파티명 *</a>
                <input type="text" class="input_name" name="input_name"  maxlength="8" placeholder=" 2~8자 이내로 파티명을 입력해주세요. "/>
                <input type="hidden" name="input_name" id="realName" />
                <button type="button" class="btn btn-secondary overlap_btn checkName">중복 검사</button>
            </div>

            <!-- 프로필 업로드 -->
            <div class="create_profile">
                <a style="line-height: 40px; padding-left:10px;">파티 프로필</a>
                <div class="profile_upload">
                    <!-- <div class="img_file" id="previewContainer"></div> -->
                    <div class="file-upload">
                        <input type="file" id="ex_file" name="ex_file" accept=".png, .jpg, .jpeg" onchange="handleFileUpload()">
                        <label for="ex_file" class="imgpreview"></label>
                    </div>
                </div>
                <div class="upload_guide">
                    <p style="font-size: .8em; font-weight: bold;padding-bottom: 5px;">파티를 표현할 프로필 이미지를 선택해주세요.<br/>미선택시 기본 이미지로 설정됩니다.</p>
                    <p style="font-size: .7em; font-weight: bold;">* png, jpg, jpeg 파일만 업로드 가능합니다.</p>
                </div>
            </div>

            <!-- 파티 목표 -->
            <div class="create_objective">
                <a style="line-height: 40px; padding-left: 10px;">파티 목표</a>
                <input type="text" class="input_objective" name="input_objective" maxlength="80"
                       placeholder="N글자 이내로 생성할 파티의 목표를 입력해주세요."/>
            </div>

            <!-- 파티 소개 -->
            <div class="create_intro">
                <a style="line-height: 40px; padding-left: 10px;">파티 소개</a>
                <input type="text" class="input_intro" name="input_intro" maxlength="80"
                       placeholder="N글자 이내로 간단한 파티 소개 내용을 입력해주세요." />
            </div>
            <div class="party_create_btn">
                <input type="submit" class="btn btn-secondary create_btn" disabled value="파티 생성" />
            </div>
        </form>
    </section>
</article>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>
