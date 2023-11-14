<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/translations/ko.js"></script>
    <style>
        .content {
            max-width: 1000px;
            margin: 0 auto;
            margin-top: 70px;
        }

        .ck-editor__editable {
            height: 400px;
        }

        .button {
            display: inline-block;
            margin: 0 10px;
            padding: 5px 10px;
            background-color: #fff;
            color: #000;
            text-decoration: none;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        .button:hover {
            background-color: #fda3b6;
            color: #000;
        }

        #editor {
            width: 100%;
            height: 600px;

        }

        #botContainer {
            display: flex;
            justify-content: space-between;
            height: 30px;
            margin-top: 50px;
        }
    </style>
    <script>
        function toggleButtonColor(button) {
            var buttons = document.querySelectorAll(".button");

            buttons.forEach(function (btn) {
                btn.style.backgroundColor = "#fff";
            });

            button.style.backgroundColor = "#fda3b6";
        }
    </script>
</head>
<body>
<div class="content">
    <h3 style="margin-bottom: 30px">자유게시판 작성</h3> <!-- 이 부분은 세션에 게시판종류 넣어서 처리할 예정 -->
    <form >
        <input type="text"  style="width: 40%" class="form-control" placeholder="제목을 입력해 주세요.">

    <div style="padding: 20px 0">
        <div class="button-container">
            <a href="javascript:void(0);" class="button" onclick="toggleButtonColor(this)">선택안함</a>
            <a href="javascript:void(0);" class="button" onclick="toggleButtonColor(this)">IT/프로그래밍</a>
            <a href="javascript:void(0);" class="button" onclick="toggleButtonColor(this)">디자인</a>
            <a href="javascript:void(0);" class="button" onclick="toggleButtonColor(this)">영상/음향</a>
        </div>
    </div>
    <div id="editor"></div>
    <script>
        ClassicEditor
            .create(document.querySelector('#editor'), {
                language: "ko"

            })
            .catch(error => {
                console.error(error);
            });
    </script>

    <div id="botContainer">
        <input type="text" class="form-control" style="width: 28%" placeholder="#태그는 스페이스바로 구분해 주세요."/>
        <input type="submit" value="글등록"/>
    </div>
    </form>
</div>
</body>
</html>