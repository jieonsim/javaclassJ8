<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Local Lens</title>
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/signup/signupComplete.css" />
<jsp:include page="/WEB-INF/include/bs4.jsp" />
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="signUpComplete-container mt-5 pt-5 mb-5 pb-5">
		<i class="ph ph-seal-check" id="sealCheck"></i>
		<h4 class="pt-5 mb-2">회원가입이 완료되었습니다.</h4>
		<div id="ment" class="mb-5">로그인 후 이용해 주세요.</div>
		<div class="mb-5">
			<button onclick="location.href='login.l'" type="button" class="btn btn-custom btn-lg" id="logIn">로그인</button>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>