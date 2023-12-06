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
        .edit_category {
            width: 210px;
            margin: 0 auto;
            margin-top: 30px;
            margin-bottom: 20px;
        }
        /*----------------- 파티 수정-----------------*/
        .party_name{
            margin: 0;
            margin-top: 20px;
            text-align: center;
            font-weight: bold;
            font-size: 2.5em;
            line-height: 100%;
        }
        .content_title{
            text-align: center;
            font-weight: bold;
            color: darkgrey;
        }
        .edit_content{
            width: 800px;
            margin: 0 auto;
        }
        .name_edit, .profile_edit, .objective_edit, .intro_edit{
            font-weight: bold;
            margin-top: 50px;
        }
        .intro_edit_box, .objective_edit_box{
            width: 90%;
            height: 110px;
            margin-left: 20px;
            font-size: 1.4em;
            word-wrap: break-word;
            resize: none;
        }
        .name_edit_btn, .objective_edit_btn, .intro_edit_btn,.partyImg_edit_btn,
        .name_edit_btn_ok, .objective_edit_btn_ok, .intro_edit_btn_ok, .partyImg_edit_btn_ok{
            font-size: 0.9em;
            color: #868e96;
            float: right;
            border: none;
            background: none;
        }


        .profile_edit img{
            margin-left: 20px;
            width: 100px;
            border-radius: 20px;
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
            background-image: url("${pageContext.servletContext.contextPath}/upload/staticimage/fileUploadImg.PNG");
            border-radius: 20px;
            background-size: cover;
            width: 120px;
            height: 100px;
            display: inline-block;
            cursor: pointer;
        }

        .profile_edit_box{
            margin-top: 10px;
            margin-left: 40px;
        }

        .edit_guide{
            margin-left: 40px;
            padding-top: 20px;
        }
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
            background-image: url("${pageContext.servletContext.contextPath}/upload/${partyvo.partyimage}");
            border-radius: 20px;
            background-size: cover;
            width: 120px;
            height: 120px;
            display: inline-block;
            cursor: pointer;
        }

        .profile_edit_box{
            margin-top: 10px;
            margin-left: 40px;
            display: flex;
        }

        .edit_guide{
            margin-left: 40px;
            padding-top: 20px;
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
            // --------- 파티명 수정 ----------------
            $('.name_edit_btn').click(function() {
                event.preventDefault();
                $('.name_edit_box').prop('readonly', false);
                $(this).css('display', 'none');
                $(".name_edit_btn_ok").css('display','block');
            });

            $('#name_editFrm').on('submit', function(e){
                event.preventDefault();
                console.log("!");

                var no = ${partyvo.partyid};
                var name = $('.name_edit_box').val();
                if(name==''){
                    alert("파티명을 입력해주세요.");
                    return false;
                }
                const regex = /^[A-Za-z가-힣0-9]{2,8}$/;
                if(!regex.test(name)){
                    alert("파티명은 2-8글자, 한글, 영문만 사용 가능힙니다.");
                    return false;
                }
                $.ajax({
                    url:"${pageContext.servletContext.contextPath}/party/nameCheck",
                    data : {
                        name : name,
                        no : no
                    },type : "post",
                    success:function (result){
                        console.log(result);
                        if(result==0){
                            $.ajax({
                                url:"${pageContext.servletContext.contextPath}/party/nameUpdate",
                                type:"post",
                                data: {
                                    no:no,
                                    name:name
                                },success:function(){
                                    console.log("!!");
                                    $(".name_edit_btn_ok").css('display','none');
                                    $(".name_edit_btn").css('display','block');
                                    $('.name_edit_box').prop('readonly', true);
                                },error:function (e){
                                    console.log(e);
                                }
                            });
                        }else{
                            alert("이미 사용중인 파티명입니다. 다른 파티명을 입력해주세요.");
                            name.val("");
                        }
                    },error:function (e){
                        console.log(e.responseText);
                    }
                });

            });
            // --------- 파티 목표 수정 ----------------
            $('.objective_edit_btn').click(function() {
                event.preventDefault();
                $('.objective_edit_box').prop('readonly', false);
                $(this).css('display', 'none');
                $(".objective_edit_btn_ok").css('display','block');
            });

            $('#objective_editFrm').on('submit', function(e){
                event.preventDefault();
                console.log("!");

                var no = ${partyvo.partyid};
                var objective = $('.objective_edit_box').val();
                if(objective==''){
                    alert("파티목표를 입력해주세요.");
                    return false;
                }
                $.ajax({
                    url:"${pageContext.servletContext.contextPath}/party/objectiveUpdate",
                    type:"post",
                    data: {
                        no:no,
                        objective:objective
                    },success:function(){
                        console.log("!!");
                        $(".objective_edit_btn_ok").css('display','none');
                        $(".objective_edit_btn").css('display','block');
                        $('.objective_edit_box').prop('readonly', true);
                    },error:function (e){
                        console.log(e);
                    }
                });
            });
            // --------- 파티 소개 수정 ----------------
            $('.intro_edit_btn').click(function() {
                event.preventDefault();
                $('.intro_edit_box').prop('readonly', false);
                $(this).css('display', 'none');
                $(".intro_edit_btn_ok").css('display','block');
            });

            $('#intro_editFrm').on('submit', function(e){
                event.preventDefault();
                console.log("!");

                var no = ${partyvo.partyid};
                var intro = $('.intro_edit_box').val();
                if(intro==''){
                    alert("파티명을 입력해주세요.");
                    return false;
                }
                $.ajax({
                    url:"${pageContext.servletContext.contextPath}/party/introUpdate",
                    type:"post",
                    data: {
                        no:no,
                        intro:intro
                    },success:function(){
                        console.log("!!");
                        $(".intro_edit_btn_ok").css('display','none');
                        $(".intro_edit_btn").css('display','block');
                        $('.intro_edit_box').prop('readonly', true);
                    },error:function (e){
                        console.log(e);
                    }
                });
            });

            // 파티프로필 수정
            $('.partyImg_edit_btn').click(function() {
                $(this).css('display', 'none');
                $(".partyImg_edit_btn_ok").css('display','block');
                $('#ex_file').prop('disabled', false);
            });



            $('.mainbtn').click(function (){
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/main?partyid=${partyvo.partyid}';
            });
            $(".party_list_btn").click(function () {
                no = $(this).attr('title');
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/main?partyid='+no;
            });

            $("#memberEdit_btn").click(function () {
                no = ${partyvo.partyid};
                window.location.href = '${pageContext.servletContext.contextPath}/party/memberEdit?no='+ no;
            });

            $('.chatbtn').click(function (){
                no = ${partyvo.partyid};
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/chat?no='+no;
            });

            $('.portpoliobtn').click(function (){
                no = ${partyvo.partyid};
                window.location.href = '${pageContext.servletContext.contextPath}/party/portpolio?no='+no;
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
    <div class="choisvalue" style="margin-top: 30px; display: flex">
        <input type="button" class="btn btn-outline-secondary mainbtn" value="메인" style="margin-right: 10px">
        <input type="button" class="btn btn-outline-secondary chatbtn" value="채팅" style="margin-right: 10px">
        <input type="button" class="btn btn-secondary partysetbtn" value="파티관리" style="margin-right: 10px" onclick="changeClass(this)">
        <input type="button" class="btn btn-outline-secondary portpoliobtn" value="포트폴리오" onclick="changeClass(this)">
    </div>
    <hr>
</main>

<article>
    <section class="teamView">
        <p class="party_name">${partyvo.partyname}</p>
        <p class="content_title">파티관리</p>
        <div class="edit_category" style="display: flex;">
            <button type="button" class="btn btn-secondary"  style="margin-right: 20px;">정보수정</button>
            <form>
                <input type="hidden" name="partyid" value="${partyvo.partyid}"/>
                <button type="button" class="btn btn-outline-secondary" id="memberEdit_btn">회원관리</button>
            </form>
        </div>
        <hr style="width: 900px; margin: 0 auto"/>
        <div class="edit_content">
            <form id="name_editFrm">
                <div class="name_edit">
                    <span style=" font-size: 1.3em; color: #495057;">파티명</span>
                    <input type="button" class="name_edit_btn" value="수정+" />
                    <input type="submit" class="name_edit_btn_ok" style="display: none" value="수정하기"/>
                    <hr style="margin-top: 5px;"/>
                    <input type="text" class="name_edit_box" name="name_edit_box" style="margin-left: 20px; font-size: 1.7em; border: none;" value="${partyvo.partyname}" readonly />
                </div>
            </form>
        <form id="profileImg_editFrm" action="${pageContext.servletContext.contextPath}/party/profileUpdate" enctype="multipart/form-data" method="post">
            <input type="hidden" value="${partyvo.partyid}" name="no">
            <div class="profile_edit">
                <span style=" font-size: 1.3em; color: #495057;">프로필 이미지</span>
                <input type="button" class="partyImg_edit_btn" value="수정+" />
                <input type="submit" class="partyImg_edit_btn_ok" style="display: none" value="수정하기"/>
                <hr style="margin-top: 5px;"/>
                <div class="profile_edit_box">
                    <!-- <div class="img_file" id="previewContainer"></div> -->
                    <div class="file-edit">
                        <input type="file" id="ex_file" name="ex_file" accept=".png, .jpg, .jpeg" onchange="handleFileUpload()" disabled>
                        <label for="ex_file" class="imgpreview"></label>
                    </div>
                    <div class="edit_guide" style="display: none">
                        <p style="font-size: .8em; font-weight: bold;padding-bottom: 5px;">변경할 파티 프로필 이미지를 선택해주세요.</p>
                        <p style="font-size: .7em; font-weight: bold;">* png, jpg, jpeg 파일만 업로드 가능합니다.</p>
                    </div>
                </div>
            </div>
        </form>
            <form id="objective_editFrm">
                <div class="objective_edit">
                    <span style=" font-size: 1.3em; color: #495057;">파티 목표</span>
                    <input type="button" class="objective_edit_btn" value="수정+" />
                    <input type="submit" class="objective_edit_btn_ok" style="display: none" value="수정하기"/>
                    <hr style="margin-top: 5px;"/>
                    <textarea class="objective_edit_box" readonly style="border:none;" maxlength="80">${partyvo.partygoal}</textarea>
                </div>
            </form>
            <form id="intro_editFrm">
                <div class="intro_edit">
                    <span style=" font-size: 1.3em; color: #495057;">파티 소개</span>
                    <input type="button" class="intro_edit_btn" value="수정+" />
                    <input type="submit" class="intro_edit_btn_ok" style="display: none" value="수정하기"/>
                    <hr style="margin-top: 5px;"/>
                    <textarea class="intro_edit_box" readonly style="border: none;" maxlength="80">${partyvo.partycomment}</textarea>
                </div>
            </form>

        </div>
    </section>
</article>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>
