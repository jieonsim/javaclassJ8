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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/signup/signup.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/user/signup/signup.js"></script>
<script src="${ctp}/js/common/basicAlert.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container pt-5">
		<div class="signup-container">
			<h3 class="mb-5">회원가입</h3>
			<hr>
			<form name="signupForm" class="signup-form pl-3 pr-3" method="post" action="${ctp}/signupComplete.s" onsubmit="return validateForm();">
				<div class="form-group row">
					<label for="id" class="col-sm-3 col-form-label">아이디</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력해주세요." autofocus />
						<span class="validation-message">5자 이상 15자 이하의 영문 혹은 영문과 숫자를 조합</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isIdDuplicatedBtn" onclick="checkIdDuplicated()">중복확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-3 col-form-label">비밀번호</label>
					<div class="col-sm-6 text-left">
						<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요." />
						<span class="validation-message">10자 이상, 영문,숫자,특수문자 조합</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="passwordConfirmation" class="col-sm-3 col-form-label">비밀번호 확인</label>
					<div class="col-sm-6 text-left">
						<input type="password" class="form-control" id="passwordConfirmation" name="passwordConfirmation" placeholder="비밀번호를 한번 더 입력해주세요." />
						<span class="validation-message">동일한 비밀번호를 입력</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="nickname" class="col-sm-3 col-form-label">닉네임</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" id="nickname" name="nickname" placeholder="닉네임을 입력해주세요." />
						<span class="validation-message">15자 이하, 영문,숫자,마침표,언더바만 입력 가능</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isNicknameDuplicatedBtn" onclick="checkNicknameDuplicated()">중복확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label for="name" class="col-sm-3 col-form-label">이름</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력해주세요." />
						<span class="validation-message">2자 이상, 한글/영문만 입력 가능</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="email" class="col-sm-3 col-form-label">이메일</label>
					<div class="col-sm-6 text-left">
						<input type="email" class="form-control" id="email" name="email" placeholder="예: ll@locallens.com" />
						<span class="validation-message">이메일 형식에 맞춰 입력해주세요.</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isEmailDuplicatedBtn" onclick="checkEmailDuplicated()">중복확인</button>
					</div>
				</div>
				<hr>
				<div class="form-group row text-center">
					<div class="col-sm-3"></div>
					<div class="col-sm-6 mt-3">
						<button type="submit" class="btn btn-custom form-control" id="signup">회원가입</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
</body>
</html>
