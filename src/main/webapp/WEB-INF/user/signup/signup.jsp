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
</head>
<script>
	$(document).ready(function() {
		// Regular expressions for validation based on the new rules
		const idRegex = /^[a-z][a-z0-9]{4,14}$/;
		const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;
		const nicknameRegex = /^[a-z0-9._]{1,30}$/;
		const nameRegex = /^(?:[a-z]{2,50}|[가-힣]{2,50})$/;
		const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

		// Function to validate input and toggle span visibility
		function validateInput(input, regex, span) {
			if (!regex.test(input.value)) {
				span.style.display = 'inline';
			} else {
				span.style.display = 'none';
			}
		}

		// ID validation
		$('#id').on('input', function() {
			validateInput(this, idRegex, this.nextElementSibling);
		});

		// Password validation
		$('input[name="password"]').on('input', function() {
			validateInput(this, passwordRegex, this.nextElementSibling);
		});

		// Nickname validation
		$('input[name="nickname"]').on('input', function() {
			validateInput(this, nicknameRegex, this.nextElementSibling);
		});

		// Name validation
		$('input[name="name"]').on('input', function() {
			validateInput(this, nameRegex, this.nextElementSibling);
		});

		// Email validation
		$('input[name="email"]').on('input', function() {
			validateInput(this, emailRegex, this.nextElementSibling);
		});
	});

	function isIdDuplicated() {
		const id = $('#id').val();
		$.ajax({
			url : 'checkIdDuplicated.s',
			type : 'POST',
			data : {
				id : id
			},
			success : function(response) {
				if (response === 'duplicated') {
					alert('이미 사용 중인 ID입니다.');
				} else {
					alert('사용 가능한 ID입니다.');
				}
			}
		});
	}

	function isNicknameDuplicated() {
		const nickname = $('input[name="nickname"]').val();
		$.ajax({
			url : '/checkNicknameDuplicated',
			type : 'POST',
			data : {
				nickname : nickname
			},
			success : function(response) {
				if (response === 'duplicated') {
					alert('이미 사용 중인 닉네임입니다.');
				} else {
					alert('사용 가능한 닉네임입니다.');
				}
			}
		});
	}

	function isEmailDuplicated() {
		const email = $('input[name="email"]').val();
		$.ajax({
			url : '/checkEmailDuplicated',
			type : 'POST',
			data : {
				email : email
			},
			success : function(response) {
				if (response === 'duplicated') {
					alert('이미 사용 중인 이메일입니다.');
				} else {
					alert('사용 가능한 이메일입니다.');
				}
			}
		});
	}
</script>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container pt-5">
		<div class="signup-container">
			<h3 class="mb-5">회원가입</h3>
			<hr>
			<form class="signup-form pl-3 pr-3" method="post" action="signupComplete.s">
				<div class="form-group row">
					<label for="id" class="col-sm-3 col-form-label">아이디</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력해주세요." autofocus required />
						<span class="validation-message">5자 이상 15자 이하의 영문 혹은 영문과 숫자를 조합</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isIdDuplicated" onclick="isIdDuplicated()">중복확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-3 col-form-label">비밀번호</label>
					<div class="col-sm-6 text-left">
						<input type="password" class="form-control" name="password" placeholder="비밀번호를 입력해주세요." required />
						<span class="validation-message">10자 이상, 영문,숫자,특수문자 조합</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-3 col-form-label">비밀번호 확인</label>
					<div class="col-sm-6 text-left">
						<input type="password" class="form-control" name="password" placeholder="비밀번호를 한번 더 입력해주세요." required />
						<span class="validation-message">동일한 비밀번호를 입력</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="nickname" class="col-sm-3 col-form-label">닉네임</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" name="nickname" placeholder="닉네임을 입력해주세요." required />
						<span class="validation-message">15자 이하, 영문,숫자,마침표,언더바만 입력 가능</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isNicknameDuplicated" onclick="isNicknameDuplicated()">중복확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label for="name" class="col-sm-3 col-form-label">이름</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" name="name" placeholder="이름을 입력해주세요." required />
						<span class="validation-message">2자 이상, 한글 또는 영어만 입력 가능</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="email" class="col-sm-3 col-form-label">이메일</label>
					<div class="col-sm-6 text-left">
						<input type="email" class="form-control" name="email" placeholder="예: ll@locallens.com" required />
						<span class="validation-message">이메일 형식에 맞춰 입력해주세요.</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isEmailDuplicated" onclick="isEmailDuplicated()">중복확인</button>
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
</body>
</html>