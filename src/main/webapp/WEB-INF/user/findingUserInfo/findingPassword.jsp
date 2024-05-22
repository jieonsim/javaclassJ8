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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/findingUserInfo/findingPassword.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5 pt-3">
		<div class="findingPassword-container">
			<h4 class="mb-5">비밀번호 찾기</h4>
			<form class="findingPassword-form" method="post" action="resetPassword.fi">
				<div class="form-group row">
					<div class="col">
						<label for="name">아이디</label>
						<input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력해주세요." <%-- value="<%=id %>" --%> autofocus required />
						<span>가입 시 등록한 아이디를 입력해주세요.</span>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<label for="name">이메일</label>
						<input type="email" class="form-control" name="email" id='email' placeholder="이메일을 입력해주세요." required />
						<span>가입 시 등록한 이메일을 입력해주세요.</span>
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
