<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판 목록</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<style>
		body {
			max-width: 1200px;
			margin: 0 auto;
		}

		h2 {
			float: left;
			margin: 0 auto;
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
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
		</div>
		<hr>
		<div class="board-row">
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
		</div>
		<hr>
		<div class="board-row">
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
		</div>
		<hr>
		<div class="board-row">
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
		</div>
		<hr>
		<div class="board-row">
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
		</div>
		<hr>
		<div class="board-row">
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
		</div>
		<hr>
		<div class="board-row">
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
		</div>
		<hr>
		<div class="board-row">
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
		</div>
		<hr>
		<div class="board-row">
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
		</div>
		<hr>
		<div class="board-row">
			<div class="num" style="width: 10%" class="list">1</div>
			<div class="title"
				 style="width: 42%; text-align: left; padding: 0 20px" class="list">게시물
				제목 1</div>
			<div class="user" style="width: 16%" class="list">작성자 1</div>
			<div class="view" style="width: 16%" class="list">100</div>
			<div class="comment" style="width: 16%" class="list">5</div>
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
			<a href="${pageContext.servletContext.contextPath}/board/write" class="write-button">글쓰기</a>
		</div>
	</div>
</div>
<footer> </footer>
</body>
</html>