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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/updateProfile/checkPassword.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
	function validateForm() {
		const password = document.forms["checkPasswordForm"].password.value.trim();

		if (password === "") {
			showAlert("비밀번호를 입력해주세요.");
			document.forms["checkPasswordForm"].password.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5 pt-3">
		<div class="checkPassword-container">
			<h4 class="mb-3">프로필 수정</h4>
			<div class="mb-5" id="ment">
				회원님의 정보를 안전하게 보호하기 위해<br>비밀번호를 다시 한번 확인해주세요.
			</div>
			<form name="checkPasswordForm" class="checkPassword-form" method="post" action="tryToCheckPassword.u" onsubmit="return validateForm();">
				<div class="form-group row">
					<div class="col">
						<label for="name">아이디</label>
						<input type="text" class="form-control" name="id" id="id" value="${sessionId}" readonly />
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<label for="name">비밀번호</label>
						<input type="password" class="form-control" name="password" id="password" placeholder="현재 비밀번호를 입력해주세요." />
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
	<input type="hidden" id="message" value="${message}">
	<input type="hidden" id="url" value="${url}">
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
</body>
</html>
