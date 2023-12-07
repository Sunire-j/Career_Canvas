<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/6caf283963.js" crossorigin="anonymous"></script>
    <style>
        .title, .deltitle, .company{
            font-size: 1.2em;
            font-weight: bold;
        }

        .delcontent{
            width: 500px;
            height: 150px;
            resize: none;
        }
    </style>
    <script>
        $(function () {
            $("#delFrm").on("submit", function (){
                var subjectid=$("#subjectid").val();
                var reason = $(".delcontent").val();
                $.ajax({
                   url : "${pageContext.servletContext.contextPath}/subject/delOk",
                   type : "post",
                   data:{
                       subjectid : subjectid,
                       reason : reason
                   }, success: function (r){
                       alert("삭제 신청이 완료되었습니다.");
                    }, error:function (e){
                       console.log(e.printStackTrace());
                    }
                });
            });


        });
    </script>
</head>
<body>
<div class="container" style="width: 600px;">
    <form id="delFrm">
        <div style="width: fit-content; margin: 0 auto;">
            <p class="title">과제명 : ${Svo.subjecttitle}</p>
            <input type="hidden" name="subjectid" id="subjectid" value="${Svo.subjectid}">
            <p class="deltitle">삭제 사유</p>
            <textarea class="delcontent" name="reason"  placeholder="삭제 사유를 입력해주세요."></textarea>
            <br/>
            <div style="width: fit-content; margin: 0 auto;">
                <button type="submit" class="btn btn-secondary del_btn">삭제 신청</button>
            </div>
        </div>
    </form>
</div>

</body>
</html>