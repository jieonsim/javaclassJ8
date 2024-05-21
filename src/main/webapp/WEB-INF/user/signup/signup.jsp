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
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container pt-5">
		<div class="signup-container">
			<h3 class="mb-5">회원가입</h3>
			<hr>
			<!-- 메시지 알럿 표시 및 URL 이동 시작 -->
			<c:if test="${not empty message}">
				<div class="alert alert-success" role="alert">${message}</div>
				<script>
					alert("${message}");
					// URL이 있는 경우 리디렉션 처리
					<c:if test="${not empty url}">
					window.location.href = "${ctp}/${url}";
					</c:if>
				</script>
			</c:if>
			<form name="signupForm" class="signup-form pl-3 pr-3" method="post" action="${ctp}/signupComplete.s" onsubmit="return validateForm();">
				<div class="form-group row">
					<label for="id" class="col-sm-3 col-form-label">아이디</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력해주세요." autofocus required />
						<span class="validation-message" style="display: none;">5자 이상 15자 이하의 영문 혹은 영문과 숫자를 조합</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isIdDuplicatedBtn" onclick="checkIdDuplicated()">중복확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-3 col-form-label">비밀번호</label>
					<div class="col-sm-6 text-left">
						<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요." required />
						<span class="validation-message">10자 이상, 영문,숫자,특수문자 조합</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="passwordConfirmation" class="col-sm-3 col-form-label">비밀번호 확인</label>
					<div class="col-sm-6 text-left">
						<input type="password" class="form-control" id="passwordConfirmation" name="passwordConfirmation" placeholder="비밀번호를 한번 더 입력해주세요." required />
						<span class="validation-message">동일한 비밀번호를 입력</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="nickname" class="col-sm-3 col-form-label">닉네임</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" id="nickname" name="nickname" placeholder="닉네임을 입력해주세요." required />
						<span class="validation-message">15자 이하, 영문,숫자,마침표,언더바만 입력 가능</span>
					</div>
					<div class="col-sm-3">
						<button type="button" class="btn btn-custom form-control" id="isNicknameDuplicatedBtn" onclick="checkNicknameDuplicated()">중복확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label for="name" class="col-sm-3 col-form-label">이름</label>
					<div class="col-sm-6 text-left">
						<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력해주세요." required />
						<span class="validation-message">2자 이상, 한글/영문만 입력 가능</span>
					</div>
				</div>
				<div class="form-group row">
					<label for="email" class="col-sm-3 col-form-label">이메일</label>
					<div class="col-sm-6 text-left">
						<input type="email" class="form-control" id="email" name="email" placeholder="예: ll@locallens.com" required />
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
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const idRegex = /^[a-z][a-z0-9]{4,14}$/;
			const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;
			const nicknameRegex = /^[a-z0-9._]{2,30}$/;
			const nameRegex = /^(?:[a-z]{2,50}|[가-힣]{2,50})$/;
			const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

			document.getElementById('id').addEventListener('input', function() {
				validateInput(this, idRegex);
				activateButton(document.getElementById('isIdDuplicatedBtn'));
			});

			document.querySelector('input[name="password"]').addEventListener('input', function() {
				validateInput(this, passwordRegex);
				validatePasswordConfirmation();
			});

			document.querySelector('input[name="nickname"]').addEventListener('input', function() {
				validateInput(this, nicknameRegex);
				activateButton(document.getElementById('isNicknameDuplicatedBtn'));
			});

			document.querySelector('input[name="name"]').addEventListener('input', function() {
				validateInput(this, nameRegex);
			});

			document.querySelector('input[name="email"]').addEventListener('input', function() {
				validateInput(this, emailRegex);
				activateButton(document.getElementById('isEmailDuplicatedBtn'));
			});

			document.querySelector('input[name="passwordConfirmation"]').addEventListener('input', validatePasswordConfirmation);
		});

		function validateInput(input, regex) {
			const span = input.nextElementSibling;
			if (!regex.test(input.value)) {
				span.style.display = 'inline';
			} else {
				span.style.display = 'none';
			}
		}

		function validatePasswordConfirmation() {
			const password = document.querySelector('input[name="password"]').value;
			const passwordConfirmation = document.querySelector('input[name="passwordConfirmation"]').value;
			const span = document.querySelector('input[name="passwordConfirmation"]').nextElementSibling;
			if (password !== passwordConfirmation && passwordConfirmation !== "") {
				span.style.display = 'inline';
			} else {
				span.style.display = 'none';
			}
		}

		function activateButton(button) {
			button.classList.remove('disabled');
			button.disabled = false;
		}

		function deactivateButton(button) {
			button.classList.add('disabled');
			button.disabled = true;
		}

		let idChecked = false;
		let nicknameChecked = false;
		let emailChecked = false;

		function checkIdDuplicated() {
			const id = document.forms["signupForm"].id.value.trim();
			const idRegex = /^[a-z][a-z0-9]{4,14}$/;

			if (id === "") {
				alert("아이디를 입력하세요.");
				document.forms["signupForm"].id.focus();
				return;
			}

			if (!idRegex.test(id)) {
				alert("5자 이상 15자 이하의 영문 혹은 영문과 숫자를 조합");
				document.forms["signupForm"].id.focus();
			} else {
				$.ajax({
					url : '${ctp}/checkIdDuplicated.s',
					type : 'POST',
					data : {
						id : id
					},
					success : function(response) {
						if (response === 'duplicated') {
							alert('이미 사용 중인 아이디입니다.');
							document.forms["signupForm"].id.focus();
							idChecked = false;
							activateButton(document.getElementById('isIdDuplicatedBtn'));
						} else if (response === 'available') {
							alert('사용 가능한 아이디입니다.');
							idChecked = true;
							deactivateButton(document.getElementById('isIdDuplicatedBtn'));
						} else if (response === 'Invalid ID') {
							alert('잘못된 ID입니다.');
							document.forms["signupForm"].id.focus();
						} else {
							console.error("Unexpected response:", response);
							alert("예상치 못한 응답: " + response);
						}
					},
					error : function() {
						alert("전송 오류");
					}
				});
			}
		}

		function checkNicknameDuplicated() {
			const nickname = document.forms["signupForm"].nickname.value.trim();
			const nicknameRegex = /^[a-z0-9._]{1,30}$/;

			if (nickname === "") {
				alert("닉네임을 입력하세요.");
				document.forms["signupForm"].nickname.focus();
				return;
			}

			if (!nicknameRegex.test(nickname)) {
				alert("2자 이상 30자 이하의 영문, 숫자, 마침표, 언더바만 입력 가능");
				document.forms["signupForm"].nickname.focus();
			} else {
				$.ajax({
					url : '${ctp}/checkNicknameDuplicated.s',
					type : 'POST',
					data : {
						nickname : nickname
					},
					success : function(response) {
						if (response === 'duplicated') {
							alert('이미 사용 중인 닉네임입니다.');
							document.forms["signupForm"].nickname.focus();
							nicknameChecked = false;
							activateButton(document.getElementById('isNicknameDuplicatedBtn'));
						} else if (response === 'available') {
							alert('사용 가능한 닉네임입니다.');
							nicknameChecked = true;
							deactivateButton(document.getElementById('isNicknameDuplicatedBtn'));
						} else if (response === 'Invalid Nickname') {
							alert('잘못된 닉네임입니다.');
							document.forms["signupForm"].nickname.focus();
						} else {
							console.error("Unexpected response:", response);
							alert("예상치 못한 응답: " + response);
						}
					},
					error : function() {
						alert("전송 오류");
					}
				});
			}
		}

		function checkEmailDuplicated() {
			const email = document.forms["signupForm"].email.value.trim();
			const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

			if (email === "") {
				alert("이메일을 입력하세요.");
				document.forms["signupForm"].email.focus();
				return;
			}

			if (!emailRegex.test(email)) {
				alert("이메일 형식에 맞춰 입력해주세요.");
				document.forms["signupForm"].email.focus();
			} else {
				$.ajax({
					url : '${ctp}/checkEmailDuplicated.s',
					type : 'POST',
					data : {
						email : email
					},
					success : function(response) {
						if (response === 'duplicated') {
							alert('이미 사용 중인 이메일입니다.');
							document.forms["signupForm"].email.focus();
							emailChecked = false;
							activateButton(document.getElementById('isEmailDuplicatedBtn'));
						} else if (response === 'available') {
							alert('사용 가능한 이메일입니다.');
							emailChecked = true;
							deactivateButton(document.getElementById('isEmailDuplicatedBtn'));
						} else if (response === 'Invalid Email') {
							alert('잘못된 이메일입니다.');
							document.forms["signupForm"].email.focus();
						} else {
							console.error("Unexpected response:", response);
							alert("예상치 못한 응답: " + response);
						}
					},
					error : function() {
						alert("전송 오류");
					}
				});
			}
		}

		function validateForm() {
			const id = document.forms["signupForm"].id.value.trim();
			const password = document.forms["signupForm"].password.value.trim();
			const passwordConfirmation = document.forms["signupForm"].passwordConfirmation.value.trim();
			const nickname = document.forms["signupForm"].nickname.value.trim();
			const name = document.forms["signupForm"].name.value.trim();
			const email = document.forms["signupForm"].email.value.trim();

			const idRegex = /^[a-z][a-z0-9]{4,14}$/;
			const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;
			const nicknameRegex = /^[a-z0-9._]{2,30}$/;
			const nameRegex = /^(?:[a-z]{2,50}|[가-힣]{2,50})$/;
			const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

			if (id === "") {
				alert("아이디를 입력해주세요.");
				document.forms["signupForm"].id.focus();
				return false;
			}

			if (!idRegex.test(id)) {
				alert("아이디는 5자 이상 15자 이하의 영문 혹은 영문과 숫자를 조합해야 합니다.");
				document.forms["signupForm"].id.focus();
				return false;
			}

			if (!idChecked) {
				alert("아이디 중복 확인을 해주세요.");
				return false;
			}

			if (password === "") {
				alert("비밀번호를 입력해주세요.");
				document.forms["signupForm"].password.focus();
				return false;
			}

			if (!passwordRegex.test(password)) {
				alert("비밀번호는 10자 이상이어야 하며, 영문, 숫자, 특수문자가 포함되어야 합니다.");
				document.forms["signupForm"].password.focus();
				return false;
			}

			if (password !== passwordConfirmation) {
				alert("비밀번호가 일치하지 않습니다.");
				document.forms["signupForm"].passwordConfirmation.focus();
				return false;
			}

			if (nickname === "") {
				alert("닉네임을 입력해주세요.");
				document.forms["signupForm"].nickname.focus();
				return false;
			}

			if (!nicknameRegex.test(nickname)) {
				alert("닉네임은 2자 이상 30자 이하의 영문, 숫자, 마침표, 언더바만 입력 가능합니다.");
				document.forms["signupForm"].nickname.focus();
				return false;
			}

			if (!nicknameChecked) {
				alert("닉네임 중복 확인을 해주세요.");
				return false;
			}

			if (name === "") {
				alert("이름을 입력해주세요.");
				document.forms["signupForm"].name.focus();
				return false;
			}

			if (!nameRegex.test(name)) {
				alert("이름은 2자 이상 50자 이하의 한글 또는 영문만 입력 가능합니다.");
				document.forms["signupForm"].name.focus();
				return false;
			}

			if (email === "") {
				alert("이메일을 입력해주세요.");
				document.forms["signupForm"].email.focus();
				return false;
			}

			if (!emailRegex.test(email)) {
				alert("이메일 형식에 맞춰 입력해주세요.");
				document.forms["signupForm"].email.focus();
				return false;
			}

			if (!emailChecked) {
				alert("이메일 중복 확인을 해주세요.");
				return false;
			}

			return true;
		}
	</script>
</body>
</html>
