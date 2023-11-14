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
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/users/signuptype.css">
    <script>
        $(function(){
           $("#personal").on('click',function(){
               if($("#accept").is(":checked")){
                   location.href="${pageContext.servletContext.contextPath}/signup/personal";
               }else{
                   alert("약관에 동의해주세요!");
                   return false;
               }
           });
            $("#biz").on('click',function(){
                if($("#accept").is(":checked")){
                    location.href="${pageContext.servletContext.contextPath}/signup/biz";
                }else{
                    alert("약관에 동의해주세요!");
                    return false;
                }
            });
        });
    </script>
</head>
<body>
<div class="container">
    <main class="container">
        <p class="signupOkTitle">회원가입</p>
        <div class="textbar">Career Canvas는 개인정보보호법 등 관련 법령상의 개인정보 보호 규정을 준수하며 사용자의 개인정보 보호에 최선을 다하고 있습니다.  Career Canvas은(는)  개인정보보호법 제15조 및 같은 법 제22조에 근거하여, 다음과 같이 수집․이용을 위하여 개인정보를 수집․이용하는데 동의를 받고자 합니다.
            <br>1. 개인정보의 수집․이용 목적
            <br>2. 수집하는 개인정보의 항목
            <br>3. 개인정보의 보유 및 이용 기간
            <br>4. 동의거부권 및 동의 거부에 따른 불이익 안내 : Career Canvas는 위와 같이 개인정보를 수집․이용하는 데 대한 동의를 거부할 권리가 있습니다. 그러나 동의를 거부할 경우  Career Canvas에서 제공하는 Portfolio Service을(를) 받을 수 없음을 참고하시기 바랍니다.
        </div>
        <input type="checkbox" id="accept" class="accept">동의합니다.
        <p class="signValue">회원 유형 선택</p>
        <div class="btngroup">
            <input type="button" class="btn personalbtn btn-secondary" id="personal" value="일반회원" >
            <input type="button" class="btn companybtn btn-secondary" id="biz" value="기업회원">
        </div>
    </main>
</div>

</body>
</html>

<%@include file="../header_footer/footer.jspf" %>