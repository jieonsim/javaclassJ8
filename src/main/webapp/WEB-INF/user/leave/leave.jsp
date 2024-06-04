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
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/leave/leave.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5 pt-3">
		<div class="leave-container">
			<h4 class="mb-5">계정 탈퇴</h4>
			<h5>정말로 계정을 탈퇴하시겠습니까?</h5>
			<div style="color: gray; font-size: 14px;">계정을 탈퇴하기 전에 안내 사항을 꼭 확인해 주세요.</div>
			<div class="row mt-5">
				<div class="col">
					<div id="case">계정을 탈퇴하는 경우</div>
					<div class="card bg-light text-dark">
						<div class="card-body">
							계정 탈퇴 시 회원님의 프로필과 모든 컨텐츠는<br>
							<span style="color: red;">즉시 영구적으로 삭제되며 다시 복구할 수 없습니다.</span>
						</div>
					</div>
				</div>
			</div>
			<div class="row mt-5">
				<div class="col">
					<div id="case">계정을 탈퇴하는 대신 게시글을 비공개 하는 경우</div>
					<div class="card bg-light text-dark">
						<div class="card-body">
							내 콘텐츠가 다른 유저에게 공개되지 않고,<br>로컬로그 서비스 이용에는 영향을 끼치지 않습니다.
						</div>
					</div>
				</div>
			</div>
			<div>
				<a href="private.lv" class="btn btn-custom btn-lg mt-5" id="makeAccountPrivate">콘텐츠 비공개로 전환 후 계속 이용하기</a>
			</div>
			<div>
				<a href="#" class="btn btn-custom btn-lg mt-2" id="leave">탈퇴하기</a>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" id="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
</body>
</html>