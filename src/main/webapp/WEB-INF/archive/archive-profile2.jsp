<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive.css" />
<script>
document.addEventListener("DOMContentLoaded", function() {
    const links = document.querySelectorAll('#archive-container ul li a');
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
<div class="media my-5">
	<div class="photo-placeholder mr-4">
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
	<div class="media-body">
		<div class="nickname-container">
			<c:if test="${users.visibility == 'private'}">
				<i class="ph ph-lock"></i>
			</c:if>
			<span id="nickname">${users.nickname}</span>
		</div>
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

<%-- <div class="row my-5">
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
		<div class="nickname-container">
			<c:if test="${users.visibility == 'private'}">
				<i class="ph ph-lock"></i>
			</c:if>
			<span id="nickname">${users.nickname}</span>
		</div>
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
<ul class="d-flex justify-content-between list-unstyled pb-3">
	<li>
		<a href="archive-localLog.a" id="localLog">로컬로그</a>
		<c:if test="${not empty localLogs}">
			<span>${localLogCount}</span>
		</c:if>
	</li>
	<li>
		<a href="archive-guestBook.a" id="guestBook">방명록</a>
		<c:if test="${not empty guestBooks}">
			<span>${guestBookCount}</span>
		</c:if>
	</li>
	<li>
		<a href="#" id="curation">큐레이션</a>
	</li>
</ul>