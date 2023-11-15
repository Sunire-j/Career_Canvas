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
        $(function () {
            $('input[type="radio"]').change(function () {
                if ($(this).val() == '1') {
                    if (!$('.for-company').length) {
                        $('<div class="for-company mt-3"><label for="companyno" class="form-label">사업자등록번호:</label>' +
                            '<input type="text" class="form-control" id="companyno" placeholder="사업자등록번호( - 포함 )" name="companyno"></div>').insertAfter('#pw');
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
    <h3 style="text-align: center; margin-top: 150px">Career Canvas 로그인</h3>
    <form method="post" action="${pageContext.servletContext.contextPath}/loginOk" id="findidForm" name="findidForm">
        <%--가입 유형 선택--%>
        <div style="display: flex; height: 40px; font-weight: bold; margin: 50px auto 0;width: 40%">
            <input type="radio" name="usertype" value="0" checked/>
            <p style="margin-left: 10px; line-height: 40px">개인회원</p>
            <input type="radio" name="usertype" value="1" style="margin-left: 20px"/>
            <p style="margin-left: 10px; line-height: 40px">기업회원</p>
        </div>
        <div style="width: 40%; margin: 10px auto 0;">
            <label for="userid" class="form-label">아이디:</label>
            <input type="text" class="form-control" id="userid" placeholder="아이디를 입력해주세요." name="userid">
            <label for="pw" class="form-label mt-3">비밀번호:</label>
            <input type="password" class="form-control" id="pw" placeholder="비밀번호를 입력해주세요." name="userpwd">
            <div class="mt-3" style="display: flex; justify-content: space-between; align-items: center;">
                <div style="display: flex;   align-items: center;">
                    <a href="${pageContext.servletContext.contextPath}/findid"><p style="color: red; font-size: 14px">아이디</p></a>
                    <p style="font-size: 14px">/</p>
                    <a href="${pageContext.servletContext.contextPath}/findpw"><p style="color: red; font-size: 14px">비밀번호찾기</p></a>
                    &nbsp;<p style="font-size: 14px">|</p>&nbsp;
                    <a href="${pageContext.servletContext.contextPath}/signup"><p style="font-size: 14px">회원가입</p></a>
                </div>
                <input type="submit" class="btn btn-primary" value="로그인"/>
            </div>
        </div>
    </form>
</div>

</body>
</html>

<%@include file="../header_footer/footer.jspf" %>