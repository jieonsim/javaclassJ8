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
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container" id="archive-container">
	<jsp:include page="/WEB-INF/archive/archive-profile.jsp" />
			<div class="text-center" style="margin-top: 100px;">
				<div class="mb-2">추천하고 싶은 나만의 공간 가이드를 만들어보세요.</div>
				<button class="btn btn-custom" id="firstRecord">첫 큐레이션 작성하기</button>
			</div>
			<div class="text-center" style="margin-top: 100px;">
				<i class="ph ph-image" style="font-size: 48px"></i>
				<div class="mb-1 mt-3" style="font-weight: bold">콘텐츠가 없습니다.</div>
				<div style="color: dimgray">아직 콘텐츠가 존재하지 않습니다.</div>
			</div>
		</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
</body>
</html>