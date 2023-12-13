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
      h3{

        font-size: 40px;
        font-weight: bold;
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

        $('.category-container input[type="radio"]').change(function () {
          $(".category-container label")
            .removeClass("btn-dark")
            .addClass("btn-outline-dark");
          if ($(this).is(":checked")) {
            $(this)
              .parent()
              .removeClass("btn-outline-dark")
              .addClass("btn-dark");
          }
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

        $("#hashtag").on("input blur", function () {
          if (this.checkValidity()) {
            $(this).siblings('[data-feedback="patternMismatch"]').hide();
            $(this).removeClass("is-invalid").addClass("is-valid");
          } else {
            $(this).removeClass("is-valid").addClass("is-invalid");
            $(this).siblings('[data-feedback="patternMismatch"]').show();
          }
        });
        $("form").on("submit", function (e) {
          var editorContent = editor.getData();
          if(!$("#title").val()){
            e.preventDefault();
            alert("제목을 입력해 주세요");
            return false;
          }
          if (!editorContent) {
            e.preventDefault();
            alert("글 내용을 입력해 주세요.");
          }
        });

        $(".hashtag").on("change blur", function () {
          if ($(this).hasClass("is-invalid")) {
            $(".submitbtn").prop("disabled", true);
          } else {
            $(".submitbtn").prop("disabled", false);
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
    <div style="background: #D9D9D9">
      <form
        method="post"
        action="${pageContext.servletContext.contextPath}/mypage/myPofol/writeOk"
        class="needs-validation writeform"
        style="padding: 20px 20px 10px 20px; border-bottom: 2px solid #73351F"
        novalidate
      >
        <input type="hidden" id="content" name="postcontent" />
        <input
          type="text"
          style="width: 40%"
          class="form-control"
          name="posttitle"
          id="title"
          placeholder="제목을 입력해 주세요."
          required
          maxlength="30"
        />
        <div class="invalid-feedback">제목을 입력해 주세요. (30자 이내)</div>

        <!-- 카테고리 -->
        <div>
          <div class="category-container">
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
        </div>

        <div style="padding: 10px">
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
      </form>
    </div>
    <div class="container_bottom"></div>
  </div>
  </div>
  </body>
</html>
<%@include file="../header_footer/footer.jspf" %>
