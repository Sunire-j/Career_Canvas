<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start; /* 버튼을 위로 정렬 */
            height: 100vh; /* 화면 높이 전체를 사용하여 가운데 정렬 */
        }

        .button-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: center; /* 가로로 가운데 정렬 */
            gap: 10px; /* 버튼 사이 간격 추가 */
            padding: 15px 0px;
        }

        .button-group > button {
            margin: 0; /* 버튼 간의 여백 제거 */
        }

        #assignment-area {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px; /* 이미지 간격 추가 */
            padding-top: 30px;
        }

        .image-row {
            width: 100%;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .img_area {
            width: 24%; /* 한 줄에 4개씩, 간격 제거 */
            margin-bottom: 10px; /* 아래 여백 추가 */
        }

        .img_area img {
            width: 280px;
        }

        .assignmnet-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .category-tag {
            background-color: #ddd;
            width: auto;
            border-radius: 5px;
            padding: 5px 10px;
        }

        .assignment-title {
            width: 100px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            text-align: center;
            overflow: hidden; /* 텍스트 중앙 정렬 */
        }

        .upload-name {
            width: fit-content;
        }

        #paging {
            width: fit-content;
            margin: 0 auto;
        }

        .pagination > li {
            margin-left: 10px;
        }

        .page-link {
            color: black;
            border-radius: 6px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="button-group">
        <button class="btn btn-outline-secondary">기업 과제</button>
        <button class="btn btn-outline-secondary">제시한 과제</button>
    </div>
    <div class="button-group">
        <button class="btn btn-outline-secondary">전체</button>
        <button class="btn btn-outline-secondary">IT/프로그래밍</button>
        <button class="btn btn-outline-secondary">디자인</button>
        <button class="btn btn-outline-secondary">영상/음향</button>
    </div>
    <div id="assignment-area">
        <div class="image-row">
            <div class="img_area">
                <img src="../../../img/img1.png">
                <div class="assignmnet-info">
                    <div class="category-tag">디자인</div>
                    <div class="assignment-title">***디자인 포트폴리오</div>
                </div>
                <div class="upload-name">홍**</div>
            </div>
            <div class="img_area">
                <img src="../../../img/img2.png">
                <div class="assignmnet-info">
                    <div class="category-tag">IT/프로그래밍</div>
                    <div class="assignment-title">웹사이트 포폴</div>
                </div>
                <div class="upload-name">김**</div>
            </div>
            <div class="img_area">
                <img src="../../../img/img3.png">
                <div class="assignmnet-info">
                    <div class="category-tag">디자인</div>
                    <div class="assignment-title">웹사이트 디자인</div>
                </div>
                <div class="upload-name">남**</div>
            </div>
            <div class="img_area">
                <img src="../../../img/img4.png">
                <div class="assignmnet-info">
                    <div class="category-tag">IT/프로그래밍</div>
                    <div class="assignment-title">***기업 과제</div>
                </div>
                <div class="upload-name">정**</div>
            </div>
        </div>
        <div class="image-row">
            <div class="img_area">
                <img src="../../../img/img2.png">
                <div class="assignmnet-info">
                    <div class="category-tag">디자인</div>
                    <div class="assignment-title">웹사이트 디자인</div>
                </div>
                <div class="upload-name">송**</div>
            </div>
            <div class="img_area">
                <img src="../../../img/img1.png">
                <div class="assignmnet-info">
                    <div class="category-tag">IT/프로그래밍</div>
                    <div class="assignment-title">***기업 과제</div>
                </div>
                <div class="upload-name">조**</div>
            </div>
            <div class="img_area">
                <img src="../../../img/img4.png">
                <div class="assignmnet-info">
                    <div class="category-tag">디자인</div>
                    <div class="assignment-title">***디자인 포트폴리오</div>
                </div>
                <div class="upload-name">김**</div>
            </div>
            <div class="img_area">
                <img src="../../../img/img3.png">
                <div class="assignmnet-info">
                    <div class="category-tag">IT/프로그래밍</div>
                    <div class="assignment-title">***기업 홈페이지</div>
                </div>
                <div class="upload-name">이**</div>
            </div>
        </div>
        <div class="image-row">
            <div class="img_area">
                <img src="../../../img/img4.png">
                <div class="assignmnet-info">
                    <div class="category-tag">IT/프로그래밍</div>
                    <div class="assignment-title">***기업 웹사이트</div>
                </div>
                <div class="upload-name">방**</div>
            </div>
            <div class="img_area">
                <img src="../../../img/img3.png">
                <div class="assignmnet-info">
                    <div class="category-tag">디자인</div>
                    <div class="assignment-title">웹사이트 디자인</div>
                </div>
                <div class="upload-name">기**</div>
            </div>
            <div class="img_area">
                <img src="../../../img/img1.png">
                <div id="assignmnet-info">
                    <div class="category-tag">IT/프로그래밍</div>
                    <div class="assignment-title">***기업 과제</div>
                </div>
                <div class="upload-name">이**</div>
            </div>
            <div class="img_area">
                <img src="../../../img/img2.png">
                <div class="assignmnet-info">
                    <div class="category-tag">디자인</div>
                    <div class="assignment-title">***디자인 포트폴리오</div>
                </div>
                <div class="upload-name">홍**</div>
            </div>
        </div>
    </div>
    <div id="paging" class="mt-3">
        <ul class="pagination">
            <li class="page-item disabled"><a class="page-link" href="#"><</a></li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">></a></li>
        </ul>
    </div>
</div>
</body>
</html>