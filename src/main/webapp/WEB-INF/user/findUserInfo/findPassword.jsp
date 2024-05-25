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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/findUserInfo/findPassword.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		const idRegex = /^[a-z][a-z0-9]{4,14}$/;
		const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

		document.getElementById('id').addEventListener('input', function() {
            validateInput(this, idRegex);
        });

		document.querySelector('input[name="email"]').addEventListener('input', function() {
			validateInput(this, emailRegex);
		});
	});

	function validateInput(input, regex) {
		const span = input.nextElementSibling;
		if (!regex.test(input.value)) {
			span.style.display = 'inline';
		} else {
			span.style.display = 'none';
		}
	}

	function validateForm() {
		const id = document.forms["findingPasswordForm"].id.value.trim();
		const email = document.forms["findingPasswordForm"].email.value.trim();
		
		const idRegex = /^[a-z][a-z0-9]{4,14}$/;
		const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		
		if (id === "") {
			showAlert("아이디를 입력해주세요.");
			document.forms["findingPasswordForm"].id.focus();
			return false;
		}
        
		if (!idRegex.test(id)) {
            showAlert("아이디는 5자 이상 15자 이하의<br>영문 혹은 영문과 숫자를 조합");
            document.forms["findingPasswordForm"].id.focus();
            return false;
        }
        
		if (email === "") {
			showAlert("이메일을 입력해주세요.");
			document.forms["findingPasswordForm"].email.focus();
			return false;
		}
		
        if (!emailRegex.test(email)) {
            showAlert("이메일 형식에 맞춰 입력해주세요.");
            document.forms["findingPasswordForm"].email.focus();
            return false;
        }
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5 pt-3">
		<div class="findingPassword-container">
			<h4 class="mb-5">비밀번호 찾기</h4>
			<form name="findingPasswordForm" class="findingPassword-form" method="post" action="tryToFindPassword.fi" onsubmit="return validateForm();">
				<div class="form-group row">
					<div class="col">
						<label for="name">아이디</label>
						<input type="text" class="form-control" name="id" id="id" placeholder="가입 시 등록한 아이디를 입력해주세요." autofocus />
						<span class="validation-message">5자 이상 15자 이하의 영문 혹은 영문과 숫자를 조합</span>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<label for="name">이메일</label>
						<input type="email" class="form-control" name="email" id='email' placeholder="가입 시 등록한 이메일을 입력해주세요." />
						<span class="validation-message">이메일 형식에 맞춰 입력해주세요.</span>
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
