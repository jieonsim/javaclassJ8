<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/searchAPlaceModal.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<div class="modal fade" id="searchAPlaceModal" tabindex="-1" role="dialog" aria-labelledby="searchAPlaceModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="searchAPlaceModalLabel">공간 추가하기</h5>
			</div>
			<div class="modal-body">
				<form name="searchAPlaceForm" class="searchAPlace-form" method="post" action="${ctp}/searchPlace.g">
					<div class="my-3 mx-5" style="position: relative;">
						<input type="search" name="placeName" placeholder="공간명 검색" aria-label="Search" id="searching">
						<button id="searchBtn" type="button" onclick="searchAPlace()">
							<i class="ph ph-magnifying-glass"></i>
						</button>
					</div>
					<div id="placeList" class="mx-5 pl-3">
						<c:forEach var="place" items="${places}">
							<div class="mb-3" onclick="selectPlace('${place.placeName}')">
								<div id="placeName">${place.placeName}</div>
								<div id="address">${place.region1DepthName}, ${place.region2DepthName} · ${place.categoryName}</div>
							</div>
							<hr>
						</c:forEach>
					</div>
				</form>
				<div class="text-center my-5">
					<c:if test="${empty places}">
						<div>검색 결과가 없다면</div>
					</c:if>
					<a href="#" id="goToNewModal" onclick="switchModals()">이 곳을 클릭해 새로운 공간을 추가해보세요.</a>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
function searchAPlace() {
	var query = $('#searching').val().trim();
	if (query === "") {
		showAlert("검색어를 입력해주세요.");
		return;
	}
	document.searchAPlaceForm.submit();
}

function selectPlace(placeName) {
	$('searchAPlaceModal').modal('hide');
	$('input[name="placeName"]').val(placeName);
}

function showAlert(message) {
	Swal.fire({
		html : message,
		confirmButtonText : '확인',
		customClass : {
			confirmButton : 'swal2-confirm',
			popup : 'custom-swal-popup',
			htmlContainer : 'custom-swal-text'
		}
	});
}
</script>