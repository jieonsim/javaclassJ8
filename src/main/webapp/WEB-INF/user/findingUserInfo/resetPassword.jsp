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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/findingUserInfo/resetPassword.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;

		document.querySelector('input[name="password"]').addEventListener('input', function() {
			validateInput(this, passwordRegex);
			validatePasswordConfirmation();
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

	function showAlert(message) {
		Swal.fire({
			html : message,
			confirmButtonText : '확인',
			customClass : {
				confirmButton : 'swal2-confirm',
				popup : 'custom-swal-popup',
				htmlContainer : 'custom-swal-text'
			}
		});
	}

	function validateForm() {
		const password = document.forms["resetPasswordForm"].password.value.trim();
		const passwordConfirmation = document.forms["resetPasswordForm"].passwordConfirmation.value.trim();
		const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;

		if (password === "") {
			showAlert("비밀번호를 입력해주세요.");
			document.forms["resetPasswordForm"].password.focus();
			return false;
		}

		if (!passwordRegex.test(password)) {
			showAlert("비밀번호는 10자 이상,<br>영문, 숫자, 특수문자 포함");
			document.forms["resetPasswordForm"].password.focus();
			return false;
		}

		if (password !== passwordConfirmation) {
			showAlert("비밀번호가 일치하지 않습니다.");
			document.forms["resetPasswordForm"].passwordConfirmation.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5 pt-3">
		<div class="resetPassword-container">
			<h4 class="mb-3">비밀번호 재설정</h4>
			<div class="mb-5 text-center" id="ment">
				비밀번호 재설정을 위해<br>새로운 비밀번호 입력해 주세요.
			</div>
			<form name="resetPasswordForm" class="resetPassword-form" method="post" action="tryToResetPassword.fi" onsubmit="return validateForm();">
				<input type="hidden" name="id" value="${id}" />
				<div class="form-group row">
					<div class="col">
						<label for="name">새 비밀번호 등록</label>
						<input type="password" class="form-control" name="password" placeholder="새 비밀번호를 입력해 주세요." autofocus required />
						<span class="validation-message">10자 이상, 영문,숫자,특수문자 조합</span>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<label for="name">새 비밀번호 확인</label>
						<input type="password" class="form-control" name="passwordConfirmation" placeholder="새 비밀번호를 한 번 더 입력해 주세요." required />
						<span class="validation-message">동일한 비밀번호를 입력</span>
					</div>
				</div>
				<div class="form-group text-center">
					<div>
						<button type="submit" class="btn btn-custom btn-lg form-control mt-3" id="submitBtn">확인</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
</body>
</html>
