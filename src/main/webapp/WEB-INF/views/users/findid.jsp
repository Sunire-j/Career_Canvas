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
    <style>
        /* All */
        h3{
            height: 40px;
            display: flex;
            text-align: center;
            margin: 0 auto;
            font-size: 32px;
            text-shadow: 0px 0px 1px #0D0D0D;
            font-weight: bold;
            justify-content: center;
            align-items: center;
            color: #73351F;
        }
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            list-style: none;
            text-decoration: none;
        }

        ul, li {
            padding: 0;
            margin: 0;
        }

        .container{
            width: 600px;
            margin : 0 auto;
            margin-top: 100px;
            background-color: #F2F2F2;
            border-width: 3px 1px 3px 1px;
            border-style: solid;
            border-color: #73351F;

        }
        .space {
            height: 200px;
            background: white;
        }

        a:link, a:visited {
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

        .navBar, .infoGroup {
            display: flex;
            justify-content: center;
            padding: 0;
            margin: 0;
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

        .carousel {
            z-index: 0;
        }


        /* Main */


        .second_hr {
            width: 1000px;
        }

        /* Banner */

        .carousel {
            width: 100%;
            margin: 0 auto;
        }

        .carousel-inner img {
            width: 60%;
            height: 300px;
            background: rgb(128, 128, 128);
            margin: 0 auto;
        }

        /* BestPopol */

        .bestPopol_wrapper {
            width: 1000px;
        }

        .bestPopol_wrapper > p {
            text-align: center;
            margin-top: 50px;
            padding-top: 50px;
        }

        .bestPopolList {
            margin-top: 50px;
            display: flex;
            justify-content: space-between;
        }

        .bestPopol {
            width: 200px;
            display: flex;
            flex-direction: column;
            text-align: center;
        }

        .bestPopol img {
            width: 180px;
            height: 180px;
            margin-bottom: 10px;
        }

        /* Homework */
        .homework_wrapper {
            width: 1000px;
        }

        .homeworkList {
            margin-top: 50px;
            display: flex;
            justify-content: space-between;
        }

        .homework {
            width: 200px;
            display: flex;
            flex-direction: column;
            text-align: center;
        }

        .homework img {
            width: 180px;
            height: 180px;
        }

        .homework_wrapper > p {
            text-align: center;
            margin-top: 50px;
            padding-top: 50px;
        }


        /* Footer */
        footer {
            height: 100px;
            background: rgb(184, 178, 178);
        }


        /* Media Query */
        @media screen and (max-width: 800px) {

            .nav_wrapper {
                display: none;
                flex-direction: column;
            }

            .nav_wrapper.active {
                display: flex;
            }

            .navBar, .infoGroup {
                display: block;
                padding: 0;
                text-align: center;
            }

            .hamberger {
                display: inline;
            }

            .title {
                justify-content: space-between;
            }

            .infoGroup > li:nth-child(2) {
                display: none;
            }
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
            height: 15px;
        }

    </style>
    <script>
        $(function () {
            $('input[type="radio"]').change(function () {
                if ($(this).val() == '1') {
                    if (!$('.for-company').length) {
                        $('<div class="for-company mt-3"><label for="companyno" class="form-label">사업자등록번호:</label>' +
                            '<input type="text" class="form-control" id="companyno" placeholder="가입 당시 사업자등록번호" name="companyno" pattern="[0-9]{3}-[0-9]{2}-[0-9]{5}" required>' +
                            '<div class="invalid-feedback">사업자등록번호를 입력해주세요.</div>' +
                            '<div class="invalid-feedback" data-feedback="patternMismatch">사업자등록번호 형식에 맞지 않습니다.</div>'
                            //여기까지 함
                        ).insertBefore('#btngroup');
                        $('#companyno').on('input blur', function () {
                            var $this = $(this);
                            var $feedbacks = $(this).parent().find('.invalid-feedback')

                            if (this.checkValidity()) {
                                $this.removeClass('is-invalid').addClass('is-valid');
                                $feedbacks.hide();
                            } else {
                                $this.removeClass('is-valid').addClass('is-invalid');
                                $feedbacks.hide();
                                if (this.validity.valueMissing) {
                                    $feedbacks.filter(':not([data-feedback])').show();
                                } else if (this.validity.patternMismatch) {
                                    $feedbacks.filter('[data-feedback="patternMismatch"]').show();
                                }
                            }
                        });
                    }
                } else {
                    $('.for-company').remove();
                }
            });

            $('input[name="userEmail"]').on('input blur', function () {
                var $this = $(this);
                var $feedbacks = $this.siblings('.invalid-feedback');

                if (this.checkValidity()) {
                    $this.removeClass('is-invalid').addClass('is-valid');
                    $feedbacks.hide();
                } else {
                    $this.removeClass('is-valid').addClass('is-invalid');
                    $feedbacks.hide();
                    if (this.validity.valueMissing) {
                        $feedbacks.filter(':not([data-feedback])').show();
                    } else if (this.validity.patternMismatch) {
                        $feedbacks.filter('[data-feedback="patternMismatch"]').show();
                    }
                }
            });

            $("#findidForm").on('change', function () {
                if ($('input[name="userEmail"]').hasClass('is-valid')) {
                    var temp = $('input[name="usertype"]:checked').val();
                    console.log(temp);
                    if(temp==0){
                        $("#submitbtn").prop('disabled', false);
                    }else{
                        if($("#companyno").hasClass('is-valid')){
                            $("#submitbtn").prop('disabled', false);
                        }else{
                            $("#submitbtn").prop('disabled', true);
                        }
                    }
                } else {
                    $("#submitbtn").prop('disabled', true);
                }
            });
        });
    </script>
</head>
<body>

<div class="container" style="padding: 0px">
<div class="container-head"></div>
    <div class="container-wrap" style="padding: 20px 50px 50px 25px;">
    <h3 style="text-align: center;">아이디를 잊으셨나요?</h3>
    <hr class="hr-styleset" style="margin-top: 30px">
    <form method="post" id="findidForm" action="${pageContext.servletContext.contextPath}/findidStart" class="needs-validation" name="findidForm" novalidate>
        <%--가입 유형 선택--%>
        <div style="display: flex; height: 40px; font-weight: bold; margin: 50px auto 0;width: 40%">
            <input type="radio" name="usertype" value="0" checked/>
            <p style="margin-left: 10px; line-height: 40px">개인회원</p>
            <input type="radio" name="usertype" value="1" style="margin-left: 20px"/>
            <p style="margin-left: 10px; line-height: 40px">기업회원</p>
        </div>
        <div style="width: 40%; margin: 10px auto 0;">
            <div>
                <label for="email" class="form-label">Email:</label>
                <input type="email" class="form-control userEmail" id="email" placeholder="가입당시 이메일" name="userEmail"
                       pattern="[a-z0-9]+@[a-z]+\.[a-z]{2,3}" required>
                <div class="invalid-feedback">이메일을 입력해주세요.</div>
                <div class="invalid-feedback" data-feedback="patternMismatch">이메일 형식에 맞지 않습니다.
                </div>
            </div>
            <div class="mt-3" id="btngroup" style="display: flex; justify-content: space-between">
                <button type="submit" id="submitbtn" class="btn btn-primary" disabled>아이디 찾기</button>
                <input type="button" class="btn btn-secondary" value="돌아가기" onclick="history.back()"/>
            </div>
        </div>
    </form>
    </div>
    <div class="container_bottom"></div>
</div>

</body>
</html>

<%@include file="../header_footer/footer.jspf" %>