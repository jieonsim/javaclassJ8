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
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5">
		<div class="text-center" style="margin-top: 100px;">
			<i class="ph ph-image" style="font-size: 48px"></i>
			<div class="mb-1 mt-3" style="font-weight: bold">콘텐츠가 없습니다.</div>
			<div style="color: dimgray">아직 콘텐츠가 존재하지 않습니다.</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="message" />
	<input type="hidden" id="url" value="url" />
</body>
</html>