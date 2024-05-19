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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/login/resetPassword.css" />
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
			<form class="resetPassword-form" method="post" action="passwordResetComplete.fi">
				<div class="form-group row">
					<div class="col">
						<label for="name">새 비밀번호 등록</label>
						<input type="password" class="form-control" name="password" placeholder="새 비밀번호를 입력해 주세요." <%-- value="<%=id %>" --%> autofocus required />
						<span>10자 이상 입력</span>
						<span>영문/숫자/특수문자(공백 제외)만 허용하며, 2개 이상 조합</span>
						<span>동일한 숫자 3개 이상 연속 사용 불가</span>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<label for="name">새 비밀번호 확인</label>
						<input type="password" class="form-control" name="password" placeholder="새 비밀번호를 한 번 더 입력해 주세요." required />
						<span>동일한 비밀번호를 입력해주세요.</span>
					</div>
				</div>
				<div class="form-group text-center">
					<div>
						<button type="submit" class="btn btn-custom btn-lg form-control mt-3" id="confirm">확인</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
