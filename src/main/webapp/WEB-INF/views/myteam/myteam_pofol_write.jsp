<%@ page contentType="text/html;charset=UTF-8" language="java"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>게시글 작성</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
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
        margin-top: 50px;
      }

      input[type="radio"] {
        display: none;
      }
      .container_bottom{
        display: flex;
        background: #A69668;
        height: 10px;
        margin-top: 10px;
      }
    </style>
    <script>
      $(function () {
        let editor;
        CKEDITOR.ClassicEditor.create(document.getElementById("editor"), {
          toolbar: {
            items: [
              "bold",
              "italic",
              "|",
              "fontSize",
              "fontColor",
              "fontBackgroundColor",
              "highlight",
              "|",
              "alignment",
              "|",
              "insertImage",
              "mediaEmbed",
              "|",
              "horizontalLine",
              "|",
            ],
            shouldNotGroupWhenFull: true,
          },
          list: {
            properties: {
              styles: true,
              startIndex: true,
              reversed: true,
            },
          },
          placeholder: "내용을 입력해주세요.",
          fontFamily: {
            options: [
              "default",
              "Arial, Helvetica, sans-serif",
              "Courier New, Courier, monospace",
              "Georgia, serif",
              "Lucida Sans Unicode, Lucida Grande, sans-serif",
              "Tahoma, Geneva, sans-serif",
              "Times New Roman, Times, serif",
              "Trebuchet MS, Helvetica, sans-serif",
              "Verdana, Geneva, sans-serif",
            ],
            supportAllValues: true,
          },
          fontSize: {
            options: [10, 12, 14, "default", 18, 20, 22],
            supportAllValues: true,
          },
          htmlSupport: {
            allow: [
              {
                name: /.*/,
                attributes: true,
                classes: true,
                styles: true,
              },
            ],
          },
          link: {
            decorators: {
              addTargetToExternalLinks: true,
              defaultProtocol: "https://",
              toggleDownloadable: {
                mode: "manual",
                label: "Downloadable",
                attributes: {
                  download: "file",
                },
              },
            },
          },
          removePlugins: [
            "CKBox",
            "CKFinder",
            "EasyImage",
            "RealTimeCollaborativeComments",
            "RealTimeCollaborativeTrackChanges",
            "RealTimeCollaborativeRevisionHistory",
            "PresenceList",
            "Comments",
            "TrackChanges",
            "TrackChangesData",
            "RevisionHistory",
            "Pagination",
            "WProofreader",
            "MathType",
            "SlashCommand",
            "Template",
            "DocumentOutline",
            "FormatPainter",
            "TableOfContents",
            "PasteFromOfficeEnhanced",
          ],
        })
          .then((neweditor) => {
            editor = neweditor;
            editor.model.document.on("change:data", () => {
              document.querySelector("#content").value = editor.getData();
            });
          })
          .catch((err) => {
            console.error(err.stack);
          });
        //

        $('.button-container input[type="radio"]').change(function () {
          $(".button-container label")
            .removeClass("btn-dark")
            .addClass("btn-outline-dark");
          if ($(this).is(":checked")) {
            $(this)
              .parent()
              .removeClass("btn-outline-dark")
              .addClass("btn-dark");
          }
        });
        $('.check-container input[type="checkbox"]').change(function () {
          $(this)
                  .parent()
                  .toggleClass("btn-success", $(this).is(":checked"))
                  .toggleClass("btn-outline-success", !$(this).is(":checked"));
        });
        $("#title").on("input blur", function () {
          var title = $(this).val();
          if (title.length > 30) {
            $(this).val(title.substring(0, 30));
          }
          if (title.length == 0) {
            $(this).addClass("is-invalid").removeClass("is-valid");
          } else {
            $(this).addClass("is-valid").removeClass("is-invalid");
          }
        });
        $("form").on("submit", function (e) {
          var editorContent = editor.getData();
          var category = document.getElementsByName('category');
          var categoryCheck = false;
          var member = document.getElementsByName('member');
          var memberCheck = false;

          if(!$("#title").val()){
            alert("제목을 입력해 주세요");
            return false;
          }
          // 카테고리 선택 유효성
          for(var i=0; i<category.length; i++){
            if(category[i].checked) {
              categoryCheck = true;
              break;
            }
          }
          if(!categoryCheck) {
            alert('카테고리를 선택하세요');
            return false;
          }
          for(var i=0; i<member.length; i++){
            if(member[i].checked){
              memberCheck = true;
              break;
            }
          }
          if(!memberCheck){
            alert('참여인원을 선택하세요');
            return false;
          }

          if (!editorContent) {
            e.preventDefault();
            alert("글 내용을 입력해 주세요.");
          }
        });
      });
    </script>
  </head>
  <body>
    <div class="content">
      <div class="content-header">
        <h3>포트폴리오 작성</h3>
      </div>
        <form
          method="post"
          style=""
          action="${pageContext.servletContext.contextPath}/myteam/pofolWriteOk"
          class="needs-validation writeform"
          novalidate
        >
          <div style="background: #D9D9D9; padding: 20px; border-bottom: 2px solid #73351F">
          <input type="hidden" id="content" name="postcontent"/>
          <input
            type="text"
            style="width: 40%;"
            class="form-control"
            name="posttitle"
            id="title"
            placeholder="제목을 입력해 주세요."
            required
            maxlength="30"
          />
          <div class="invalid-feedback">제목을 입력해 주세요. (30자 이내)</div>
          <div style="padding: 20px 0">
            <div class="button-container">
              <label class="btn btn-outline-dark">
                <input type="radio" name="category" value="0" />
                <span>선택안함</span>
              </label>
              <label class="btn btn-outline-dark">
                <input type="radio" name="category" value="1" />
                <span>IT/프로그래밍</span>
              </label>
              <label class="btn btn-outline-dark">
                <input type="radio" name="category" value="2" />
                <span>디자인</span>
              </label>
              <label class="btn btn-outline-dark">
                <input type="radio" name="category" value="3" />
                <span>영상음향</span>
              </label>
            </div>
          </div>
          <div class="check-container" style="margin: 10px 0;">
            <c:forEach items="${memberList}" var="uvo" >
                <label class="btn btn-outline-success">
                  <input type="hidden" name="no" value="${no}">
                  <input type="checkbox" name="member" value="${uvo.userid}" />
                  <span>${uvo.username}</span>
                </label>
            </c:forEach>
          </div>
        </div>
      <div style="background: #F2F2F2; padding: 10px">
        <div id="editor"></div>
        <div id="botContainer">
          <div style="width: 50%" class="botContainer2">
          </div>
          <input
            type="submit"
            class="btn btn-primary submitbtn"
            value="글등록"
          />
        </div>
      </div>
      </form>
      <div class="container_bottom"></div>
    </div>
  </body>
</html>
<%@include file="../header_footer/footer.jspf" %>
