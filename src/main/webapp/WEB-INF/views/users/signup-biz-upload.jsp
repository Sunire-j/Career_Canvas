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
    <script src="${pageContext.servletContext.contextPath}/js/fileupload.js"></script>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/users/signupOK.css">
    <script src="https://kit.fontawesome.com/12f8d3210e.js" crossorigin="anonymous"></script>
    <script>
        $(function(){
            $('#ex_file').change(function() {
                if ($(this)) {
                    $('.signup').prop('disabled', false);
                }
            });
        });
    </script>
</head>
<body>
<div class="container">
    <main class="container">
        <p class="signupOKcompany">기업 회원가입</p>
        <p class="pstyle1">작성하신 기업명 : ${tempusername}</p>
        <p class="pstyle1">장성하신 사업자등록번호 : ${tempcompanyno}</p>
        <p class="pstyle2">작성하신 기업정보와 사업자등록증 정보가 다를 경우 승인이 반려될 수 있습니다.</p>
        <p class="pstyle2">사업자 등록증 파일은 jpg, png 파일의 형태로 업로드 해주시기 바랍니다.</p>
        <p class="pstyle2">승인까지는 최대 n영업일이 소요됩니다.</p>
        <form method="post" action="${pageContext.servletContext.contextPath}/signup/bizupload" enctype="multipart/form-data">
            <input type="hidden" name="username" id="username" value="${tempusername}"/>
            <input type="hidden" name="companyno" id="companyno" value="${tempcompanyno}"/>
            <div class="img_file" id="previewContainer"></div>
            <div class="file-upload">
                <label for="ex_file"><i class="fa-solid fa-arrow-up-from-bracket"></i> 업로드</label>
                <input type="file" id="ex_file" name="ex_file" accept=".png, .jpg, .jpeg" onchange="handleFileUpload()">
            </div>
            <div class="btngroup">
                <input type="button" class="btn btn-secondary reset" value="이전으로" onclick="history.back()">
                <input type="submit" class="btn btn-primary signup" value="가입신청" disabled>
            </div>
        </form>
    </main>
</div>

</body>
</html>

<%@include file="../header_footer/footer.jspf" %>