
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
body {
	max-width: 1200px;
	margin: 0 auto;
}

header, footer {
	background-color: #333;
	color: #fff;
	padding: 10px;
}

h2 {
	float: left;
	margin: 0 auto;
	padding: auto;
}

.container {
	text-align: center;
}

.button-container {
	margin-top: 20px;
}

.button {
	display: inline-block;
	margin: 0 10px;
	padding: 5px 10px;
	color: #000;
	text-decoration: none;
	border: 1px solid #ddd;
	border-radius: 5px;
	transition: background-color 0.3s, color 0.3s;
}

.board-container {
	padding: 10px;
	border-radius: 5px;
	margin-top: 20px;
}

.board-header {
	font-weight: bold;
}

.board-row {
	display: flex;
	width: 100%;
}

.header-row {
	display: flex;
}

.search-container, .search-button {
	display: inline-block;
}

.write-button {
	display: inline-block;
	margin: 5px;
	padding: 5px 10px;
	color: #fff;
	font-size: 12px;
	border: 1px solid #ddd;
	text-decoration: none;
	background-color: #3f4eb1;
}

.search-container {
	background-color: #f2f2f2;
}

.search-box {
	width: 150px;
	display: inline-block;
	color: #000;
	font-size: 12px;
	border: 1px solid #ddd;
}

.search-button {
	background-color: #4CAF50;
	color: white;
}

.pagination-container {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-top: 20px;
	text-align: center;
}

.pagination {
	display: inline-block;
}

.pagination a {
	color: black;
	float: left;
	padding: 6px 12px;
	text-decoration: none;
}

.pagination a.active {
	background-color: #4CAF50;
	color: white;
}

.pagination a:hover:not(.active) {
	background-color: #ddd;
}
</style>
</head>
<body>
	<header> </header>
	<div class="container">
		<div class="button-container">
			<a href="javascript:void(0);" class="btn btn-primary">전체</a>
			<a href="javascript:void(0);" class="btn btn-outline-primary">IT/프로그래밍</a>
			<a href="javascript:void(0);" class="btn btn-outline-primary">디자인</a>
			<a href="javascript:void(0);" class="btn btn-outline-primary">영상/음향</a>
		</div>
		<hr />
		<h2>전체 게시판</h2>
		<br> <br>
		<div class="board-container">
			<div class="board-header">
				<div class="header-row">
					<div id="num" style="width: 10%" class="list">번호</div>
					<div id="title"
						style="width: 42%; text-align: left; padding: 0 20px;"
						class="list">제목</div>
					<div id="user" style="width: 16%" class="list">작성자</div>
					<div id="view" style="width: 16%" class="list">조회수</div>
					<div id="comment" style="width: 16%" class="list">댓글</div>
				</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">1</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 1</div>
				<div id="user" style="width: 16%" class="list">작성자 1</div>
				<div id="view" style="width: 16%" class="list">100</div>
				<div id="comment" style="width: 16%" class="list">5</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">2</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 2</div>
				<div id="user" style="width: 16%" class="list">작성자 2</div>
				<div id="view" style="width: 16%" class="list">75</div>
				<div id="comment" style="width: 16%" class="list">2</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">3</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 3</div>
				<div id="user" style="width: 16%" class="list">작성자 3</div>
				<div id="view" style="width: 16%" class="list">250</div>
				<div id="comment" style="width: 16%" class="list">5</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">4</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 4</div>
				<div id="user" style="width: 16%" class="list">작성자 4</div>
				<div id="view" style="width: 16%" class="list">300</div>
				<div id="comment" style="width: 16%" class="list">5</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">5</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 5</div>
				<div id="user" style="width: 16%" class="list">작성자 5</div>
				<div id="view" style="width: 16%" class="list">120</div>
				<div id="comment" style="width: 16%" class="list">68</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">6</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 6</div>
				<div id="user" style="width: 16%" class="list">작성자 6</div>
				<div id="view" style="width: 16%" class="list">130</div>
				<div id="comment" style="width: 16%" class="list">32</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">4</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 4</div>
				<div id="user" style="width: 16%" class="list">작성자 4</div>
				<div id="view" style="width: 16%" class="list">300</div>
				<div id="comment" style="width: 16%" class="list">5</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">4</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 4</div>
				<div id="user" style="width: 16%" class="list">작성자 4</div>
				<div id="view" style="width: 16%" class="list">300</div>
				<div id="comment" style="width: 16%" class="list">5</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">4</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 4</div>
				<div id="user" style="width: 16%" class="list">작성자 4</div>
				<div id="view" style="width: 16%" class="list">300</div>
				<div id="comment" style="width: 16%" class="list">5</div>
			</div>
			<hr>
			<div class="board-row">
				<div id="num" style="width: 10%" class="list">4</div>
				<div id="title"
					style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
					제목 4</div>
				<div id="user" style="width: 16%" class="list">작성자 4</div>
				<div id="view" style="width: 16%" class="list">300</div>
				<div id="comment" style="width: 16%" class="list">5</div>
			</div>
			<hr>
			<div class="search-container">
					<input type="text" class="search-box form-control" placeholder="검색어를 입력하세요">
					<button class="btn btn-success">검색</button>
				</div>
			<div class="pagination-container">
				<div></div>
				<div class="pagination">
					<a href="#" class="active">1</a> <a href="#">2</a> <a href="#">3</a>
					<a href="#">4</a>
				</div>
				<a href="write.html" class="write-button">글쓰기</a>
			</div>
		</div>
	</div>
	<footer> </footer>
</body>
</html>