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
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/super-build/ckeditor.js"></script>
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
            height: 38px;
            margin-top: 50px;
        }

        input[type='radio'] {
            display: none;
        }

    </style>
    <script>
        $(function(){

            let editor;
            CKEDITOR.ClassicEditor.create(document.getElementById("editor"), {
                    toolbar: {
                        items: [
                            'bold', 'italic', '|',
                            'fontSize', 'fontColor', 'fontBackgroundColor', 'highlight', '|',
                            'alignment', '|',
                            'insertImage', 'mediaEmbed', '|',
                            'horizontalLine','|',
                        ],
                        shouldNotGroupWhenFull: true
                    },
                    list: {
                        properties: {
                            styles: true,
                            startIndex: true,
                            reversed: true
                        }
                    },
                    placeholder: '내용을 입력해주세요.',
                    fontFamily: {
                        options: [
                            'default',
                            'Arial, Helvetica, sans-serif',
                            'Courier New, Courier, monospace',
                            'Georgia, serif',
                            'Lucida Sans Unicode, Lucida Grande, sans-serif',
                            'Tahoma, Geneva, sans-serif',
                            'Times New Roman, Times, serif',
                            'Trebuchet MS, Helvetica, sans-serif',
                            'Verdana, Geneva, sans-serif'
                        ],
                        supportAllValues: true
                    },
                    fontSize: {
                        options: [10, 12, 14, 'default', 18, 20, 22],
                        supportAllValues: true
                    },
                    htmlSupport: {
                        allow: [
                            {
                                name: /.*/,
                                attributes: true,
                                classes: true,
                                styles: true
                            }
                        ]
                    },
                    link: {
                        decorators: {
                            addTargetToExternalLinks: true,
                            defaultProtocol: 'https://',
                            toggleDownloadable: {
                                mode: 'manual',
                                label: 'Downloadable',
                                attributes: {
                                    download: 'file'
                                }
                            }
                        }
                    },
                    removePlugins: [
                        'CKBox',
                        'CKFinder',
                        'EasyImage',
                        'RealTimeCollaborativeComments',
                        'RealTimeCollaborativeTrackChanges',
                        'RealTimeCollaborativeRevisionHistory',
                        'PresenceList',
                        'Comments',
                        'TrackChanges',
                        'TrackChangesData',
                        'RevisionHistory',
                        'Pagination',
                        'WProofreader',
                        'MathType',
                        'SlashCommand',
                        'Template',
                        'DocumentOutline',
                        'FormatPainter',
                        'TableOfContents',
                        'PasteFromOfficeEnhanced'
                    ]
                }
            ).then(neweditor => {
                editor=neweditor;
                editor.model.document.on('change:data',()=>{
                    document.querySelector('#wantedcontent').value=editor.getData();
                });
            })
                .catch(err => {
                    console.error(err.stack);
                });
            //

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

            $('form').on('submit', function(e) {
                var editorContent = editor.getData();
                if(!editorContent) {
                    e.preventDefault();
                    alert('글 내용을 입력해 주세요.');
                    return false;
                }
                if($('#title').hasClass('is-invalid')){
                    e.preventDefault();
                    alert("제목이 정규직에 어긋납니다.");
                    return false;
                }
            });
        });
    </script>
</head>
<body>
<div class="content">
    <h3 style="margin-bottom: 30px">파티홍보 게시판 작성</h3>
    <form method="post" action="${pageContext.servletContext.contextPath}/party/wanted/writeOk" class="needs-validation writeform" novalidate>
        <input type="hidden" id="wantedcontent" name="wantedcontent">
        <input type="text" style="width: 40%" class="form-control" name="wantedtitle" id="title" placeholder="제목을 입력해 주세요." required maxlength="30">
        <div class="invalid-feedback">
            제목을 입력해 주세요. (30자 이내)
        </div>
    <div style="padding: 20px 0">
        <div class="button-container">
            <c:forEach var="pvo" items="${pVO}" varStatus="status">
                <label class="btn   ${status.index == 0 ? 'btn-warning' : 'btn-outline-warning'}">
                    <input type="radio" name="party_partyid" value="${pvo.partyid}" ${status.index == 0 ? 'checked' : ''}>
                    <span>${pvo.partyname}</span>
                </label>
            </c:forEach>

        </div>
    </div>
    <div id="editor"></div>

    <div id="botContainer">
        <div style="width: 50%" class="botContainer2">
        </div>
        <input type="submit"  class="btn btn-primary submitbtn" value="글등록" />
    </div>
    </form>
</div>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>