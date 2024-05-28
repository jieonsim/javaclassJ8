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
<c:forEach var="place" items="${places}">
	<div class="mb-3" onclick="selectPlace('${place.placeName}')" id="searchResults">
		<div id="placeNameReslut">${place.placeName}</div>
		<div id="placeInfoResult">${place.region1DepthName}, ${place.region2DepthName} · ${place.categoryName}</div>
	</div>
	<hr>
</c:forEach>
<input type="hidden" name="placeName" value="${place.placeName}" />