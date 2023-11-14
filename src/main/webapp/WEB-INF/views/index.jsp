<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="./header_footer/header.jspf" %>
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
    <p>로그인 여부 : ${LogStatus}
    <c:if test="${LogStatus=='Y'}">
        로그인 아이디 : ${LogId}
        유저 타입 : ${usertype}
        <a href="${pageContext.servletContext.contextPath}/logout">로그아웃</a>
    </c:if>
    </p>
    <hr>
    <p>임시 페이지</p>
    <a href="${pageContext.servletContext.contextPath}/findid">아이디 찾기</a>
    <a href="${pageContext.servletContext.contextPath}/findpw">비밀번호 찾기</a>
    <a href="${pageContext.servletContext.contextPath}/login">로그인</a>
    <a href="${pageContext.servletContext.contextPath}/myteam/main">마이팀-메인 페이지</a>

    <hr/>
    <p>이 영역은 원래 get으로 접근 못하는 영역임.</p><br/>
    <p>완성 후 삭제되어야 함</p>
    <a href="${pageContext.servletContext.contextPath}/signup_end">회원가입 종료</a>
</div>

</body>
</html>
<%@include file="./header_footer/footer.jspf" %>
