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
        .container {
            margin: 0 auto;
            border-left: 1px solid #73351F;
            border-right: 1px solid #73351F;
            background: #F2F2F2;
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

        section{
            width: 1000px;
            margin: 0 auto;
        }

        .party_list li{
            margin-right: 20px;
            float: left;
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
    /* ----------------- 파티 멤버 관리 css ----------------  */
        .teamView li{
            float: left;
        }
        .party_name{
            margin: 0;
            margin-top: 20px;
            text-align: center;
            font-weight: bold;
            font-size: 2.5em;
            line-height: 100%;
        }
        .content_title{
            text-align: center;
            font-weight: bold;
            color: darkgrey;
        }
        .edit_category{
            width: 210px;
            margin: 0 auto;
            margin-top: 60px;
            margin-bottom: 20px;
        }
        .edit_content{
            width: 800px;
            margin: 0 auto;
        }
        .member_edit, .join_edit{
            font-weight: bold;
            margin-top: 50px;
        }

        /* 회원 리스트*/
        .member_edit> ul{
            width: 770px;
            height: 180px;
            margin: 0 auto;
            overflow: auto;
            overflow-y: auto;
            overflow-x: hidden;
        }
        .member_edit li {
            margin-left: 30px;
            float: left;
            width: 330px;
            margin-right: 10px;
            margin-bottom: 10px;
            background-color: #e9ecef;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #73351F;
        }
        .member_list{
            display: flex;
            height: 60px;
        }
        .member_list>img{
            width: 60px;
            height: 60px;
            border-radius: 15px;
        }
        .member_list>p {
            padding: 0 10px;
            text-align: center;
            width: 180px;
            font-size: 1.2em;
            height: 60px;
            line-height: 60px;
        }
        .member_del_btn{
            border: none;
            font-weight: bold;
            width: 70px;
            height: 60px;
            line-height: 60px;
            background: none;
        }
        /* 가입 신청 리스트*/
        .join_edit ul{
            height: 350px;
            width: 730px;
            margin: 0 auto;
            overflow: auto;
            overflow-y: auto;
            overflow-x: hidden;
        }
        /* ------ 스크롤 바 -------*/
        .scrollBar::-webkit-scrollbar {
            width: 10px;  /* 스크롤바의 너비 */
        }

        .scrollBar::-webkit-scrollbar-thumb {
            height: 30%; /* 스크롤바의 길이 */
            background: darkgray; /* 스크롤바의 색상 */

            border-radius: 10px;
        }

        .scrollBar::-webkit-scrollbar-track {
            background: none;  /*스크롤바 뒷 배경 색상*/
        }
        /* ------ 스크롤 바 -------*/
        .join_edit li{
            margin-top: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }

        .join_list{
            display: flex;
            margin: 0 auto;
            width: 700px;
        }
        .join_list img{
            width: 80px;
            height: 80px;
            border-radius: 30px;
        }

        .join_list p{
            width: 470px;
            padding-left: 20px;
            height: 40px;
            line-height: 40px;
            margin-bottom: 0px;
        }
        .approve_btn, .refuse_btn{
            border: none;
            background: none;
            font-weight: bold;
            line-height: 80px;
            font-size: 1.2em;
        }
        .container_bottom{
            display: flex;
            background: #A69668;
            height: 10px;
            margin-top: 10px;
        }
        .hr-styleset{
            border: 0;
            border-top: 2.5px dashed #73351F ;
            border-bottom: 1px dashed #D9D9D9;
        }
        .container-head{
            display: flex;
            justify-content: center;
            align-items: center;
            background: #A69668;
            height: 10px;
        }
        hr{
            border-top: 2.5px solid #73351F ;
        }
    </style>
    <script>

        $(function () {


            $(".party_list_btn").click(function () {
                no = ${partyvo.partyid};
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/main?no='+no;
            });


            $(".member_del_btn").click(function () {
                var memberId = $(this).data('id');
                no = ${partyvo.partyid};
                console.log(memberId, no);

                if (confirm("정말로 "+memberId+"님을 제명하시겠습니까?")) {
                    $.ajax({
                       url:"${pageContext.servletContext.contextPath}/party/memberDel",
                       type:"post",
                        data:{
                           no : no,
                           memberId : memberId
                        },success:function (r){
                           console.log(r);
                           location.reload(true);

                        }, error:function (e){
                           console.log(e);
                        }
                    });
                }
            });
            $(".approve_btn").click(function () {
                var memberId = $(this).data('approveid');
                no = ${partyvo.partyid};
                console.log(memberId, no);
                if (confirm(memberId+"님의 가입을 승인하시겠습니까?")) {
                    $.ajax({
                        url:"${pageContext.servletContext.contextPath}/party/memberApprove",
                        type:"post",
                        data:{
                            no : no,
                            memberId : memberId
                        },success:function (r){
                            console.log(r);
                            location.reload(true);
                        }, error:function (e){
                            console.log(e);
                        }
                    });
                }
            });
            $(".refuse_btn").click(function () {
                var memberId = $(this).data('refuseid');
                no = ${partyvo.partyid};
                console.log(memberId, no);
                if (confirm(memberId+"님의 가입을 거절하시겠습니까?")) {
                    $.ajax({
                        url:"${pageContext.servletContext.contextPath}/party/memberRefuse",
                        type:"post",
                        data:{
                            no : no,
                            memberId : memberId
                        },success:function (r){
                            console.log(r);
                            location.reload(true);
                        }, error:function (e){
                            console.log(e);
                        }
                    });
                }
            });

            $(".party_list_btn").click(function () {
                no = $(this).attr('title');
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/main?partyid='+no;
            });
            $('.mainbtn').click(function (){
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/main?partyid=${partyvo.partyid}';
            });
            $("#infoEdit_btn").click(function () {
                no = ${partyvo.partyid};
                window.location.href = '${pageContext.servletContext.contextPath}/party/edit?no='+ no;
            });

            $(".portpoliobtn").click(function () {
                no = ${partyvo.partyid};
                window.location.href = '${pageContext.servletContext.contextPath}/party/portpolio?no='+ no;
            });

        });
    </script>
</head>
<body>
<main class="container" style="margin-top: 100px; border-top: 3px solid #73351F; border-bottom: 2px dashed #73351F; padding: 0px">
    <div class="container-head"></div>
    <div style="padding: 40px 40px 20px 40px">
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
        <div class="choisvalue" style="margin-top: 30px;">
            <input type="button" class="btn btn-outline-secondary mainbtn" value="메인" >
            <input type="button" class="btn btn-outline-secondary chatbtn" value="채팅" onclick="changeClass(this)">
            <input type="button" class="btn btn-secondary partysetbtn" value="파티관리" onclick="changeClass(this)">
            <input type="button" class="btn btn-outline-secondary portpoliobtn" value="포트폴리오" >
        </div>
    </div>
</main>

<article>
    <section class="container" style="padding:0px; border-bottom: 3px solid #73351F;">
        <div style="padding: 20px 20px 40px 20px">
            <p class="party_name" style="height: 50px">${partyvo.partyname}</p>
            <p class="content_title">파티관리</p>
            <div class="edit_category" style="display: flex;">
                <form>
                    <input type="hidden" name="partyid" value="${partyvo.partyid}"/>
                    <button type="button" class="btn btn-outline-secondary" id="infoEdit_btn" style="margin-right: 20px;">정보수정</button>
                </form>
                <button type="button" class="btn btn-secondary">회원관리</button>
            </div>
            <hr style="width: 900px; margin: 0 auto"/>
            <div class="edit_content">
                <div class="member_edit">
                    <span style=" font-size: 1.3em; color: #495057;">파티원 관리</span>
                    <hr style="margin-top: 5px;"/>
                    <ul class="scrollBar">
                        <c:forEach items="${memberList}" var="uvo" >
                            <c:if test="${uvo.userid!=LogId}">
                                <li>
                                    <div class="member_list">
                                        <img src="${pageContext.servletContext.contextPath}/upload${uvo.profileimg}">
                                        <p class="member_name">${uvo.username}</p>
                                        <button class="member_del_btn" data-id="${uvo.userid}">제명 <i class="fa-regular fa-circle-xmark" style="color: #df0707;"></i></button>
                                    </div>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
                <div class="join_edit">
                    <span style=" font-size: 1.3em; color: #495057;">가입신청 목록</span>
                    <hr style="margin-top: 5px;"/>
                    <div>
                        <ul class="scrollBar">
                            <c:forEach items="${waitingList}" var="uvo" >
                            <li>
                                <div class="join_list">
                                    <img src="${pageContext.servletContext.contextPath}/upload${uvo.profileimg}">
                                    <div style="width: 460px;">
                                        <div style="padding-left: 25px;"><a style="font-size: 1.3em;">${uvo.username}</a></div>
                                        <div style="padding-left: 25px;"><!-- 추가로 내용이 들어갈 곳 --></div>
                                    </div>
                                    <button class="approve_btn" data-approveid="${uvo.userid}">승인 <i class="fa-regular fa-circle-check" style="color: #1ce70d;"></i></button>
                                    <button class="refuse_btn" data-refuseid="${uvo.userid}">거절 <i class="fa-regular fa-circle-xmark" style="color: #df0707;"></i></button>
                                </div>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="container_bottom"></div>
    </section>
</article>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>