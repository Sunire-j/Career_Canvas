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
</head>
<body>
<!-- Header -->
<div class="container">
    <h3 style="text-align: center; margin-top: 150px">회원가입을 축하합니다!</h3>
    <h5 style="text-align: center; margin-top: 50px">가입 ID : ${tempID}</h5>
    <h5 style="text-align:center" class="mt-3">가입 E-mail : ${tempmail}</h5>
    <div class="mt-4" style="display: flex; width: 25%; margin: 0 auto; justify-content: space-between">
        <input type="button" class="btn btn-success" value="홈으로" onclick="location.href='${pageContext.servletContext.contextPath}/'"/>
        <input type="button" class="btn btn-primary" value="로그인" onclick="location.href='${pageContext.servletContext.contextPath}/login'"/>
    </div>
</div>
</body>
</html>

<%@include file="../header_footer/footer.jspf" %>