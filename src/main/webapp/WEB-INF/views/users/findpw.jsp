<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../header_footer/header.jspf"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(function(){
            $('input[type="radio"]').change(function(){
                if($(this).val() == '1') {
                    if(!$('.for-company').length) {
                        $('<div class="for-company mt-3"><label for="companyno" class="form-label">사업자등록번호:</label>'+
                            '<input type="text" class="form-control" id="companyno" placeholder="가입 당시 사업자등록번호" name="companyno"></div>').insertAfter('#email');
                    }
                } else {
                    $('.for-company').remove();
                }
            });
        });
    </script>
</head>
<body>
<div class="container">
    <h3 style="text-align: center; margin-top: 150px">비밀번호를 잊으셨나요?</h3>
    <form method="post" id="findpwForm" name="findpwForm">
        <%--가입 유형 선택--%>
        <div style="display: flex; height: 40px; font-weight: bold; margin: 50px auto 0;width: 40%">
            <input type="radio" name="iscompany" value="0" checked/>
            <p style="margin-left: 10px; line-height: 40px">개인회원</p>
            <input type="radio" name="iscompany" value="1" style="margin-left: 20px"/>
            <p style="margin-left: 10px; line-height: 40px">기업회원</p>
        </div>
        <div style="width: 40%; margin: 10px auto 0;">
            <label for="id" class="form-label">아이디:</label>
            <input type="email" class="form-control" id="id" placeholder="아이디" name="id">
            <label for="email" class="form-label mt-3">Email:</label>
            <input type="email" class="form-control" id="email" placeholder="이메일" name="email">
            <div class="mt-3" style="display: flex; justify-content: space-between">
                <button type="submit" class="btn btn-primary">비밀번호 찾기</button>
                <input type="button" class="btn btn-secondary" value="돌아가기" onclick="history.back()"/>
            </div>

        </div>

    </form>
</div>

</body>
</html>

