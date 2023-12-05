<%@ page contentType="text/html;charset=UTF-8" language="java"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@include
file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>CAREERCANVAS</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
    <script>
      $(document).ready(function () {
        $(".bxslider_preview").bxSlider({
          minSlides: 4,
          maxSlides: 4,
          slideWidth: 10,
          slideMargin: 10,
          ticker: true,
          speed: 9000,
          slideWidth: "2000px",
        });
        $(".bxslider").bxSlider({
          slideWidth: 1200,
          minSlides: 5,
          maxSlides: 20,
          slideMargin: 10,
        });
      });

      function solo() {
        $.ajax({
          url: "${pageContext.servletContext.contextPath}/pofol_solo",
          type: "GET",
          success: function (pofolList) {
            console.log(pofolList);

            var temp = "";
            if (pofolList && pofolList.length > 0) {
              $.each(pofolList, function (i, pofol) {
                console.log(pofol.imgsrc);
                temp +=
                  '<li><a href="${pageContext.servletContext.contextPath}/pofol_solo?portfolioid=' +
                  pofol.portfolioid +
                  '">';
                temp +=
                  '<img style="width:200px; height: 200px;" src="${pageContext.servletContext.contextPath}/upload' +
                  pofol.imgsrc +
                  '">';
                temp += "</li>";
              });
              $("#bxslider_preview").html(temp);

              // $(".bxslider_preview").bxSlider({
              //   minSlides: 4,
              //   maxSlides: 4,
              //   slideWidth: 170,
              //   slideMargin: 10,
              //   ticker: true,
              //   speed: 9000,
              // });
            }
          },
          error: function (e) {
            console.log(e.responseText);
          },
        });
      }
    </script>
    <style>
      .bxslider a {
        width: 100px;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <main
      class="container"
      style="max-width: 1200px; margin: 0 auto; text-align: center"
    >
      <section class="bestPofol">
        <h1>트렌디하고 감각적인 디자인 포트폴리오</h1>
        <p>전체 작품 중 가장 인기있는 포트폴리오를 추천드립니다</p>
        <input type="button" value="개인 포트폴리오" onclick="solo()" />
        <input type="button" value="팀 포트폴리오" />
        <ul
          class="bxslider_preview"
          id="bxslider_preview"
          style="display: flex"
        >
          <li><img src="http://placehold.it/170x200&text=Slide 1" /></li>
          <li><img src="http://placehold.it/170x200&text=Slide 2" /></li>
          <li><img src="http://placehold.it/170x200&text=Slide 3" /></li>
          <li><img src="http://placehold.it/170x200&text=Slide 4" /></li>
          <li><img src="http://placehold.it/170x200&text=Slide 5" /></li>
          <li><img src="http://placehold.it/170x200&text=Slide 6" /></li>
          <li><img src="http://placehold.it/170x200&text=Slide 7" /></li>
          <li><img src="http://placehold.it/170x200&text=Slide 8" /></li>
        </ul>
      </section>

      <section style="text-align: left">
        <h2 style="padding-right: 30px">카테고리별 둘러보기</h2>
        <article>
          <p>전체보기</p>
          <div style="display:flex;">
            <c:forEach var="p" items="${pofolVO}"> 
              <div>
                <img src="${pageContext.servletContext.contextPath}/upload"+${p.imgsrc}>
                <p>${p.portfoliotitle}</p>
             </div>
            </c:forEach>
          </div>
        </article>
      </section>
    </main>
  </body>
</html>
