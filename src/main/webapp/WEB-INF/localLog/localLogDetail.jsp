<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
pageContext.setAttribute("newLine", "\n");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Lens</title>
<jsp:include page="/WEB-INF/include/bs4.jsp" />
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<style>
#topBtn {
	position: fixed;
	right: 10%;
	bottom: 3%;
	transition: 0.7s ease;
}

.on {
	/*opacity: 0.8;*/
	cursor: pointer;
	bottom: 0;
}

#arrowUp {
	font-size: 45px;
	color: gainsboro;
}

.carousel-inner {
	position: relative;
}

.gradient-overlay {
	position: absolute;
	bottom: 0;
	left: 0;
	width: 100%;
	height: 70%;
	background: linear-gradient(to top, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0));
	z-index: 1;
}

.card-img-overlay {
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	position: absolute;
	bottom: 20px;
	left: 20px;
	z-index: 2;
	width: calc(100% - 20px);
	/* Adjust to leave space from the right side */
}

.card-title, .card-text {
	color: white;
	margin: 0; /* Ensure no default margin */
}

#localLogBookmark {
	position: absolute;
	bottom: 10px; right : 10px;
	font-size: 28px; /* Adjust the size as needed */
	color: black;
	right: 10px; /* Adjust the color as needed */
}

.guestbook-container {
    border: 1px dashed #ccc;
    padding: 15px;
    margin-top: 15px;
    border-radius: 5px;
    text-align: center;
}

.guestbook-question {
    font-size: 16px;
    margin: 0px;
    padding-top: 10px;
}

.guestbook-instruction {
    color: #888;
    margin-top: 0px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 14px;
}

.guestbook-instruction i {
    margin-left: 5px;
}
</style>
<script>
	// 화살표클릭시 화면 상단으로 부드럽게 이동하기
	$(window).scroll(function() {
		if ($(this).scrollTop() > 100) {
			$("#topBtn").addClass("on");
		} else {
			$("#topBtn").removeClass("on");
		}

		$("#topBtn").click(function() {
			window.scrollTo({
				top : 0,
				behavior : "smooth"
			});
		});
	});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mx-auto" style="width: 700px; padding-top: 50px;">
		<div class="row">
			<div class="col-md-6">
				<div id="cardCarousel" class="carousel slide" data-ride="carousel">
					<ul class="carousel-indicators">
						<li data-target="#cardCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#cardCarousel" data-slide-to="1"></li>
						<li data-target="#cardCarousel" data-slide-to="2"></li>
					</ul>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img class="d-block w-100" src="${ctp}/images/dummy/1.jpg" alt="Image 1">
							<div class="gradient-overlay"></div>
						</div>
						<div class="carousel-item">
							<img class="d-block w-100" src="${ctp}/images/dummy/2.jpg" alt="Image 2">
							<div class="gradient-overlay"></div>
						</div>
						<div class="carousel-item">
							<img class="d-block w-100" src="${ctp}/images/dummy/3.jpg" alt="Image 3">
							<div class="gradient-overlay"></div>
						</div>
					</div>
					<a class="carousel-control-prev" href="#cardCarousel" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#cardCarousel" role="button" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				<div class="card-img-overlay">
					<div class="card-title" style="font-size: 20px;">
						<b>무등</b>
					</div>
					<div class="card-text" style="font-size: 14px;">광주, 남구 · 카페</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="d-flex align-items-center">
					<a href="#">
						<img src="${ctp}/images/dummy/newjeans1.jpg" alt="User Profile" class="rounded-circle" style="width: 40px; height: 40px; margin-right: 10px;">
					</a>
					<img src="${ctp}/images/dummy/newjeans2.jpg" alt="User Profile" class="rounded-circle" style="width: 40px; height: 40px; margin-right: 10px;">
					<img src="${ctp}/images/dummy/newjeans3.jpg" alt="User Profile" class="rounded-circle" style="width: 40px; height: 40px; margin-right: 10px;">
					<img src="${ctp}/images/dummy/newjeans4.jpg" alt="User Profile" class="rounded-circle" style="width: 40px; height: 40px; margin-right: 10px;">
				</div>
				<hr>
				<div class="d-flex align-items-center mb-3">
					<a href="#">
						<img src="${ctp}/images/dummy/newjeans4.jpg" alt="User Profile" class="rounded-circle" style="width: 40px; height: 40px; margin-right: 10px;">
					</a>
					<div>
						<div style="font-size: 18px; font-weight: bold;">localLog</div>
						<div class="text-muted" style="font-size: 14px;">2024년 6월 2일 방문</div>
					</div>
				</div>
				<div class="mb-3">
					<p>로컬로그 컨텐츠 내용이 있을 자리ㅣㅣㅣ</p>
				</div>
				<a href="#">
					<i class="ph ph-bookmark-simple" id="localLogBookmark"></i>
				</a>
			</div>
		</div>
		<hr>
		<div class="row mt-3 pb-5">
			<div class="col-12">
				<div class="mb-1">공간 정보</div>
				<p style="font-size: 14px;"><span><b>로컬로그</b></span>님이 처음으로 발견한 공간이에요!</p>
					<div class="guestbook-container">
					<a href="#" style="text-decoration: none;">
						<span class="guestbook-question" style="color: black;">이 공간에 방문해본 적 있나요?</span>
						<span class="guestbook-instruction">
							다음 방문자를 도와 줄 방명록 남기기 <i class="ph ph-pencil-simple"></i>
						</span>
					</a>
				</div>
			</div>
		</div>
		<!-- 위로가기 버튼 -->
		<div id="topBtn" class="">
			<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
</body>
</html>