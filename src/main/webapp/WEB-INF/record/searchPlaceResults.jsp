<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
#placeNameReslut {
	color: black;
	font-size: 18px;
	font-weight: bold;
	text-decoration: none;
}

#placeInfoResult {
	color: dimgray
}

#searchResults:hover {
	cursor: pointer;
}
</style>
<c:choose>
	<c:when test="${not empty places}">
		<c:forEach var="place" items="${places}">
			<div class="mb-3" onclick="selectPlace('${place.placeName}')" id="searchResults">
				<div id="placeNameReslut">${place.placeName}</div>
				<div id="placeInfoResult">${place.region1DepthName},&nbsp;${place.region2DepthName}&nbsp;·&nbsp;${place.categoryName}</div>
			</div>
			<hr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div id="noResults"></div>
	</c:otherwise>
</c:choose>