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
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container pt-5">
		<div class="updateProfile-container">
			<h3 class="mb-5">내 정보 수정</h3>
			<hr>
			<form class="updateProfile-form pl-3 pr-3" method="post" action="">
				<div class="form-group row">
					<label for="id" class="col-sm-3 col-form-label">아이디</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="id" name="id" value="admin" readonly />
					</div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-3 col-form-label">현재 비밀번호</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="비밀번호를 입력해주세요." />
						<span>10자 이상, 영문/숫자/특수문자 중 2개 이상 조합</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-3 col-form-label">새 비밀번호</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="새 비밀번호를 입력해주세요." />
						<span>10자 이상, 영문/숫자/특수문자 중 2개 이상 조합</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-3 col-form-label">새로운 비밀번호 확인</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" placeholder="새 비밀번호를 다시 입력해주세요." />
						<span>동일한 비밀번호를 입력</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="nickname" class="col-sm-3 col-form-label">닉네임</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="nickname" id="nickname" value="locallens" />
						<!-- <span>이미 사용 중인 닉네임입니다.</span> -->
						<span>15자 이하, 영문/숫자/마침표/언더바만 입력 가능</span>
					</div>
					<div class="col-sm-3">
						<button type="submit" class="btn btn-custom form-control" id="isNicknameDuplicated">중복확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label for="nickname" class="col-sm-3 col-form-label">소개</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="introduction" id="introduction" placeholder="소개글을 입력해 주세요." />
					</div>
				</div>
				<div class="form-group row">
					<label for="name" class="col-sm-3 col-form-label">이름</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="name" id="name" value="심지언" />
					</div>
				</div>
				<div class="form-group row">
					<label for="email" class="col-sm-3 col-form-label">이메일</label>
					<div class="col-sm-6">
						<input type="email" class="form-control" name="email" id="email" value="ll@locallens.com" />
					</div>
					<div class="col-sm-3">
						<button type="submit" class="btn btn-custom form-control" id="isEmailDuplicated">중복확인</button>
					</div>
				</div>
				<hr>
				<div class="form-group row text-center">
					<div class="col-sm-3"></div>
					<div class="col-3">
						<button onclick="location.href='leave.lv'" type="button" class="btn btn-custom form-control" id="leave">탈퇴하기</button>
					</div>
					<div class="col-3">
						<button type="submit" class="btn btn-custom form-control" id="update">회원정보수정</button>
					</div>
					<div class="col-sm-3"></div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
