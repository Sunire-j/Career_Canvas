<%@ page contentType="text/html; charset=UTF-8" language="java"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      $(function () {
        $(".forevent").on("click", "#deletion", function () {
          var del_target = $(this).attr("title");
          location.href =
            "${pageContext.servletContext.contextPath}/board/delete?postid=" +
            del_target;
        });

        $(".forevent").on("click", "#userDeletion", function () {
          var post_id = $(this).attr("title");
          location.href =
            "${pageContext.servletContext.contextPath}/board/delete/user?postid=" +
            post_id;
        });
      });
    </script>
    <style>
      #sideBar {
        width: 250px;
        position: fixed;
        height: 100%;
        background-color: #ddd;
        padding: 20px;
      }

      #sideBar h3 {
        margin: 15px 0px;
      }

      #sideBar a {
        width: 100%;
        display: flex;
        height: 30px;
        align-items: center;
      }

      .table {
        width: 100%;
        text-align: center;
        margin-top: 35px;
      }

      td {
        vertical-align: middle;
      }

      .pagination-container {
        display: flex;
        align-items: center;
        justify-content: center;
        margin-top: 20px;
        text-align: center;
      }

      .pagination {
        display: inline-block;
      }

      .btn {
        color: white;
      }
    </style>
  </head>
  <body>
    <div style="display: flex">
      <div id="sideBar">
        <div style="text-align: center">
          <h4>관리자 ${name}</h4>
          <a
            href="${pageContext.servletContext.contextPath}/"
            style="
              color: red;
              text-align: center;
              display: block;
              margin: 0 auto;
            "
            >로그아웃</a
          >
        </div>
        <hr />
        <h3>회원관리</h3>
        <a href="${pageContext.servletContext.contextPath}/admin/member">
          일반회원관리
        </a>
        <a href="${pageContext.servletContext.contextPath}/admin/company">
          기업회원관리
        </a>
        <h3>게시글관리</h3>
        <a href="${pageContext.servletContext.contextPath}/admin/board">
          게시판 모니터링
        </a>
        <a href="${pageContext.servletContext.contextPath}/admin/report">
          신고 게시글 관리
        </a>
        <a href="${pageContext.servletContext.contextPath}/admin/delete">
          과제 삭제 신청 목록
        </a>
        <h3>배너관리</h3>
        <a href="${pageContext.servletContext.contextPath}/admin/banner">
          배너 관리
        </a>
        <h3>통계</h3>
        <a href=""> 유저 현황 </a>
        <a href=""> 게시판 현황 </a>
        <a
          href="${pageContext.servletContext.contextPath}/"
          style="position: absolute; bottom: 90px"
          >메인 페이지 이동</a
        >
        <p style="position: absolute; bottom: 50px">당일 접속 유저 : 500명</p>
        <p style="position: absolute; bottom: 20px">
          누적 접속 유저 : 50만명ㅋ
        </p>
      </div>
      <!-- 관리자 페이지 만드실 때 margin-left 여기 참고하시면 됩니다 -->
      <div style="margin-left: 250px; width: 100%; height: 100%; padding: 20px">
        <h1 style="padding: 15px">배너관리</h1>
        <table class="table table-hover">
            <tr>
                <th>번호</th>
                <th>광고주</th>
                <th>배너 파일</th>
                <th>시작날짜</th>
                <th>종료날짜</th>
                <th>관리</th>
            </tr>
            <script>
                function isPastDeadline(deadlinestr){
                    var deadline = new Date(deadlinestr);
                    var now = new Date();
                    return deadline<now;
                }
                function dueDelete(bannerid){
                    location.href="${pageContext.servletContext.contextPath}/admin/banner/delete?bannerid="+bannerid;
                }
                function forceDelete(bannerid){
                    if(confirm("기한이 남아있는 배너입니다. 정말 삭제하시겠습니까?")){
                        location.href="${pageContext.servletContext.contextPath}/admin/banner/delete?bannerid="+bannerid;
                    }
                }
            </script>
        <c:forEach var="bannerVO" items="${bannerVO}">
            <tr class="forevent"></tr>
                <td>${bannerVO.bannerid}</td>
                <td>${bannerVO.owner}</td>
            <td><a class="btn btn-sm btn-primary" onclick="window.open('${pageContext.servletContext.contextPath}/admin/banner/check?bannerid=${bannerVO.bannerid}')">확인</a></td>
                <td>${bannerVO.startdate}</td>
                <td>${bannerVO.deadline}</td>
            <td>
                <a class="btn btn-sm btn-danger" onclick="forceDelete(${bannerVO.bannerid})">강제삭제</a>
                <button onclick="dueDelete(${bannerVO.bannerid})" class="btn btn-sm btn-danger" style="margin-left: 10px" id="expireDelete${bannerVO.bannerid}">만료삭제</button>
                <script>
                    document.getElementById('expireDelete${bannerVO.bannerid}').disabled = !isPastDeadline('${bannerVO.deadline}');
                </script>
            </td>
            </tr>
        </c:forEach>
        </table>
          <div style="width: 100%; text-align: right;" >
              <input type="button" class="btn-primary btn" value="배너 추가" onclick="location.href='${pageContext.servletContext.contextPath}/admin/banner/add'">
          </div>
        <!-- 페이징 -->
        <div>
            <ul style="display: flex; align-items: center">
                <c:if test="${pVO.page == 1}">
                  <li><input type="button" value="<" class="btn btn-outline-primary" disabled></li>
                </c:if>
                <c:if test="${pVO.page > 1}">
                  <li>
                    <a
                      href="${pageContext.servletContext.contextPath}/mypage/myPofol?page=${pVO.page - 1}"
                      ><input type="button" value="<" class="btn btn-outline-primary"></a
                    >
                  </li>
                </c:if>

                </ul>
        </div>
    </div>
  </body>
</html>
