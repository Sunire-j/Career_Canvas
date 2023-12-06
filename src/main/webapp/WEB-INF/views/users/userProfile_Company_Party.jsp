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

        .content>li{
            width: 25%;
            margin-top: 30px;
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
        }

        .profile_img {
            float: left;
        }

        .profile_img>img {
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
            margin-left: 40px;
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
    </style>
</head>

<body>
<section>
    <article>
        <div class="profile">
            <div class="profile_img">
                <img src="${pageContext.servletContext.contextPath}/upload${uVO.profileimg}">
            </div>

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
        <div class="salutation">
            <div class="salutation_name">
                소개 글
            </div>
            <div class="salutation_content">
                ${uVO.comment }
            </div>
        </div>
        <div class="portfolio">
            <div class="portfolio_category">
                <button class="btn btn-outline-secondary" onclick="location.href='${pageContext.servletContext.contextPath}/profile/portfolio?uid=${uVO.userid}'">포트폴리오</button>
                <button class="btn btn-secondary" onclick="location.href='${pageContext.servletContext.contextPath}/profile/subject/solo?uid=${uVO.userid}'">기업과제</button>
            </div>
            <div class="solo_party">
                <div></div>
                <div class="solo_party_btn">
                    <button class="btn btn-outline-success" onclick="location.href='${pageContext.servletContext.contextPath}/profile/subject/solo?uid=${uVO.userid}'">개인</button>
                    <button class="btn btn-success" onclick="location.href='${pageContext.servletContext.contextPath}/profile/subject/party?uid=${uVO.userid}'">파티</button>
                </div>
                <div></div>
            </div>
            <div class="portfolio_content">
                <ul class="content" style="width: 1200px; display: flex; flex-wrap: wrap">
                    <c:forEach items="${sVO}" var="svo">
                        <li>
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
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="portfolio_paging">
                <ul class="pagination justify-content-center">
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">Previous</a></li>
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">1</a></li>
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">2</a></li>
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">3</a></li>
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">Next</a></li>
                </ul>
            </div>
        </div>
    </article>
</section>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>