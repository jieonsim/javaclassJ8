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
			<c:when test="${not empty user.profileImage}">
				<img id="profile-photo" src="${ctp}/images/profileImage/${user.profileImage}" alt="Profile Photo" class="profile-photo" />
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
			<c:if test="${user.visibility == 'private'}">
				<i class="ph ph-lock"></i>
			</c:if>
			<span id="nickname">${user.nickname}</span>
		</div>
		<c:choose>
			<c:when test="${not empty user.introduction}">
				<div>${user.introduction}</div>
			</c:when>
		</c:choose>
	</div>
</div>
<ul class="d-flex justify-content-between list-unstyled">
	<li>
		<a href="profileLocalLog.p?userIdx=${user.userIdx}" id="localLog">로컬로그</a>
		<c:if test="${not empty localLogs}">
			<span>${localLogCount}</span>
		</c:if>
	</li>
	<li>
		<a href="profileGuestbook.p?userIdx=${user.userIdx}" id="guestBook">방명록</a>
		<c:if test="${not empty guestBooks}">
			<span>${guestBookCount}</span>
		</c:if>
	</li>
	<li>
		<a href="#" id="curation">큐레이션</a>
	</li>
</ul>
<%-- <c:if test="${user.visibility == 'private'}">
	<div class="text-center" style="margin-top: 100px;">
		<i class="ph ph-lock" style="font-size: 48px"></i>
		<div class="mb-1 mt-3" style="color: dimgray">비공개 계정입니다.</div>
	</div>
</c:if> --%>