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
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container">
		<div class="archive-container">
			<div class="row mb-5">
				<div class="col-2">
					<i class="ph ph-user-focus" id="profileNoimage"></i>
					<%-- <img src="${ctp}/images/pds/user/${mVo.photo}" width="200px"/> --%>
				</div>
				<div class="col-10">
					<div id="nickname">${sessionNickname}</div>
					<c:if test="${empty userVO.introduction}">
						<div>
							<a href="updateProfile-checkPassword.u" id="updateProfile">클릭하고 소개 글을 입력해 보세요.</a>
						</div>
					</c:if>
					<c:if test="${not empty userVO.introduction}">
						<div>
							<a href="updateProfile-checkPassword.u" id="updateProfile">${userVO.introduction}</a>
						</div>
					</c:if>
				</div>
			</div>
			<ul class="d-flex justify-content-between list-unstyled">
				<li>
					<a href="archive-localLog.a" id="localLog">로컬로그</a>
				</li>
				<li>
					<a href="archive-guestBook.a" id="guestBook">방명록</a>
				</li>
				<li>
					<a href="archive-curation.a" id="curation">큐레이션</a>
				</li>
			</ul>
			<div class="text-center" style="margin-top: 100px;">
				<div class="mb-2">내가 방문한 공간을 기록해보세요.</div>
				<button class="btn btn-custom" id="firstRecord" onclick="location.href='record-localLog.ll'">첫 로컬로그 남기기</button>
			</div>
			<div class="text-center" style="margin-top: 100px;">
				<i class="ph ph-image" style="font-size: 48px"></i>
				<div class="mb-1 mt-3" style="font-weight: bold">콘텐츠가 없습니다.</div>
				<div style="color: dimgray">아직 콘텐츠가 존재하지 않습니다.</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="message" value="message" />
	<input type="hidden" id="url" value="url" />
</body>
</html>