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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/login/findingId.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5 pt-3">
		<div class="findingId-container">
			<h4 class="mb-5">아이디 찾기</h4>
			<form class="findingId-form" method="post" action="foundIdDisplay.fi">
				<div class="form-group row">
					<div class="col">
						<label for="name">이름</label>
						<input type="text" class="form-control" name="name" id="name" placeholder="이름을 입력해주세요." <%-- value="<%=id %>" --%> autofocus required />
						<span>가입 시 등록한 이름을 입력해주세요.</span>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<label for="name">이메일</label>
						<input type="email" class="form-control" name="email" id="email" placeholder="이메일을 입력해주세요." required />
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
