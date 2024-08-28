<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Lens</title>
<jsp:include page="/WEB-INF/include/bs4.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/map/map.css" />
<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyATyCQj9DTcyGQ3T8sg-QEndzxEz0Df4z8&callback=initMap" async defer></script>
<script src="${ctp}/js/app.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container"></div>
	<div id="googleMap"></div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
</body>
</html>