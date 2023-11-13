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
    <style>
        .msg_box{
            width: 1150px;
            margin: 0 auto;
            margin-top: 150px;
        }
        .error_num{
            width: 500px;
            height: 280px;
            font-size: 200px;
            font-weight: bold;
            line-height: 280px;
            text-align: center;
            border-right: 4px solid darkgrey;
            display: inline-block;
        }
        .error_msg{
            height: 300px;
            margin-left: 30px;
            display: inline-block;
        }

        .select_btn{
            padding-left: 180px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="msg_box">
        <div class="error_num">
            404
        </div>
        <div class="error_msg">
            <p style="font-size: 3em; font-weight: bold;">
                페이지를 찾을 수 없습니다.
            </p>
            <p style="padding-top: 10px; font-size: 1.5em;">
                페이지가 존재하지 않거나, 사용할 수 없는 페이지입니다.<br>
                입력하신 주소가 정확한지 다시한번 확인해주세요.
            </p>
            <div class="select_btn">
                <button type="button" style="margin-top: 16px" class="btn btn-outline-secondary" onclick="history.back();">이전 페이지</button>
                <button type="button" style="margin-top: 16px" class="btn btn-outline-secondary" onclick="location.href='${pageContext.servletContext.contextPath}/'">메인 페이지</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>

