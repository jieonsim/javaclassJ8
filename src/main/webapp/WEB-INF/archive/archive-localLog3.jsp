<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<jsp:include page="/WEB-INF/archive/archive-profile.jsp" />
	<div class="container">
		<div class="archive-container">
			<%-- <div class="row mb-5">
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
			</div> --%>
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
			<div class="container-flud px-0">
				<div class="row no-gutters">
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<div class="image-container">
								<img class="card-img-top" src="${ctp}/images/dummy/newjeans2.jpg" alt="Card image" id="archive-localLog-card-img">
								<i class="ph ph-lock icon-top-right"></i>
							</div>
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-coffee"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<img class="card-img-top" src="${ctp}/images/dummy/newjeans3.jpg" alt="Card image" id="archive-localLog-card-img">
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-image"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<img class="card-img-top" src="${ctp}/images/dummy/newjeans4.jpg" alt="Card image" id="archive-localLog-card-img">
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-mountains"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<img class="card-img-top" src="${ctp}/images/dummy/newjeans2.jpg" alt="Card image" id="archive-localLog-card-img">
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-desk"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<img class="card-img-top" src="${ctp}/images/dummy/newjeans3.jpg" alt="Card image" id="archive-localLog-card-img">
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-martini"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<img class="card-img-top" src="${ctp}/images/dummy/newjeans2.jpg" alt="Card image" id="archive-localLog-card-img">
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-desk"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<img class="card-img-top" src="${ctp}/images/dummy/newjeans3.jpg" alt="Card image" id="archive-localLog-card-img">
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-martini"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<img class="card-img-top" src="${ctp}/images/dummy/newjeans4.jpg" alt="Card image" id="archive-localLog-card-img">
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-dog"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<img class="card-img-top" src="${ctp}/images/dummy/newjeans4.jpg" alt="Card image" id="archive-localLog-card-img">
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-dog"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card" id="archive-localLog-card">
							<img class="card-img-top" src="${ctp}/images/dummy/newjeans4.jpg" alt="Card image" id="archive-localLog-card-img">
							<div class="card-body">
								<h4 class="card-title">에이미테이블</h4>
								<p class="card-text text-muted">
									<i class="ph ph-dog"></i> 경기도, 하남시
								</p>
								<a href="record-localLog.ll" class="stretched-link"></a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="text-center" style="margin-top: 100px;">
				<i class="ph ph-image" style="font-size: 48px"></i>
				<div class="mb-1 mt-3" style="font-weight: bold">콘텐츠가 없습니다.</div>
				<div style="color: dimgray">아직 콘텐츠가 존재하지 않습니다.</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
</body>
</html>