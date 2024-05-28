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
				<div class="my-3 mx-5" style="position: relative;">
					<input type="search" name="placeName" placeholder="공간명 검색" aria-label="Search" id="searching">
					<button id="searchBtn" type="button" onclick="searchAPlace()">
						<i class="ph ph-magnifying-glass"></i>
					</button>
				</div>
				<form name="searchAPlaceForm" class="searchAPlace-form" method="post" action="">
					<div id="placeList" class="mx-5 pl-3"></div>
				</form>
				<div class="text-center my-5">
					<div>검색 결과가 없다면</div>
					<a href="#" id="goToNewModal" onclick="switchModals()">이 곳을 클릭해 새로운 공간을 추가해보세요.</a>
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

		$.ajax({
			url : '${ctp}/searchPlace.g',
			type : 'GET',
			data : {
				placeName : placeName
			},
			dataType: 'json', // 응답 데이터를 JSON 형식으로 파싱
			success : function(response) {
				console.log(response); // 응답 데이터 콘솔에 출력
				let html = '';
				if (response.length > 0) {
					response.forEach(place => {
						html += `
							<div class="mb-3">
								<div style="font-size: 18px; font-weight: bold; cursor: pointer;" onclick="selectPlace('${place.placeName}')">${place.placeName}</div>
								<div style="color: dimgray">${place.region1DepthName}, ${place.region2DepthName} · ${place.categoryName}</div>
							</div>
							<hr>
						`;
					});
				} else {
					html = '<div class="text-center my-5"><div>검색 결과가 없습니다.</div><a href="#" id="goToNewModal" onclick="switchModals()">이 곳을 클릭해 새로운 공간을 추가해보세요.</a></div>';
				}
				$('#placeList').html(html);
			},
			error : function() {
				showAlert("검색 중 오류가 발생했습니다.");
			}
		});
	}

	function selectPlace(placeName) {
		$('#searchAPlaceModal').modal('hide');
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