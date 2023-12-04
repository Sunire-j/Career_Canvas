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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"
            integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"
            integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <style>
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        body {
            width: 1000px;
            margin: 0 auto;
            height: 1200px;
        }

        .chat {
            width: 900px;
            margin: 0 auto;
        }

        .party_name {
            margin: 0;
            margin-top: 20px;
            text-align: center;
            font-weight: bold;
            font-size: 2.5em;
            line-height: 100%;
        }


        /* 멤버 리스트 */
        .salutation_name {
            margin-top: 60px;
            height: 40px;
            width: 130px;
            margin-bottom: 20px;
            border-bottom: 2px solid #ddd;
            font-size: 1.5em;
            font-weight: 700;
        }

        .member_list {
            overflow: auto;
            margin-left: 20px;

        }

        .member_list li {
            margin-right: 20px;
            float: left;
        }

        .member_img {
            width: 70px;
            height: 70px;
            border-radius: 20px;
        }

        .member_name {
            text-align: center;
            font-size: 15px;
            font-weight: bold;
        }

        /* 채팅 */
        .chat_list {
            width: 880px;
            height: 700px;
            overflow: auto;
            margin: 0 auto;
            overflow-y: scroll;
        }

        .chat_list li {
            width: 840px;
            margin-left: 20px;
            margin-top: 15px;
        }

        p {
            margin-bottom: 0;
        }

        .msg_content, .other_content {
            padding: 10px;
            background-color: #ddd;
            border-radius: 10px;
            min-width: 100px;
            max-width: 350px;
            word-break: break-all;
        }

        .msg_date {
            padding-right: 10px;
            float: right;
        }

        .other_date {
            padding-left: 10px;
        }

        .otherMsg > img {
            width: 70px;
            height: 70px;
            border-radius: 30px;
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .otherMsg, .myMsg {
            display: flex;
        }

        .otherMsg {
            float: left;
        }

        .myMsg {
            justify-content: flex-end;
        }

        .chat_container {
            width: 880px;
            height: 760px;
            background-color: #e9ecef;
            margin-top: 50px;
        }

        /* 채팅 스크롤바*/
        /* 아래의 모든 코드는 영역::코드로 사용 */
        .scrollBar::-webkit-scrollbar {
            width: 10px; /* 스크롤바의 너비 */
        }

        .scrollBar::-webkit-scrollbar-thumb {
            height: 30%; /* 스크롤바의 길이 */
            background: darkgray; /* 스크롤바의 색상 */

            border-radius: 10px;
        }

        .scrollBar::-webkit-scrollbar-track {
            background: none; /*스크롤바 뒷 배경 색상*/
        }

        .chat_name {
            height: 50px;
            line-height: 50px;
            text-align: center;
            color: darkgray;
            font-size: 1.5em;
            font-weight: bold;
            margin: 0 auto;
            border-bottom: 1px solid darkgray;
            width: 600px;
            margin-bottom: 10px;
        }

        .comment_write {
            width: 880px;
            margin: 0;
            display: flex;
            padding-bottom: 20px;
        }

        .comment_content {
            border: 1px solid #ddd;
            width: 90%;
            min-height: 100px;
            padding: 10px;
        }

        .comment_write_ok {
            width: 10%;
        }

        /* 파티 목록 리스트 */
        .party_list li {
            margin-right: 20px;
            float: left;
        }

        .member_img {
            width: 70px;
            height: 70px;
            border-radius: 20px;
        }

        .party_list_name {
            text-align: center;
            font-size: 15px;
            font-weight: bold;
        }

        .new_party_btn {
            border: none;
            background: none;
        }

        section {
            width: 1000px;
            margin: 0 auto;
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: auto;
        }

        p {
            margin: 0;
        }

        ul {
            margin: 0;
        }

        .container {
            width: 1200px;
        }

        .mypartyvalue {
            width: 100%;
            height: 100px;
            display: flex;
            text-align: center;
            justify-content: center;
            margin: 0 auto;
            margin-top: 10px;
        }

        .mypartylist {
            width: 150px;
        }

        .partylisttitle {
            font-size: 18px;
            margin-bottom: -10px;
        }

        .partyvaluebutton1, .partyvaluebutton2 {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            width: 110px;
            height: 40px;
            margin-right: 10px;
        }

        .choisvalue {
            margin: 0 auto;
            width: fit-content;
        }
    </style>
    <script>
        $(function () {

            let socket = null;			// socket 객체
            let stompClient = null;		// socket 객체를 이용하여 stomp생성한 후 메시지 주고 받는다.
            let partyid = ${no};

            socket = new SockJS("${pageContext.request.contextPath}/partychat");

            // socket객체를 이용하여 stomp생성
            stompClient = Stomp.over(socket);

            // stompClient의 메소드를 이용하여 서버와 통신한다
            stompClient.connect({}, function (frame) {
                console.log('frame->', frame);
                console.log('------connected-------');

                var target = $(".chat_list");
                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/myteam/getChat",
                    data: {
                        partyid: partyid
                    },
                    type: 'post',
                    success: function (result) {
                        console.log(result);
                        result.map(function (item, index) {
                            if (item.user_userid == "${LogId}") {//보낸거
                                console.log("동일함");
                                var tag = `
                       <li class="myMsg">
                           <div class="myMsg_content">
                               <p class="msg_content">` + item.partychatcontent + `</p>
                               <p class="msg_date">` + item.date + `</p>
                           </div>
                       </li>`;
                                $(".chat_list").append(tag);
                            } else {//받은거
                                console.log("다름");
                                var tag = `
                       <li class="otherMsg">
                <img src="${pageContext.servletContext.contextPath}/upload` + item.profileimg + `"/>
                <div class="other_Msg_content">
                    <p style="margin-left: 10px; font-weight: bold;">` + item.username + `</p>
                    <p class="other_content">` + item.partychatcontent + `</p>
                </div>
            </li>`;
                                $(".chat_list").append(tag);
                            }
                        });
                        $('.chat_list').scrollTop($('.chat_list')[0].scrollHeight);
                    },
                    error: function (error) {
                        console.log(error.responseText);
                    }
                });

                // 문자열을 JSON으로 바꾸기 : JSON.parse()
                // JSON 데이터를 문자열로 바꾸기 : JSON.stringify() 	"{\"from\" : \"aaa\"}

                //지금은 연결 후 접속메세지를 보내주고있지만, 지금은 db에서 정보를 받아오고 뿌려준 뒤 스크롤을 내려줘야함
                stompClient.subscribe('/topic/' + partyid, function (msg) {
                    console.log(JSON.parse(msg.body));
                    var message = JSON.parse(msg.body);
                    if (message.user_userid == "${LogId}") {
                        console.log("동일함");
                        var tag = `
                       <li class="myMsg">
                           <div class="myMsg_content">
                               <p class="msg_content">` + message.partychatcontent + `</p>
                               <p class="msg_date">` + message.date + `</p>
                           </div>
                       </li>`;
                        $(".chat_list").append(tag);
                        $('.chat_list').scrollTop($('.chat_list')[0].scrollHeight);
                    } else {
                        console.log("다름");
                        var tag = `
                       <li class="otherMsg">
                <img src="${pageContext.servletContext.contextPath}/upload` + message.profileimg + `"/>
                <div class="other_Msg_content">
                    <p style="margin-left: 10px; font-weight: bold;">` + message.username + `</p>
                    <p class="other_content">` + message.partychatcontent + `</p>
                </div>
            </li>`;
                        $(".chat_list").append(tag);
                        $('.chat_list').scrollTop($('.chat_list')[0].scrollHeight);
                    }
                });
            })

            $(".comment_write_ok").on('click', function () {
                sendMessage();
            });

            $(".comment_content").on('keydown', function(e){
                if(e.keyCode == 13){
                    e.preventDefault();
                    sendMessage();
                }
            });

            function sendMessage(){
                let str = {
                    party_partyid: partyid,
                    user_userid: "${LogId}",
                    partychatcontent: $(".comment_content").val()
                }
                stompClient.send('/app/chatting/' + partyid, {}, JSON.stringify(str));
                $(".comment_content").val("");
            }

            $('.mainbtn').click(function () {
                window.location.href = '${pageContext.servletContext.contextPath}/myteam/main';
            });
        });

    </script>
</head>
<body>
<main class="container">
    <div class="mypartyvalue">
        <input type="button" class="btn btn-outline-secondary partyvaluebutton1" value="파티 모집"
               onclick="location.href='${pageContext.servletContext.contextPath}/party/wanted'">
        <input type="button" class="btn btn-secondary partyvaluebutton2" value="내 파티"
               onclick="location.href='${pageContext.servletContext.contextPath}/myteam/main'">
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
            <button class="new_party_btn"
                    onclick="location.href='${pageContext.servletContext.contextPath}/party/create'">
                <i class="fa-regular fa-square-plus fa-4x"></i><br/>
                <span style="font-weight: bold;">파티생성</span>
            </button>
        </li>
    </ul>
    <div class="choisvalue" style="margin-top: 30px;">
        <input type="button" class="btn btn-outline-secondary mainbtn" value="메인">
        <input type="button" class="btn btn-secondary chatbtn" value="채팅">
        <input type="button" class="btn btn-outline-secondary partysetbtn" value="파티관리">
    </div>
    <hr>
</main>
<p class="party_name">Career Canvas</p>
<div class="chat">
    <div class="chat_container">
        <div class="chat_name">
            <span>전체</span>
        </div>
        <ul class="chat_list scrollBar">
        </ul>
    </div>
    <div class="comment_write">
        <textarea class="comment_content" placeholder="내용을 입력하세요." style="resize: none;"></textarea>
        <button type="button" class="btn btn-secondary comment_write_ok"> 보내기</button>
    </div>
</div>
</body>
</html>