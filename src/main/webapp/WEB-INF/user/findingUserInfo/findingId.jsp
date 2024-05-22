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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/findingUserInfo/findingId.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		const nameRegex = /^(?:[a-z]{2,50}|[가-힣]{2,50})$/;
		const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

		document.querySelector('input[name="name"]').addEventListener('input', function() {
			validateInput(this, nameRegex);
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
		const name = document.forms["findingIdForm"].name.value.trim();
		const email = document.forms["findingIdForm"].email.value.trim();

		if (name === "") {
			showAlert("이름을 입력해주세요.");
			document.forms["findingIdForm"].name.focus();
			return false;
		}
		if (email === "") {
			showAlert("이메일을 입력해주세요.");
			document.forms["findingIdForm"].email.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5 pt-3">
		<div class="findingId-container">
			<h4 class="mb-5">아이디 찾기</h4>
			<form name="findingIdForm" class="findingId-form" method="post" action="tryToFindId.fi" onsubmit="return validateForm();">
				<div class="form-group row">
					<div class="col">
						<label for="name">이름</label>
						<input type="text" class="form-control" name="name" id="name" placeholder="가입 시 등록한 이름을 입력해주세요." autofocus />
						<span class="validation-message">2자 이상 50자 이하의 한글 또는 영문만 입력 가능</span>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<label for="email">이메일</label>
						<input type="email" class="form-control" name="email" id="email" placeholder="가입 시 등록한 이메일을 입력해주세요." />
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
