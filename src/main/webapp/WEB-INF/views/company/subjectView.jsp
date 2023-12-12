<%@ page contentType="text/html;charset=UTF-8" language="java"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@include
file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>글 내용 보기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script
      src="https://kit.fontawesome.com/6caf283963.js"
      crossorigin="anonymous"
    ></script>
    <style>
      ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
      }

      article {
        width: 1200px;
        margin: 0 auto;
        margin-top: 30px;
        border-width: 3px 1px 3px 1px;
        border-style: solid;
        border-color: #73351f;
        background: #f2f2f2;
      }

      figure img{
        max-width: 1116px;
      }

      .board_category {
        background-color: #ddd;
        width: 145px;
        text-align: center;
        border-radius: 10px;
      }

      .board_title {
        display: flex;
        text-align: center;
        align-items: center;
        height: 80px;
        font-size: 2em;
        font-weight: bold;
        border-bottom: 2px solid #73351f;
        padding-left: 20px;
        background: #a69668;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }

      /* 게시물 정보( 작성자, 날짜, 조회수, 추천수) */
      .board_main {
        border-bottom: 3px solid #73351f;
        border-top: 3px solid #73351f;
        border-left: 1px solid #73351f;
        border-right: 1px solid #73351f;
      }
      .board_info {
        display: flex;
        background: #d9c8a9;
        align-items: center;
        height: 30px;
      }

      .board_writer {
        display: flex;
        padding-right: 10px;
        border-right: 1px solid darkgray;
        text-align: center;
      }

      .board_date {
        padding-left: 10px;
      }

      .board_info > div:nth-child(n + 3) {
        padding-left: 10px;
      }

      .board_view {
        width: 60px;
        text-align: center;
        margin: auto 0 0 auto;
      }

      .board_recommend {
        width: 60px;
        text-align: center;
      }

      /* 게시글 내용 */
      .board_content {
        margin-top: 10px;
      }

      .content_text {
        padding: 10px 20px;
        min-height: 300px;
      }

      .content_recommend {
        width: 80px;
        margin: 0 auto;
        margin-bottom: 20px;
      }

      /* 댓글쓰기 */
      .comment_write {
        margin-top: 15px;
        display: flex;
        border-bottom: 1px solid #ddd;
      }

      .comment_content {
        border: 1px solid #ddd;
        width: 90%;
        height: 100px;
        min-height: 100px;
        margin-left: 3px;
        margin-bottom: 3px;
        margin-top: 3px;
      }

      .comment_write_ok {
        width: 10%;
        height: 100px;
      }

      /* 댓글 리스트 */
      .comment_main {
      }
      .comment_list {
        background: #a69668;
      }
      .comment_list li {
        float: none;
      }
      .comment_list_content {
        padding-top: 10px;
        padding-bottom: 10px;
        border: 0.5px #73351f solid;
      }

      .list_img {
        width: 50px;
        height: 50px;
        border-radius: 15px;
      }

      .comment_writer,
      .comment_date {
        display: inline-block;
      }
      .container_bottom {
        display: flex;
        background: #a69668;
        height: 10px;
        margin-top: 10px;
      }
      .comment_writer {
        padding: 0 5px;
      }
      .reply_content {
        background: #d9d9d9;
        margin-bottom: 15px;
      }
      .reply_content > div {
        display: inline-block;
      }

      .reply {
        padding: 10px;
        width: 85%;
        height: 50px;
      }

      /* IE9 이하를 위한 css */
      input::placeholder {
        display: flex;
        text-align: center;
        align-items: center;
      }
    </style>
  </head>
  <body>
    <article>
      <div class="board_title">${Svo.subjecttitle}</div>
      <section style="padding: 20px">
        <div class="board_category" style="margin-bottom: 20px">기업과제</div>
        <div class="board_main">
          <div class="board_info">
            <div class="board_writer">${Svo.username}</div>
            <div class="board_date">${Svo.date}</div>
          </div>
          <div class="board_content">
            <div class="content_text">${Svo.subjectcontent}</div>
            <div
              class="content_recommend"
              style="
                width: 100%;
                display: flex;
                justify-content: space-between;
                align-items: center;
              "
            >
              <div></div>
              <button
                type="button"
                style="color: white"
                onclick="applySubject()"
                class="btn btn-primary"
              >
                <i class="fa-solid fa-hand"></i>&nbsp제출
              </button>
              <div class="d-flex">
                <c:if test="${LogId==Svo.user_userid}">
                  <a
                    style="height: fit-content"
                    class="btn btn-outline-danger btn-sm"
                    id="del_post"
                    onclick="delSubject()"
                    >삭제 신청</a
                  >
                  <%--
                  onclick="location.href='${pageContext.servletContext.contextPath}/subject/del?subjectid=${Svo.subjectid}'--%>
                </c:if>
              </div>
            </div>
          </div>
        </div>

        <script>
          function delSubject(){
              if(${delcount>0}){
                  alert("이미 삭제 신청을 하였습니다.\n삭제 신청은 한 번만 가능합니다.");
                  return false;
              }
              var popupWidth = 600; // 팝업 창의 가로 크기
              var popupHeight = 300; // 팝업 창의 세로 크기
              var screenWidth = window.innerWidth; // 화면의 가로 크기
              var screenHeight = window.innerHeight; // 화면의 세로 크기

              var popupLeft = (screenWidth - popupWidth) / 2; // 팝업 창의 가로 위치
              var popupTop = (screenHeight - popupHeight) / 2; // 팝업 창의 세로 위치

              var popupUrl = '${pageContext.servletContext.contextPath}/subject/del?subjectid=${Svo.subjectid}';

              window.open(popupUrl, '팝업', 'width=' + popupWidth +
                                          ', height=' + popupHeight +
                                          ', left=' + popupLeft +
                                          ', top=' + popupTop);
          }
          function applySubject(){
              var no = ${Svo.subjectid};
              if(confirm("과제명 : ${Svo.subjecttitle} \n제출 하시겠습니까?")){
                 location.href = '${pageContext.servletContext.contextPath}/subject/submit?subjectid='+no;
              }
          }
        </script>
      </section>
      <hr style="border: 2px dashed #73351f" />
      <div class="container_bottom"></div>
    </article>
    <footer></footer>
  </body>
</html>
<%@include file="../header_footer/footer.jspf" %>
