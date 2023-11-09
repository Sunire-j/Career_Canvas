<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
    <p>임시 페이지</p>
    <a href="${pageContext.servletContext.contextPath}/findid">아이디 찾기</a>
    <a href="${pageContext.servletContext.contextPath}/findpw">비밀번호 찾기</a>
    <a href="${pageContext.servletContext.contextPath}/login">로그인</a>

    <hr/>
    <p>이 영역은 원래 get으로 접근 못하는 영역임.</p><br/>
    <p>완성 후 삭제되어야 함</p>
    <a href="${pageContext.servletContext.contextPath}/signup_end">회원가입 종료</a>
</div>

</body>
</html>

