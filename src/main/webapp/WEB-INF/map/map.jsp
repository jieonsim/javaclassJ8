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
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyATyCQj9DTcyGQ3T8sg-QEndzxEz0Df4z8"></script> -->
<script src="${ctp}/js/app.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container"></div>
	<div id="googleMap"></div>
<!-- 	<script>
		// Initialize and add the map
		function initMap() {
			// The location of the initial center
			var location = {
				lat : -34.397,
				lng : 150.644
			};
			// The map, centered at the location
			var map = new google.maps.Map(document.getElementById('map'), {
				zoom : 8,
				center : location
			});
			// The marker, positioned at the location
			var marker = new google.maps.Marker({
				position : location,
				map : map
			});
		}
	</script> -->
</body>
</html>