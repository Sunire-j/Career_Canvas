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
    <script src="https://kit.fontawesome.com/6caf283963.js" crossorigin="anonymous"></script>
    <style>
        @media (min-width: 1200px) {
            .container{
                max-width: 1200px;
            }
        }
        .container {
            margin: 0 auto;
            margin-top: 50px;
            border-top: 3px solid #73351F;
            border-bottom: 2px dashed #73351F;
            border-left: 1px solid #73351F;
            border-right: 1px solid #73351F;
            background: #F2F2F2;
        }
        .teamView{
            width: 1200px;
            margin: 0 auto;
            border-bottom: 3px solid #73351F;
            border-left: 1px solid #73351F;
            border-right: 1px solid #73351F;
            background: #F2F2F2;
            padding: 40px;
        }
        p{
            margin: 0;
        }
        ul{
            margin: 0;
        }
        body{
            margin: 0;
        }
        .container{
            width: 1200px;
        }
        .mypartyvalue{
            width: 100%;
            height: 100px;
            display: flex;
            text-align: center;
            justify-content: center;
            margin: 0 auto;
            margin-top: 10px;
        }
        .mypartylist{
            width: 150px;
        }
        .partylisttitle{
            font-size: 18px;
            margin-bottom: -10px;
        }
        .partyvaluebutton1,.partyvaluebutton2
        {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            width: 110px;
            height: 40px;
            margin-right: 10px;
        }
        .choisvalue{
            margin: 0 auto;
            width: fit-content;
        }
        /*-------------------------------------------------------------*/
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: auto;
        }

        li {
            float: left;
        }

        /* 파티 목록 리스트 */
        .party_list li{
            margin-right: 20px;
        }
        .member_img{
            width: 70px;
            height: 70px;
            border-radius: 20px;
        }
        .party_list_name{
            text-align: center;
            font-size: 15px;
            font-weight: bold;
        }
        .new_party_btn{
            border: none;
            background: none;
        }

        /* 포트폴리오 목록 크기 */
        .portpolio_list_box{
            width: 1100px;
            margin: 0 auto;
            margin-top: 30px;
        }
        .portpolio_list_box ul{
            width: 1100px;
            margin: 0 auto;
        }
        .portpolio_list_box li{
            width: 240px;
            float: left;
            margin: 0 15px;
            margin-top: 15px;
        }
        /* 포트폴리오 목록 */
        .portpolio_content{
            width: 100%;
        }
        .portpolio_img{
            width: 100%;
            height: 240px;
            border-radius: 20px;
        }
        .portpolio_name{
            width: 100%;
            height : 40px;
            font-weight: bold;
            line-height: 40px;
            text-align: center;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            padding: 0 15px;
        }
    </style>
    <script>
        $(function (){
            $(".party_list_btn").click(function () {
                no = $(this).attr('title');
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/main?partyid='+no;
            });
        });
    </script>
</head>
<body>
<main class="container">
    <div class="mypartyvalue">
        <input type="button" class="btn btn-outline-secondary partyvaluebutton1" value="파티 모집" onclick="location.href='${pageContext.servletContext.contextPath}/party/wanted'">
        <input type="button" class="btn btn-secondary partyvaluebutton2" value="내 파티" onclick="location.href='${pageContext.servletContext.contextPath}/myteam/main'">
    </div>
    <div class="mypartylist">
        <p class="partylisttitle" style="font-weight: bold; font-size: 1.3em;">내 파티 목록</p>
        <hr>
    </div>
    <ul class="party_list">
        <c:forEach items="${pvo}" var="p">
            <li title="${p.partyid}" class="party_list_btn">
                <img src="${pageContext.servletContext.contextPath}/upload${p.partyimage}" class="member_img">
                <div class="party_list_name">
                    ${p.partyname}
                </div>
            </li>
        </c:forEach>
        <li style="float: left">
            <button class="new_party_btn" onclick="location.href='${pageContext.servletContext.contextPath}/party/create'">
                <i class="fa-regular fa-square-plus fa-4x"></i><br/>
                <span style="font-weight: bold;">파티생성</span>
            </button>
        </li>
    </ul>
    <div class="choisvalue" style="margin-top: 30px;padding-bottom: 20px">
        <input type="button" class="btn btn-outline-secondary mainbtn" value="메인"
               onclick="location.href='${pageContext.servletContext.contextPath}/myteam/main?partyid=${no}'">
        <input type="button" class="btn btn-outline-secondary chatbtn" value="채팅"
               onclick="location.href='${pageContext.servletContext.contextPath}/myteam/chat?no=${no}'">
        <input type="button" class="btn btn-outline-secondary partysetbtn" value="파티관리"
               onclick="location.href='${pageContext.servletContext.contextPath}/party/edit?no=${no}'">
        <input type="button" class="btn btn-secondary portpoliobtn" value="포트폴리오" onclick="changeClass(this)">
    </div>
</main>
<article>
    <section>
        <div class="portpolio_list_box">
            <ul>
                <c:forEach items="${Povo}" var="P">
                    <li>
                        <div class="portpolio_content">
                            <input type="hidden" value="${P.portfolioid}">
                            <img src="${pageContext.servletContext.contextPath}/upload${P.imgsrc}" class="portpolio_img"/>
                            <p class="portpolio_name">${P.portfoliotitle}</p>
                        </div>
                    </li>
                </c:forEach>
            </ul>

        </div>
        <ul class="pagination justify-content-center">
            <c:if test="${Pagingvo.page>1}">
                <li class="page-item"><a class="page-link" href="?no=${no}&page=${Pagingvo.page - 1}"><</a></li>
            </c:if>
            <c:forEach var="i" begin="${Pagingvo.startPage}" end="${Pagingvo.startPage + Pagingvo.onePageCount - 1}">
                <c:if test="${i <= Pagingvo.totalPage}">
                    <c:choose>
                        <c:when test="${i != Pagingvo.page}">
                            <li class="page-item"><a class="page-link" href='?no=${no}&page=${i}'>${i}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link active" href="">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:forEach>
            <c:if test="${Pagingvo.page < Pagingvo.totalPage}">
                <li class="page-item"><a class="page-link" href="?no=${no}&page=${Pagingvo.page + 1}">></a></li>
            </c:if>
        </ul>
        <div style="width: fit-content; margin: 0 auto; margin-top: 20px;">
            <input type="button" class="btn btn-outline-secondary partysetbtn" value="포트폴리오 작성하기"
                   onclick="location.href='${pageContext.servletContext.contextPath}/party/pofolWrite?no=${no}'">
        </div>
    </section>
</article>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>