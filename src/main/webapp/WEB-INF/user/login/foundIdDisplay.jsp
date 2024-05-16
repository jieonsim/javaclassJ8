<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Lens</title>
<jsp:include page="/include/bs4.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/login/foundIdDisplay.css" />
</head>
<body>
	<jsp:include page="/include/header.jsp" />
	<jsp:include page="/include/nav.jsp" />
		<div class="foundIdDisplay-container">
			<i class="ph ph-seal-check" id="sealCheck"></i>
			<h4 class="pt-3 mb-2">회원님의 로컬로그 계정을 찾았습니다.</h4>
			<div id="ment" class="mb-5">아이디 확인 후 로그인해 주세요.</div>
			<h3>zie***</h3>
			<div id="dateOfSignup" class="mb-5">가입일 2024.05.09</div>
			<div>
				<button onclick="location.href='login.l'" type="submit" class="btn btn-custom btn-lg" id="logIn">로그인</button>
			</div>
		</div>
</body>
</html>
