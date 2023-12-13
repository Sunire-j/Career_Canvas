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
            width: 1200px;
            margin: 0 auto;
            margin-top: 70px;
            background: #F2F2F2;
            border-width: 3px 1px 3px 1px;
            border-color: #73351F;
            border-style: groove;
        }
        .content-header{
            height: 100px;
            width: 100%;
            background: #A69668;
            border-bottom: 2px solid #73351F;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .ck-editor__editable {
            height: 400px;
        }
        h3{

            font-size: 40px;
            font-weight: bold;
        }

        #editor {
            width: 100%;
            height: 600px;

        }

        #botContainer {
            display: flex;
            justify-content: space-between;
            height: 38px;
            margin-top: 30px;
        }

        input[type='radio'] {
            display: none;
        }

        .container_bottom{
            display: flex;
            background: #A69668;
            height: 10px;
            margin-top: 10px;
        }

        /*  파티, 멤버 선택   */
        .teamList, .memberList{
            display : flex;
            margin-top : 10px;
            margin-left : 40px;
        }

        .titlename{
            font-size: 24px;
            font-weight: bold;
            border-bottom: 1px solid #bbb;
            padding-bottom: 10px;
            margin: 0 10px;
            padding-left: 16px;
        }
        input[name="member"] {
            display:none;
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
                    document.querySelector('#content').value=editor.getData();
                });
            })
                .catch(err => {
                    console.error(err.stack);
                });
            //

            $('.memberList').on('change', 'input[name="member"]', function() {
                if ($(this).is(':checked')) {
                    $(this).closest('.memberlisttemp').find('label').removeClass('btn-outline-secondary').addClass('btn-secondary');
                } else {
                    $(this).closest('.memberlisttemp').find('label').removeClass('btn-secondary').addClass('btn-outline-secondary');
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

                var TeamRadios = $('input[name="isteam"][value="0"]:checked');
                var SoloRadios = $('input[name="isteam"][value="1"]:checked');
                if(TeamRadios.length==0&&SoloRadios.length==0){
                    e.preventDefault();
                    alert('개인&팀 유형을 선택하세요');
                    return false;
                }
                if(SoloRadios.length==1){
                    return true;
                }else{
                    //여기 파티인경우 적어줄거임
                    var partyRadiosReal = $('input[name="partyid"]:checked');
                    if(partyRadiosReal.length==0){
                        alert('파티를 선택하세요');
                        e.preventDefault();
                        return false;
                    }else{
                        var memberCheckReal = $('input[name="member"]:checked');
                        if(memberCheckReal.length==0){
                            e.preventDefault();
                            alert('팀원을 선택하세요');
                            return false;
                        }else{
                            return true;
                        }
                    }
                    

                }
            });
            //---------------------------------------------
            $('input[name="isteam"]').on('change', function() {
                $(".memberList").empty();
                $('input[name="isteam"]').each(function() {
                    var isChecked = $(this).is(':checked');
                    var label = $(this).closest('label');

                    if (isChecked) {
                        label.removeClass('btn-outline-secondary').addClass('btn-secondary');
                    } else {
                        label.removeClass('btn-secondary').addClass('btn-outline-secondary');
                    }
                });
                var selectTeam = $('input[name="isteam"]:checked').val();
                var teamList = $('.teamList');
                var line = $('.teamName');
                if (selectTeam == "0") {
                    teamList.show(); // 다른 라디오 버튼 그룹 표시
                    line.show();
                }else {
                    teamList.hide(); // 다른 라디오 버튼 그룹 숨김
                    line.hide();
                }
            });
            $('input[name="partyid"]').on('change', function() {
                $(".memberList").empty();
                $(".membername").empty();
                $('input[name="partyid"]').each(function() {
                    var isChecked = $(this).is(':checked');
                    var label = $(this).closest('label');

                    if (isChecked) {
                        label.removeClass('btn-outline-secondary').addClass('btn-secondary');
                    } else {
                        label.removeClass('btn-secondary').addClass('btn-outline-secondary');
                    }
                });
                
                var partyid = $('input[name="partyid"]:checked').val();
                var tag ="";
                var tag1 ="<div class='memberName'>참여 인원</div>";
                $.ajax({
                   url : "${pageContext.servletContext.contextPath}/subject/memberList",
                   type : 'post',
                   data:{
                       partyid : partyid
                   },success:function(r){
                        $(r).each(function (i, result) {
                           tag += `
                                    <div class="memberlisttemp" style="padding-right: 10px;">
                                        <label class="btn btn-outline-secondary">
                                            <input type="checkbox" name="member" value="`+ result.userid +`">
                                            <span>`+ result.username +`</span>
                                        </label>
                                    </div>
                                   `
                        });
                        $(".membername").append(tag1);
                        $(".memberList").append(tag);
                    }
                });

            });


        });
    </script>
</head>
<body>
<div class="content">
    <div class="content-header">
        <h3>기업과제 작성</h3> <!-- 이 부분은 세션에 게시판종류 넣어서 처리할 예정 -->
    </div>
    <form method="post" action="${pageContext.servletContext.contextPath}/subject/submitwriteOk" class="needs-validation writeform" style="padding: 20px 20px 10px 20px;" novalidate>
        <input type="hidden" id="content" name="postcontent">
        <p class="titlename"> 과제명 : ${Svo.subjecttitle}</p>
        <input type="hidden" name="subjectid" value="${Svo.subjectid}">
        <style>
            .categoryname, .submituser, .teamName, .memberName{
                margin: 10px 20px;
                border-bottom: 1px solid #bbb;
                padding-bottom: 5px;
                width: 140px;
                padding-left: 5px;
                font-weight: bold;
                font-size: 16px;
            }
        </style>
        <div>
            <div class="categoryname">카테고리</div>
            <div class="button-container" style="margin-left: 40px; margin-top: 0;">
                <c:if test="${Svo.category==0}">
                    <div class="btn btn-outline-secondary">선택안함</div>
                    <input type="hidden" name="category" value="${Svo.category}">
                </c:if>
                <c:if test="${Svo.category==1}">
                    <div class="btn btn-outline-secondary">IT/프로그래밍</div>
                    <input type="hidden" name="category" value="${Svo.category}">
                </c:if>
                <c:if test="${Svo.category==2}">
                    <div class="btn btn-outline-secondary">디자인</div>
                    <input type="hidden" name="category" value="${Svo.category}">
                </c:if>
                <c:if test="${Svo.category==3}">
                    <div class="btn btn-outline-secondary">영상음향</div>
                    <input type="hidden" name="category" value="${Svo.category}">
                </c:if>
            </div>
        </div>
        <div class="submituser" >참여 유형</div>
        <div class="button-container" style="padding: 0 40px; margin-top: 0;">
            <label class="btn btn-outline-secondary">
                <input type="radio" name="isteam" value="1">
                <span>솔로</span>
            </label>
            <c:if test="${pvo.size() > 0}">
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="isteam" value="0">
                    <span>파티</span>
                </label>
            </c:if>
        </div>
        <div class="teamName" style="display: none">파티 선택</div>
        <div class="teamList" style="display: none">
            <c:forEach items="${pvo}" var="p">
                <div style="padding-right: 10px;">
                    <label class="btn btn-outline-secondary">
                        <input type="radio" name="partyid" value="${p.partyid}">
                        <span>${p.partyname}</span>
                    </label>
                </div>
            </c:forEach>
        </div>
        <div class="membername">

        </div>
        <div class="memberList" style="margin-bottom: 10px">
        <%--     멤버 리스트 출력할 곳       --%>
        </div>
        <div style="padding: 10px">
    <div id="editor"></div>
        <div id="botContainer">
            <input type="submit"  class="btn btn-primary submitbtn" value="글등록" />
        </div>
    </div>
    </form>
    <div class="container_bottom"></div>
</div>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>