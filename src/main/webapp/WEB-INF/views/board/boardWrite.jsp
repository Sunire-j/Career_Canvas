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

        input[type='radio'] {
            display: none;
        }

    </style>
    <script>
        $(function(){

            let editor;

            ClassicEditor
                .create(document.querySelector('#editor'), {
                    language: "ko"
                })
                .then(newEditor => {
                    editor = newEditor;
                    editor.model.document.on('change:data', () => {
                        document.querySelector('#content').value = editor.getData();
                    });
                })
                .catch(error => {
                    console.error(error);
                });

            $('.button-container input[type="radio"]').change(function(){
                $('.button-container label').removeClass('btn-warning').addClass('btn-outline-warning');
                if($(this).is(':checked')){
                    $(this).parent().removeClass('btn-outline-warning').addClass('btn-warning');
                }
            });
            $('#title').on('input blur', function() {
                var title = $(this).val();
                if(title.length > 30) {
                    $(this).val(title.substring(0, 30));
                }
                if(title.length==0){
                    $(this).addClass('is-invalid').removeClass('is-valid');
                }else{
                    $(this).addClass('is-valid').removeClass('is-invalid');
                }
            });

            $("#hashtag").on('input blur',function(){
                if(this.checkValidity()){
                    $(this).siblings('[data-feedback="patternMismatch"]').hide();
                    $(this).removeClass('is-invalid').addClass('is-valid');
                }else{
                    $(this).removeClass('is-valid').addClass('is-invalid');
                    $(this).siblings('[data-feedback="patternMismatch"]').show();

                }
            });
            $('form').on('submit', function(e) {
                var editorContent = editor.getData();
                if(!editorContent) {
                    e.preventDefault();
                    alert('글 내용을 입력해 주세요.');
                }

            });
        });
    </script>
</head>
<body>
<div class="content">
    <h3 style="margin-bottom: 30px">자유게시판 작성</h3> <!-- 이 부분은 세션에 게시판종류 넣어서 처리할 예정 -->
    <form method="post" action="${pageContext.servletContext.contextPath}/board/writeOk" class="needs-validation" novalidate>
        <input type="hidden" id="content" name="postcontent">
        <input type="hidden" name="boardcategory" value="0"> <!-- 게시판 종류(0,1,2)등으로 처리 예정 -->
        <input type="text" style="width: 40%" class="form-control" name="posttitle" id="title" placeholder="제목을 입력해 주세요." required maxlength="30">
        <div class="invalid-feedback">
            제목을 입력해 주세요. (30자 이내)
        </div>
    <div style="padding: 20px 0">
        <div class="button-container">
            <label class="btn btn-outline-warning">
                <input type="radio" name="category" value="0" checked>
                <span>선택안함</span>
            </label>
            <label class="btn btn-outline-warning">
                <input type="radio" name="category" value="1">
                <span>IT/프로그래밍</span>
            </label>
            <label class="btn btn-outline-warning">
                <input type="radio" name="category" value="2">
                <span>디자인</span>
            </label>
            <label class="btn btn-outline-warning">
                <input type="radio" name="category" value="3">
                <span>영상음향</span>
            </label>
        </div>
    </div>
    <div id="editor"></div>

    <div id="botContainer">
        <div style="width: 50%" class="botContainer2">
        <input type="text" class="form-control" name="hashtag" id="hashtag" pattern="(#[\w가-힣]+ )*(#[\w가-힣]+ )?#[\w가-힣]+" placeholder="#태그는 공백으로 구분해 주세요. (예 : #샤롯데 #오페라의유령)"/>
        <div class="invalid-feedback" data-feedback="patternMismatch">해쉬태그 형식에 맞지 않습니다.
        </div>
        </div>
        <input type="submit" value="글등록"/>
    </div>
    </form>
</div>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>