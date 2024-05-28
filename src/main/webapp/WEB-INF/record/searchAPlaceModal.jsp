<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
				<div class="text-center my-5">
					<div>검색 결과가 없다면</div>
				</div>
				<div class="my-3 mx-5" style="position: relative;">
						<a href="#" id="goToNewModal" onclick="switchModals()">이 곳을 클릭해 새로운 공간을 추가해보세요.</a>
					<form id="searchForm" action="${ctp}/searchPlace.g" method="get" onsubmit="return searchAPlace();">
						<input type="search" name="placeName" placeholder="공간명 검색" aria-label="Search" id="searching">
						<button id="searchBtn" type="submit">
							<i class="ph ph-magnifying-glass"></i>
						</button>
					</form>
				</div>
				<div id="placeList" class="mx-5 pl-3">
					<!-- 검색 결과가 여기에 표시 -->
					<c:forEach var="place" items="${places}">
						<div class="mb-3" onclick="selectPlace('${place.placeName}')">
							<div style="font-size: 18px; font-weight: bold;">${place.placeName}</div>
							<div style="color: dimgray">${place.region1DepthName},${place.region2DepthName} · ${place.categoryName}</div>
						</div>
						<hr>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	function searchAPlace() {
		const placeName = document.getElementById('searching').value.trim();

		if (placeName === "") {
			showAlert("공간명을 입력해주세요.");
			return;
		}
		location.href = "searchPlace.g?placeName=" + placeName;

		/* $.ajax({
			url : '${ctp}/searchPlace.g',
			type : 'GET',
			data : {
				placeName : placeName
			},
			success : function(response) {
				$('#placeList').html(response);
			},
			error : function() {
				showAlert("검색 중 오류가 발생했습니다.");
			}
		}); */
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

	function selectPlace(placeName) {
		$('#searchAPlaceModal').modal('hide');
		$('input[name="placeName"]').val(placeName);
	}
</script>