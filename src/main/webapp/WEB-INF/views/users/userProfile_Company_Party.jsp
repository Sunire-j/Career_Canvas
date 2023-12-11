<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
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

        .space {
            height: 200px;
            background: white;
        }

        a:link,
        a:visited {
            color: black;
            text-decoration: none;
        }

        .buttonGroup {
            text-align: center;
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

        /* 프로필 정보 */
        /* 이미지, 이름, 이메일, 작성한 글 수*/
        .profile {
            height: 160px;
            display: flex;
            justify-content: space-between;
        }

        .profile_img {
            float: left;
        }

        .profile_img>img {
            width: 160px;
            height: 160px;
            border-radius: 40px;
            margin-bottom: 90px;
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
            color: rgb(128, 128, 128);
        }

        .info_count>div {
            margin-top: 10px;
            display: inline-block;
            margin-left: 10px;
            font-weight: 700;
        }

        .salutation {
            margin-top: 30px;
            height: 200px;
            border-bottom: 2px solid #73351F;

        }

        /* 소개 글*/
        .salutation_name {
            height: 40px;
            width: 130px;
            border-bottom: 2px solid #73351F;
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
            display: flex;
            justify-content: space-between;
        }

        .portfolio_category>button {
        }

        .portfolio_content{
            margin: 0 auto;
            margin-top: 10px;

        }
        .portfolio_content>li{
            float: left;
        }
        .img_C{
            width:235px;
            margin-left: 30px;
        }
        .content img {
            width: 235px;
            height: 235px;
            border-radius: 30px;

            margin-top: 30px;
        }
        .content_info{
            width: 330px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-weight: bold;
        }
        .content_category, .content_title{
            display: inline;
            height: 40px;
            line-height: 40px;
        }
        .content_category{
            height: 30px;
            margin-right: 10px;
            background-color: #ddd;
            border-radius: 5px;
            text-align: center;
            padding: 5px 5px 5px 10px;
        }
        .solo_party{
            display: flex;
            justify-content : space-between;
        }

        .solo_party_btn{

        }

        /*페이지*/
        .portfolio_paging {
            width: 200px;
            margin: 0 auto;
        }

        .pagination>li {
            margin-left: 10px;
        }
        .page-link {
            color: black;
            border-radius: 6px;
        }
        .container_bottom{
            display: flex;
            background: #A69668;
            height: 10px;
            margin-top: 10px;
        }
        .hr-styleset{
            border: 0;
            border-top: 2.5px dashed #73351F ;
            border-bottom: 1px dashed #D9D9D9;
        }
        .container-head{
            display: flex;
            justify-content: center;
            align-items: center;
            background: #A69668;
            height: 10px;
        }
        hr{
            border-top: 2.5px solid #73351F ;
        }
    </style>
</head>

<body>
<section>
    <article class="container" style="margin-top: 100px; border-top: 3px solid #73351F; border-bottom: 2px dashed #73351F; padding: 0px">
        <div class="container-head"></div>
        <div style="padding: 40px 40px 20px 40px">
            <div class="profile">
                <div class="profile_img">
                    <img src="${pageContext.servletContext.contextPath}/upload${uVO.profileimg}">
                    <div class="profile_info">
                        <div class="info_name"><b>${uVO.username }</b></div>
                        <div class="info_email">${uVO.useremail}</div>
                        <div class="info_count">
                            <div>포트폴리오</div>
                            <div>${pCount}</div>
                            <div>기업과제</div>
                            <div>${sCount}</div>
                        </div>
                    </div>
                </div>
                <div id="interesting">
                    <p style="text-align : right;font-size: 1.2em;">관심분야</p>
                    <div class="userInterest" style="display: flex; flex-wrap: wrap">
                        <c:forEach var="interest" items="${interest}">
                            <span><input class="btn btn-outline-primary btn-sm" style="margin-left: 10px" type="button" value="${interest}"></span>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="salutation">
                <div class="salutation_name">
                    소개 글
                </div>
                <div class="salutation_content">
                    ${uVO.comment}
                </div>
            </div>
        </div>
    </article>
    <div class="container"  style="padding: 0px; border-bottom: 3px solid #73351F;">
        <div style="padding: 20px 40px 40px 40px">
        <div class="portfolio">
            <div class="portfolio_category">
                <button class="btn btn-outline-secondary" onclick="location.href='${pageContext.servletContext.contextPath}/profile/portfolio?uid=${uVO.userid}'">포트폴리오</button>
                <button class="btn btn-secondary" onclick="location.href='${pageContext.servletContext.contextPath}/profile/subject/solo?uid=${uVO.userid}'">기업과제</button>
            </div>
            <div class="solo_party">
                <div></div>
                <div class="solo_party_btn" style="margin-top: 20px">
                    <button class="btn btn-outline-success" onclick="location.href='${pageContext.servletContext.contextPath}/profile/subject/solo?uid=${uVO.userid}'">개인</button>
                    <button class="btn btn-success" onclick="location.href='${pageContext.servletContext.contextPath}/profile/subject/party?uid=${uVO.userid}'">파티</button>
                </div>
                <div></div>
            </div>
            <div class="portfolio_content">
                <ul class="content" style="width: 1200px; display: flex; flex-wrap: wrap">
                    <c:forEach items="${sVO}" var="svo">
                        <li>
                            <a href="${pageContext.servletContext.contextPath}/subject/applyView?applyid=${svo.applyid}">
                            <div class="img_C">
                                <img src="${pageContext.servletContext.contextPath}/upload${svo.applyimg}" class="portfolio_img">
                                <div class="content_info">
                                    <div class="content_category">
                                        <c:if test="${svo.category==1}">
                                            IT/프로그래밍
                                        </c:if>
                                        <c:if test="${svo.category==2}">
                                            디자인
                                        </c:if>
                                        <c:if test="${svo.category==3}">
                                            영상음향
                                        </c:if>
                                    </div>
                                    <div class="content_title">
                                            ${svo.subjecttitle}
                                    </div>
                                </div>
                            </div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="pagination-container" style="margin: 0 auto; margin-top: 20px; width: fit-content">
                <div class="pagination" style="display: flex">
                    <div class="paging">
                        <ul class="pagination justify-content-center d-flex">
                            <c:if test="${PagingVO.page > 1}">
                                <li class="page-item"><a class="page-link" href="?page =${PagingVO.page - 1}&uid=${uVO.userid}"><
                                </a></li>
                            </c:if>
                            <c:forEach var="i" begin="${PagingVO.startPage}" end="${PagingVO.startPage + PagingVO.onePageCount - 1}">
                                <c:if test="${i <= PagingVO.totalPage}">
                                    <c:choose>
                                        <c:when test="${i != PagingVO.page}">
                                            <li class="page-item"><a class="page-link" href="?page=${i}&uid=${uVO.userid}
                                                    ">${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link active" href="">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                            <c:if test="${PagingVO.page < PagingVO.totalPage}">
                                <li class="page-item"><a class="page-link" href="?page=${PagingVO.page + 1}&uid=${uVO.userid}">>
                                </a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        </div>
        <div class="container_bottom"></div>
    </div>
</section>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>