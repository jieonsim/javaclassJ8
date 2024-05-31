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
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive.css" />
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive-localLog.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const links = document.querySelectorAll('.archive-container ul li a');
    const currentPage = window.location.pathname.split('/').pop();

    links.forEach(link => {
        link.addEventListener('click', function() {
            links.forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });

        if (link.getAttribute('href').includes(currentPage)) {
            link.classList.add('active');
        }
    });
});

// 화살표클릭시 화면 상단으로 부드럽게 이동하기
$(window).scroll(function(){
	if($(this).scrollTop() > 100) {
		$("#topBtn").addClass("on");
	}
	else {
		$("#topBtn").removeClass("on");
	}
	
	$("#topBtn").click(function(){
		window.scrollTo({top:0, behavior: "smooth"});
	});
});
</script>
<style>
.carousel-inner img {
	width: 100%;
	/* height: 625px; */ 
	/* height: 500px; */
	height: 100%;
	/* Maintain the aspect ratio */
	object-fit: cover; /* Ensure the image covers the area */
}
    
.card-img-overlay {
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	background: linear-gradient(to bottom, transparent 70%, rgba(0, 0, 0, 0.7) 100%);
	color: white;
	position: absolute;
	bottom: 0;
	width: 100%;
	padding-left: 30px;
	padding-bottom: 45px;
}


.card-title, .card-text {
	/* margin-bottom: 10px; */
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container">
		<div class="archive-container">
			<div class="row mb-5">
				<div class="col-3">
					<div class="photo-placeholder">
						<c:choose>
							<c:when test="${not empty users.profileImage}">
								<img id="profile-photo" src="${ctp}/images/profileImage/${users.profileImage}" alt="Profile Photo" class="profile-photo" />
							</c:when>
							<c:otherwise>
								<span id="profile-icon" class="profile-icon">
									<i class="ph ph-user-focus" id="profileIcon"></i>
								</span>
								<img id="profile-photo" src="" alt="Profile Photo" class="profile-photo d-none" />
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="col-9">
					<div class="mb-3" id="nickname">${users.nickname}</div>
					<c:choose>
						<c:when test="${not empty users.introduction}">
							<div>${users.introduction}</div>
						</c:when>
						<c:otherwise>
							<div>
								<a href="checkPassword.u" id="updateProfileLink">클릭하고 소개 글을 입력해 보세요.</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<ul class="d-flex justify-content-between list-unstyled">
				<li>
					<a href="archive-localLog.a" id="localLog">로컬로그</a>
					<span>${localLogCount}</span>
				</li>
				<li>
					<a href="archive-guestBook.a" id="guestBook">방명록</a>
				</li>
				<li>
					<a href="archive-curation.a" id="curation">큐레이션</a>
				</li>
			</ul>
			<hr>
			<div class="container my-4" style="width: 450px;">
				<div class="d-flex justify-content-between">
					<div>
						<a href="javascript:history.back()" style="text-decoration: none;" class="text-dark">
							<i class="ph ph-caret-left"></i>
						</a>
						<span class="text-dark" style="font-size: 14px;">${localLog.visitDate}&nbsp;방문</span>
					</div>
					<div>
						<a href="#" data-toggle="modal" data-target="#updateLocalLog" class="text-dark" style="text-decoration: none;">
							<i class="ph ph-dots-three" style="font-size: 20px"></i>
						</a>
					</div>
				</div>
				<div class="position-relative" style="width: 100%; margin: auto;">
					<div id="cardCarousel" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators">
							<c:forEach var="photo" items="${localLog.photos.split('/')}" varStatus="status">
								<li data-target="#cardCarousel" data-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}"></li>
							</c:forEach>
						</ol>
						<div class="carousel-inner">
							<c:forEach var="photo" items="${localLog.photos.split('/')}" varStatus="status">
								<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
									<img class="d-block w-100" src="${ctp}/images/localLog/${photo}" alt="Slide ${status.index + 1}">
								</div>
							</c:forEach>
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
						<h4 class="card-title" style="color: white">${localLog.placeName}</h4>
						<p class="card-text" style="color: white">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
					</div>
				</div>
				<c:if test="${not empty localLog.content}">
					<div class="localLogContent-container mt-3">
						<div>${fn:replace(localLog.content, newLine, "<br>")}</div>
					</div>
				</c:if>
			</div>
			<hr>
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