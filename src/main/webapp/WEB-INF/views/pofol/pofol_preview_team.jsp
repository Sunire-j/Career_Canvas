<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/2026ef433b.js" crossorigin="anonymous"></script>
    <style>
        /*-----------------------------------------------*/
        .container {
            margin: 0 auto;
            border-left: 1px solid #73351F;
            border-right: 1px solid #73351F;
            background: #F2F2F2;
        }
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            list-style: none;
            text-decoration: none;
        }

        ul,
        li {
            padding: 0;
            margin: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .main-title{
            font-size: 28px;
            font-weight: 500;
            letter-spacing: 0;
            line-height: 1.5em;
            position: relative;
            margin-top: 20px;
        }
        .space {
            height: 200px;
            background: white;
        }

        a:link,
        a:visited {
            color: black;
            text-decoration: none;
        }
        /* Header*/

        /* Title & Logo */

        .title {
            display: flex;
            align-items: center;
        }

        .hamberger {
            display: none;
            font-size: 1.7rem;
        }

        .logo {
            height: 60px;
            line-height: 60px;
            font-size: 1.7rem;
            margin: 0;
        }

        .login {
            position: absolute;
        }


        /* NavBar */

        .nav_wrapper {
            display: flex;
            justify-content: space-between;
        }

        .navBar,
        .infoGroup {
            display: flex;
            justify-content: center;
            padding: 0;
            margin: 0;
        }

        .nav_wrapper li {
            padding-right: 20px;


        }

        .userInfo {
            display: none;
            position: absolute;
            background: rgba(255, 255, 255, 0.849);
            z-index: 1;
        }

        .userInfo li {
            height: 30px;
            line-height: 30px;
        }

        .userInfo.active {
            display: block;
            margin: 0;
            padding: 0;
        }

        .carousel {
            z-index: 0;
        }

        /*-----------------------------------------------*/
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }


        article {
            width: 1200px;
            margin: 0 auto;
            margin-top: 80PX;
        }
        .content>li{
            width: 25%;
            margin-top: 20px;
            margin-bottom: 10px;
        }
        .content{
            display: flex;
            width: 1100px;
            flex-wrap: wrap;
        }

        /* 프로필 정보 */
        /* 이미지, 이름, 이메일, 작성한 글 수*/
        .profile {
            height: 160px;
        }

        .profile_img {
            float: left;
        }

        .profile_img > img {
            width: 160px;
            height: 160px;
            border-radius: 40px;

        }

        .profile_info {
            display: inline-block;
            height: 160px;
            margin-left: 20px;
        }

        .info_solo {
            margin-top: 30px;
            margin-left: 10px;
            width: 40px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            background-color: #ddd;
            border-radius: 5px;
            display: inline-block;
        }

        .info_name {
            margin-top: 15px;
            margin-left: 10px;
            display: inline-block;
            font-size: 2em;
        }

        .info_email {
            margin-top: 5px;
            margin-left: 10px;
            font-size: 1.5em;
            color: gray;
        }

        .info_count > div {
            margin-top: 10px;
            display: inline-block;
            margin-left: 10px;
            font-weight: 700;
        }

        .salutation {
            margin-top: 30px;
            height: 200px;
            border-bottom: 2px solid #ddd;

        }

        /* 소개 글*/
        .salutation_name {
            height: 40px;
            width: 130px;
            border-bottom: 2px solid #ddd;
            font-size: 1.5em;
            font-weight: 700;
        }

        .salutation_content {
            margin-top: 10px;
            margin-left: 10px;
            font-size: 1.2em;

        }

        /* 포트폴리오 */
        .portfolio_category {
            width: 300px;
            margin: 0 auto;
            margin-top: 30px;
        }

        .portfolio_category > button {
            margin-left: 10px;
        }

        .portfolio_content {
            margin: 0 auto;
            margin-top: 10px;
        }

        .content img {
            width: 235px;
            height: 235px;
            border-radius: 30px;

        }

        .content_info {
            width: 230px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-weight: bold;
        }

        .img_C {
            width: 235px;
            margin-left: 30px;
        }

        .content_category, .content_title {
            display: inline;
            height: 40px;
            line-height: 40px;
        }

        .content_category {
            height: 30px;
            margin-top: 10px;
            margin-right: 10px;
            background-color: #ddd;
            border-radius: 5px;
            text-align: center;
            padding: 5px 5px 5px 10px;
        }


        /*페이지*/
        .portfolio_paging {
            width: 200px;
            margin: 0 auto;
        }

        .pagination > li {
            margin-left: 10px;
        }

        .page-link {
            color: black;
            border-radius: 6px;
        }

        .container_bottom {
            display: flex;
            background: #A69668;
            height: 10px;
            margin-top: 10px;
        }

        .hr-styleset {
            border: 0;
            border-top: 2.5px dashed #73351F;
            border-bottom: 1px dashed #D9D9D9;
        }

        .container-head {
            display: flex;
            justify-content: center;
            align-items: center;
            background: #A69668;
            height: 10px;
        }

        hr {
            border-top: 2.5px solid #73351F;
        }
    </style>
</head>

<body>
<section>
    <article class="container"
             style="margin-top: 70px; border-top: 3px solid #73351F; padding: 0px; background: #d9d9d9">
        <div class="container-head"></div>
        <div class="portfolio">
            <div class="container-title" style="background:#F2F2F2 ;height: 80px; border-bottom: 1px solid #73351F; display: flex; align-items: center; justify-content: center">
                <h1 class="main-title" style="margin-top: 0px; font-weight: bold; font-size: 35px">포트폴리오</h1>
            </div>
            <div style="background: #D9D9D9;">
                <div class="d-flex" style="display: flex; padding: 5px ;height: 50px;display: flex; margin: 10px; justify-content: space-between">
                    <select class="form-select" style="width: 10% ;border: 1px solid #73351f" id="postSort" name="postSort">
                        <option value="1"
                                <c:if test="${pVO.postSort==1}">
                                    selected
                                </c:if>
                        >최신순
                        </option>
                        <option value="2" <c:if test="${pVO.postSort==2}">
                            selected
                        </c:if>>조회순
                        </option>
                        <option value="3" <c:if test="${pVO.postSort==3}">
                            selected
                        </c:if>>추천순
                        </option>
                    </select>
                    <div style="justify-content: center; text-align: center; width: 30%">
                        <button class="btn btn-outline-secondary" style="margin-right: 20px"
                                onclick="location.href='${pageContext.servletContext.contextPath}/pofol_preview'">개인
                        </button>
                        <button class="btn btn-secondary"
                                onclick="location.href='${pageContext.servletContext.contextPath}/pofol_preview/team'">팀
                        </button>
                    </div>
                    <select class="form-select" style="width: 10%; border: 1px solid #73351f" name="category" id="category">
                        <option value="0">카테고리</option>
                        <option value="1" <c:if test="${pVO.category==1}">selected</c:if>>IT/프로그래밍</option>
                        <option value="2" <c:if test="${pVO.category==2}">selected</c:if>>디자인</option>
                        <option value="3" <c:if test="${pVO.category==3}">selected</c:if>>영상음향</option>
                    </select>
                </div>
            </div>
        </div>

        <div style="padding: 0px; border-bottom: 3px solid #73351F; background: #F2F2F2; border-top: 1px solid #73351f">
        <div style="padding: 20px 40px 40px 40px">
            <div class="portfolio_content">
                <ul class="content">
                    <c:forEach items="${pofolVO}" var="p">
                        <li>
                            <a href="${pageContext.servletContext.contextPath}/pofolview?pofolid=${p.portfolioid}">
                                <div class="img_C">
                                    <img src="${pageContext.servletContext.contextPath}/upload${p.imgsrc}"
                                         class="portfolio_img">
                                    <!-- line 1 -->
                                    <div class="content_info">
                                        <div class="content_category">
                                            <c:if test="${p.category==0}">
                                                분류없음
                                            </c:if>
                                            <c:if test="${p.category==1}">
                                                IT/개발
                                            </c:if>
                                            <c:if test="${p.category==2}">
                                                디자인
                                            </c:if>
                                            <c:if test="${p.category==3}">
                                                영상
                                            </c:if>
                                        </div>
                                        <div class="content_title">
                                                ${p.portfoliotitle}
                                        </div>
                                    </div>
                                    <!-- line 2 -->
                                    <div style="display: flex; justify-content: space-between; align-items: center;">
                                        <div style="display: flex; align-items: center;">
                                            <img src="${pageContext.servletContext.contextPath}/upload${p.profileimg}"
                                                 style="width:20px; height:20px;" alt="">
                                            <span style="margin-left:10px; width: 150px;white-space: nowrap;
                                    overflow: hidden; text-overflow: ellipsis;">${p.username}</span>
                                        </div>
                                        <div class="iconGroup">
                                            <i class="fa-solid fa-eye" style="color: #0d0d0d;"></i>
                                            <span>${p.view}</span></br>
                                            <i class="fa-solid fa-heart" style="color: #e61919;"></i>
                                            <span>${p.likeCnt}</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <!-- 페이징 -->
            <div class="pagination-container" style="margin: 0 auto; margin-top: 20px;">
                <div style="width:74px;"></div>
                <div class="pagination" style="display: flex">
                    <div class="paging">
                        <c:if test="${pVO.page > 1}">
                            <button class="btn btn-outline-secondary" onclick="location.href='?page=${pVO.page - 1}'
                            <c:if test="${pVO.category !=''}">
                                    +'&category=${pVO.category}'
                            </c:if>
                            <c:if test="${pVO.searchWord!=''}">
                                    +'&searchKey=${pVO.searchKey}'
                                    +'&searchWord=${pVO.searchWord}'
                            </c:if>
                            <c:if test="${pVO.postSort!=''}">
                                    +'&postSort=${pVO.postSort}'
                            </c:if>
                                    "><
                            </button>
                        </c:if>
                        <c:forEach var="i" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
                            <c:if test="${i <= pVO.totalPage}">
                                <c:choose>
                                    <c:when test="${i != pVO.page}">
                                        <button class="btn btn-outline-secondary" onclick="location.href='?page=${i}'
                                        <c:if test="${pVO.category !=''}">
                                                +'&category=${pVO.category}'
                                        </c:if>
                                        <c:if test="${pVO.searchWord!=''}">
                                                +'&searchKey=${pVO.searchKey}'
                                                +'&searchWord=${pVO.searchWord}'
                                        </c:if>
                                        <c:if test="${pVO.postSort!=''}">
                                                +'&postSort=${pVO.postSort}'
                                        </c:if>
                                                ">${i}</button>
                                    </c:when>
                                    <c:otherwise>
                                        <strong class="btn btn-outline-secondary" style="font-weight: bold">${i}</strong>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pVO.page < pVO.totalPage}">
                            <button class="btn btn-outline-secondary" onclick="location.href='?page=${pVO.page + 1}'
                            <c:if test="${pVO.category !=''}">
                                    +'&category=${pVO.category}'
                            </c:if>
                            <c:if test="${pVO.searchWord!=''}">
                                    +'&searchKey=${pVO.searchKey}'
                                    +'&searchWord=${pVO.searchWord}'
                            </c:if>
                            <c:if test="${pVO.postSort!=''}">
                                    +'&postSort=${pVO.postSort}'
                            </c:if>
                                    ">>
                            </button>
                        </c:if>
                    </div>
                </div>
                <div>
                    <a href="${pageContext.servletContext.contextPath}/subject/write">
                        <input class="btn btn-outline-secondary" type="button" value="글쓰기">
                    </a>
                </div>  
            </div>

            <!-- 검색 -->
            <div style="width: 100%; text-align: center;">
                <div class="search-container">
                    <form action="${pageContext.servletContext.contextPath}/pofol_preview/team"
                          class="d-flex board-bottom" method="get">
                        <select class="form-select" style="width: fit-content; margin-right: 10px" name="searchKey">
                            <option value="all">전체</option>
                            <option value="title">제목</option>
                            <option value="author">작성자</option>
                            <option value="content">글내용</option>
                        </select>
                        <input type="text" class="form-control" name="searchWord" placeholder="검색어를 입력하세요"
                               style="margin-right: 10px" maxlength="30">
                        <input type="submit" class="btn btn-secondary" value="검색">
                        <input type="hidden" name="category" value="${pVO.category}"/>
                    </form>
                </div>
            </div>
        </div>
        <div class="container_bottom"></div>
    </div>
    </div>
    </article>
</section>
<script>
    $(function () {
        $('#category').val(${pVO.category});
        $('#category').change(function () {
            selectedValue = $(this).val();
            window.location.href = "${pageContext.servletContext.contextPath}/pofol_preview/team?category=" + selectedValue;

        });
        $("#postSort").change(function () {
            var sortvalue = $(this).val();
            window.location.href = "${pageContext.servletContext.contextPath}/pofol_preview/team?category=${pVO.category}&postSort=" + sortvalue + "&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}";
        });
    });

</script>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>