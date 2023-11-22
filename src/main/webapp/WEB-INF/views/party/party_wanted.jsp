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
        p {
            margin: 0;
        }

        ul {
            margin: 0;
        }

        body {
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

        /*-------------------------------------------------------------*/
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: auto;
        }

        /* 파티 목록 리스트 */
        .party_list li {
            margin-right: 20px;
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

        /* 파티 목표 & 소개 */
        .party_name {
            margin: 0;
            margin-top: 30px;
            text-align: center;
            font-weight: bold;
            font-size: 2.5em;
            line-height: 100%;
        }

        /* 소개 글*/
        .objective {
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
            border-bottom: 2px solid #ddd;
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
        .member_list {
            overflow: auto;
        }

        .member_list li {
            margin-right: 20px;

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

        /* 메모 */
        .party_memo {
            margin-top: 30px;
        }

        .memo_list {
            width: 1000px;
            margin: 0 auto;
        }

        .memo_list_box {
            margin-top: 20px;
        }

        .postit {
            box-sizing: border-box;
            margin: 25px;
            min-width: 280px;
            max-width: 280px;
            height: 250px;
            padding: 35px 5px 5px 5px;
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

        .memo_item {
            float: left;
        }
    </style>
</head>
<body>
<main class="container">
    <div class="mypartyvalue">
        <input type="button" class="btn btn-outline-secondary partyvaluebutton1" value="파티 모집"
               onclick="changeValue(this)">
        <input type="button" class="btn btn-secondary partyvaluebutton2" value="내 파티" onclick="changeValue(this)">
    </div>
</main>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>
