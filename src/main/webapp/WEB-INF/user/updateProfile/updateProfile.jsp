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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/updateProfile/updateProfile.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script type="text/javascript">
	var sessionNickname = "${sessionNickname}";
	var sessionEmail = "${sessionEmail}";
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container pt-5">
		<div class="updateProfile-container">
			<h3 class="mb-5">프로필 수정</h3>
			<hr>
			<!-- <form name="updateProfileForm" class="updateProfile-form pl-3 pr-3" method="post" action="tryToUpdateProfile.u" onsubmit="return validateForm();" enctype="multipart/form-data"> -->
			<form name="updateProfileForm" class="updateProfile-form pl-3 pr-3" method="post" action="${ctp}/tryToUpdateProfile" onsubmit="return validateForm();" enctype="multipart/form-data">
				<input type="hidden" name="userIdx" value="${sessionScope.sessionUserIdx}">
				<div class="form-group row justify-content-center">
					<div class="col-sm-6">
						<div class="photo-section text-center">
							<label for="photo-upload" class="photo-placeholder">
								<c:choose>
									<c:when test="${not empty userVO.profileImage}">
										<img id="profile-photo" src="${ctp}/images/profileImage/${userVO.profileImage}" alt="Profile Photo" class="profile-photo" />
									</c:when>
									<c:otherwise>
										<span id="profile-icon" class="profile-icon">
											<i class="ph ph-user"></i>
										</span>
										<img id="profile-photo" src="" alt="Profile Photo" class="profile-photo d-none" />
									</c:otherwise>
								</c:choose>
								<i class="ph-fill ph-camera camera-icon"></i>
							</label>
							<input type="file" id="photo-upload" name="photo-upload" class="d-none" onchange="previewPhoto(event)" />
						</div>
					</div>
				</div>
				<div class="form-group row">
					<label for="id" class="col-sm-3 col-form-label">아이디</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="id" name="id" value="${userVO.id}" readonly />
					</div>
				</div>
				<div class="form-group row">
					<label for="newPassword" class="col-sm-3 col-form-label">새 비밀번호</label>
					<div class="col-sm-6 text-left">
						<input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="새 비밀번호를 입력해주세요." />
						<span class="validation-message">10자 이상, 영문,숫자,특수문자 조합</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="newPasswordConfirmation" class="col-sm-3 col-form-label">새로운 비밀번호 확인</label>
					<div class="col-sm-6 text-left">
						<input type="password" class="form-control" id="newPasswordConfirmation" name="newPasswordConfirmation" placeholder="새 비밀번호를 다시 입력해주세요." />
						<span class="validation-message">동일한 비밀번호를 입력</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="nickname" class="col-sm-3 col-form-label">닉네임</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" name="nickname" id="nickname" value="${userVO.nickname}" />
						<span class="validation-message">15자 이하, 영문,숫자,마침표,언더바만 입력 가능</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isNicknameDuplicatedBtn" onclick="checkNicknameDuplicated()">중복확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label for="introduction" class="col-sm-3 col-form-label">소개</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" name="introduction" id="introduction" value="${userVO.introduction}" placeholder="소개글을 입력해 주세요." />
						<span class="validation-message">소개글은 50자 이하 입력</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="name" class="col-sm-3 col-form-label">이름</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" name="name" id="name" value="${userVO.name}" />
						<span class="validation-message">2자 이상, 한글/영문만 입력 가능</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="email" class="col-sm-3 col-form-label">이메일</label>
					<div class="col-sm-6 text-left">
						<input type="email" class="form-control" name="email" id="email" value="${userVO.email}" />
						<span class="validation-message">이메일 형식에 맞춰 입력해주세요.</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isEmailDuplicatedBtn" onclick="checkEmailDuplicated()">중복확인</button>
					</div>
				</div>
				<hr>
				<div class="form-group row text-center">
					<div class="col-sm-3"></div>
					<div class="col-3">
						<button onclick="location.href='leave.lv'" type="button" class="btn btn-custom form-control" id="leave">탈퇴하기</button>
					</div>
					<div class="col-3">
						<button type="submit" class="btn btn-custom form-control" id="update">저장</button>
					</div>
					<div class="col-sm-3"></div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<script src="${ctp}/js/user/updateProfile/updateProfile.js"></script>
</body>
</html>