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
        .new_party_btn{
            border: none;
            background: none;
        }

        section{
            width: 1000px;
            margin: 0 auto;
        }

        /* 파티 목표 & 소개 */
        .party_name{
            margin: 0;
            text-align: center;
            font-weight: bold;
            font-size: 2.5em;
            line-height: 100%;
        }

        /* 소개 글*/
        .objective{
            margin-top: 40px;
            height: 120px;

        }

        .salutation {
            margin-top: 30px;
            height: 150px;
        }

        .salutation_name {
            height: 40px;
            width: 150px;
            border-bottom: 2px solid #73351F;
            font-size: 1.5em;
            font-weight: 700;
        }

        .salutation_content {
            margin-top: 10px;
            margin-left: 10px;
            font-size: 1.2em;
            font-weight: bold;
            color: grey;
        }
        /* 파티원 리스트 */
        .member_list{
            overflow: auto;
        }
        .member_list li{
            width: 70px;
            margin-right: 20px;
            float: left;
        }
        .member_img{
            width: 70px;
            height: 70px;
            border-radius: 20px;
        }
        .member_name{
            text-align: center;
            font-size: 15px;
            font-weight: bold;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        /* 메모 */
        .party_memo{
            margin-top: 30px;
        }
        .memo_list{
            width: 1000px;
            margin: 0 auto;
        }
        .memo_list_box{
            margin-top: 20px;
        }
        .postit{
            box-sizing: border-box;
            margin: 25px;
            min-width: 280px;
            max-width: 280px;
            height: 250px;
            padding: 0 5px 5px 5px;
            border: 1px solid #E8E8E8;
            font-size: 17px;
            text-align: center;
            border-bottom-right-radius: 60px 5px;
            position: relative;
            display: flex;
            flex-direction: column;
        }

        .postit:after {
            content: "";
            position: absolute;
            z-index: -1;
            right: -0px;
            bottom: 20px;
            width: 200px;
            height: 25px;
            background: rgba(0, 0, 0, 0.2);
            box-shadow: 2px 15px 5px rgba(0, 0, 0, 0.40);
            transform: matrix(-1, -0.1, 0, 1, 0, 0);
        }

        .yellow {
            background: linear-gradient(135deg, #ffff88 81%, #ffff88 82%, #ffff88 82%, #ffffc6 100%);
            margin: 15px 20px;
        }

        .memo_content {
            min-height: 160px
        }
        .memo_item{
            float: left;
        }

        /* 메모 글 작성 버튼 */
        .memoWrite_btn{
            background-color: transparent;
            border: none;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-right: 10px;
        }
        .memoWrite_btn>span{
            font-size: 15px;
            font-weight: bold;
        }
        .salutation_memo{
            height: 40px;
            width: 100%;
            border-bottom: 2px solid #73351F;
            font-size: 1.5em;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        #memoWriteForm{
            width: 268px;
            height: 160px;
            max-height: 160px;
            resize: none;
            background-color: #ffff88;
            border: none;
        }
        .memo_write_ok_btn, .memo_delete_btn{
            background-color: transparent;
            border: none;
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

        function loadMemo(no){
            $("memo_list").empty();
            $.ajax({
                url: "${pageContext.servletContext.contextPath}/memoListView",
                type: "post",
                data: {
                    no: no
                }, success: function (result) {
                    var memo = "";
                    $(result).each(function (i, r) {
                        memo += "<li class='memo_item'><div class='memo'><div class='postit yellow'>";
                        if(r.user_userid=="${LogId}"||${myteamView.user_userid==LogId}){
                            memo += "<button class='memo_delete_btn' title='"+r.partymemo+"' id='memo_delete_btn'><i class='fa-solid fa-minus' style='float: right; padding: 5px'></i></button>";
                        }else{
                            memo += "<div style='height:27px;'></div>";
                        }
                        memo += "<p class='memo_content'>" + r.partymemocontent + "</p>";
                        memo += "<div className='memo_writer'>작성자 : " + r.username + "</div>";
                        memo += "<p>" + r.datetime + "</p></div></div></li>";
                    });
                    $("#memo_list").html(memo);
                }
            });
        }
        $(function () {
            var no=${tempno};
            loadMemo(no);
            $(".party_list_btn").click(function () {
                no = $(this).attr('title');
                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/myteamView",
                    type: "post",
                    data: {
                        no: no
                    },
                    success: function (r) {
                        $("#party_name").html(r.partyname)
                        $("#salutation_content").html(r.partygoal)
                        $("#comment_content").html(r.partycomment)

                        //$(".teamView").append(partyInfo);
                    }
                });
                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/memberList",
                    type: "post",
                    data: {
                        no: no
                    },
                    success: function (r) {
                        var member = "";
                        $(r).each(function (i, result) {
                            member += "<li> <img src='${pageContext.servletContext.contextPath}/upload" + result.profileimg + "' class='member_img'>";
                            member += "<div class='member_name'>" + result.username+ "</div></li>";
                        });
                        $("#member_list").html(member);
                    }
                });
                loadMemo(no);
            });
            $(".memoWrite_btn").click(function () {
                var temp = document.getElementById("memo_list");
                var memonum=temp.childElementCount;
                if(memonum>=6){
                    alert("메모는 6개까지만 작성가능합니다.\n메모 삭제 후 다시 시도해주세요.");
                    return false;
                }
                var memoWriteForm = $(
                    "<li class='memo_item'><div class='memo'><div class='postit yellow'><form id='frm'>"+
                    "<button type='submit' class='memo_write_ok_btn'  id='memo_write_ok_btn' style='float: right;'><i class='fa-solid fa-plus' style='float: right; padding: 5px'></i></button>"+
                    "<textarea class='memo_content' id='memoWriteForm' maxlength='80' placeholder='80자 미만의 내용을 입력하세요.'></textarea>"+
                    "</form></div></div></li>"
                )
                $("#memo_list").prepend(memoWriteForm);
            });

            $('#memo_list').on('submit','#frm', function(e) {
                event.preventDefault();
                var content = $("#memoWriteForm").val();
                if($("#memoWriteForm").val()=="") {
                    alert('글 내용을 입력해 주세요.');
                    return false;
                }

                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/memoWriteOK",
                    type: "POST",
                    data: {
                        no: no,
                        content: content
                    }, success: function (result) {
                        loadMemo(no);
                        event.preventDefault();
                    }
                });
            });
            $('#memo_list').on('click', '#memo_delete_btn', function (){
                var target = $(this).attr('title');
                if(confirm("메모를 삭제하시겠습니까?")){
                    $.ajax({
                        url:"${pageContext.servletContext.contextPath}/memoDeleteOk",
                        type:"POST",
                        data:{
                            target: target
                        },success: function (result) {
                            loadMemo(no);
                            event.preventDefault();
                        }
                    });
                }
            });

            $('.partysetbtn').click(function (){
                window.location.href = '${pageContext.servletContext.contextPath}/party/edit?no='+no;
                $('.partysetbtn').removeClass('btn-outline-secondary').addClass('btn-secondary');
                $('.partysetbtn').prop('disable', true);
            });

            $('.chatbtn').click(function (){
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/chat?no='+no;
                $('.chatbtn').removeClass('btn-outline-secondary').addClass('btn-secondary');
                $('.chatbtn').prop('disable', true);
            });

            $('.portpoliobtn').click(function (){
                window.location.href = '${pageContext.servletContext.contextPath}/party/portpolio?no='+no;
                $('.portpoliobtn').removeClass('btn-outline-secondary').addClass('btn-secondary');
                $('.portpoliobtn').prop('disable', true);
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
        <div class="choisvalue" style="margin-top: 30px;padding-bottom: 20px">
            <input type="button" class="btn btn-secondary mainbtn" value="메인" onclick="changeClass(this)">
            <input type="button" class="btn btn-outline-secondary chatbtn" value="채팅" onclick="changeClass(this)">
            <input type="button" class="btn btn-outline-secondary partysetbtn" value="파티관리" >
            <input type="button" class="btn btn-outline-secondary portpoliobtn" value="포트폴리오" onclick="changeClass(this)">
        </div>
    </div>
</main>

<article>
    <section class="container" style="padding: 0px; border-bottom: 3px solid #73351F;">
        <div style="padding: 20px 40px 40px 40px">
            <p class="party_name" id="party_name">${myteamView.partyname}</p>

            <div class="objective">
                <div class="salutation_name">
                    파티 목표
                </div>
                <div class="salutation_content" id="salutation_content">
                    ${myteamView.partygoal}
                </div>
            </div>
            <div class="salutation">
                <div class="salutation_name">
                    파티 소개
                </div>
                <div class="salutation_content" id="comment_content">
                    ${myteamView.partycomment}
                </div>
            </div>
            <div class="member_list_box">
                <div class="salutation_name">
                    파티원
                </div>
                <div class="salutation_content">
                    <ul class="member_list" id="member_list">
                        <c:forEach var="uvo" items="${memberList}">
                            <li>
                                <a href="${pageContext.servletContext.contextPath}/profile/portfolio?uid=${uvo.userid}">
                                    <img src="${pageContext.servletContext.contextPath}/upload${uvo.profileimg}" class="member_img">
                                    <div class="member_name" title="${uvo.username}">
                                            ${uvo.username}
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="party_memo">
                <div class="salutation_memo">
                    <div>파티 메모</div>
                    <button class="memoWrite_btn"><span>메모작성&nbsp</span><i class="fa-regular fa-pen-to-square"></i></button>
                </div>
                <div class="memo_list_box">
                    <ul class="memo_list" id="memo_list">
                        <c:forEach var="memo" items="${memoListView}">
                            <li class="memo_item">
                                <div class="memo">
                                    <div class="postit yellow">
                                        <c:if test="${LogId}==${memo.user_userid}">
                                            <button class='memo_delete_btn'><i class='fa-solid fa-minus' style='float: right; padding: 5px'></i></button>
                                        </c:if>
                                        <c:if test="${LogId}!=${memo.user_userid}">
                                            <div style='height:27px;'></div>
                                        </c:if>
                                        <p class="memo_content">${memo.partymemocontent}</p>
                                        <div class="memo_writer">작성자 : ${memo.username}</div>
                                        <p>${memo.datetime}</p>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>

                </div>
            </div>
        </div>
        <div class="container_bottom"></div>
    </section>
</article>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>
