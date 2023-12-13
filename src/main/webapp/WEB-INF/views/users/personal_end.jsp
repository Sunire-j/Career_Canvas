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
<style>
    .login-container{
        margin: 0 auto;
        margin-top: 120px;
        border-width: 3px 1px 3px 1px;
        border-style: solid;
        border-color: #73351F;
        background: #F2F2F2;
        width: 600px;
    }
    .container-inner{
        padding: 0px 50px 10px 50px;
    }
    h3{
        padding-top: 20px;
        padding-bottom: 20px;
    }
    .container_bottom{
        display: flex;
        background: #A69668;
        height: 10px;
        margin-top: 10px;
    }
    .container-head{
        display: flex;
        justify-content: center;
        align-items: center;
        background: #A69668;
        height: 10px;
    }

</style>
<body>
<!-- Header -->
<div class="container">
    <div class="login-container">
        <div class="container-head"></div>
            <div class="container-inner">
                <h3 style="text-align: center; color: #73351F; font-weight: bold; text-shadow: 0px 0px 1px #0D0D0D; font-size: 32px">회원가입을 축하합니다!</h3>
                <hr style="border: 0;border-top: 2.5px dashed #73351F ; border-bottom: 1px dashed #D9D9D9;" >
                <h5 style="text-align: center; margin-top: 30px">가입 ID : ${tempID}</h5>
                <h5 style="text-align:center" class="mt-3">가입 E-mail : ${tempmail}</h5>
                <div class="mt-4" style="display: flex;margin: 0 auto; width: 25%; justify-content: center; align-items: center">
                    <input type="button" class="btn btn-secondary" value="홈으로" style="margin-right: 200px" onclick="location.href='${pageContext.servletContext.contextPath}/'"/>
                    <input type="button" class="btn btn-primary" value="로그인" onclick="location.href='${pageContext.servletContext.contextPath}/login'"/>
                </div>
            </div>
        <div class="container_bottom"></div>
        </div>
    </div>
</div>
</body>
</html>

<%@include file="../header_footer/footer.jspf" %>