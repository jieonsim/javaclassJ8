<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<div class="container">
	<div class="profile-container" style="max-width: 700px; margin: auto; padding: 20px;">
		<div class="row">
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
	</div>
</div>