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
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/record-guestBook.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/searchAPlaceModal.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		function setVisibilityValue() {
			const visibilityCheckbox = document.getElementById('visibility');
			const visibilityInput = document.createElement('input');
			visibilityInput.setAttribute('type', 'hidden');
			visibilityInput.setAttribute('name', 'visibility');
			visibilityInput.setAttribute('value', visibilityCheckbox.checked ? 'public' : 'private');
			document.forms['guestBookForm'].appendChild(visibilityInput);
		}

		function validateForm() {
			const sessionUserIdx = document.forms["guestBookForm"].sessionUserIdx.value.trim();
			const placeNameField = document.forms["guestBookForm"].placeName;
			const placeName = placeNameField ? placeNameField.value.trim() : "";
			const visitDate = document.forms["guestBookForm"].visitDate.value.trim();

			if (sessionUserIdx === "") {
				showAlert("세션이 만료되었습니다. 다시 로그인 후 이용해주세요.", "login.l");
				return false;
			}

			if (placeName === "") {
				showAlert("공간을 추가해주세요.");
				if (placeNameField) {
					placeNameField.focus();
				}
				return false;
			}

			if (visitDate === "") {
				showAlert("방문한 날짜를 선택해 주세요.");
				document.forms["guestBookForm"].visitDate.focus();
				return false;
			}

			return true;
		}

		const guestBookForm = document.forms['guestBookForm'];
		if (guestBookForm) {
			guestBookForm.addEventListener('submit', function(event) {
				if (!validateForm()) {
					event.preventDefault(); // 유효성 검사가 실패하면 폼 제출을 막음
				} else {
					setVisibilityValue();
				}
			});
		} else {
			console.error("방명록 폼이 존재하지 않습니다.");
		}
	});

	function switchModals() {
		$('#searchAPlaceModal').modal('hide');
		$('#searchAPlaceModal').on('hidden.bs.modal', function() {
			$('#addANewPlaceModal').modal('show');
			$('#searchAPlaceModal').off('hidden.bs.modal');
		});
	}

	function searchAPlace(event) {
		event.preventDefault();
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
			success : function(response) {
				$('#placeList').html(response);
				// 검색 결과가 없는 경우 알럿 띄우기
				if ($('#placeList').find('#noResults').length > 0) {
					showAlert("검색 결과가 없습니다. 공간을 새롭게 추가해주세요.");
				}
			},
			error : function() {
				showAlert("검색 중 오류가 발생했습니다.");
			}
		});
	}

	function selectPlace(placeName) {
		// Get references to the specific input fields
		const placeNameField = document.getElementById('placeNameInput');
		const placeLink = document.getElementById('placeLink');

		if (placeNameField) {
			placeNameField.value = placeName;
			placeNameField.style.display = 'block';

			// Hide the place link
			if (placeLink) {
				placeLink.style.display = 'none';
			}

			$('#searchAPlaceModal').modal('hide');
		} else {
			showAlert('장소 이름 필드를 찾을 수 없습니다.');
		}
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
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<jsp:include page="/WEB-INF/record/guestBook/addANewPlaceModal.jsp" />
	<div class="container mt-5">
		<div class="guestBook_title">
			<i class="ph ph-map-pin-simple"></i>
			<span>방명록 작성</span>
		</div>
		<div class="gusetBook-container">
			<!-- <form name="guestBookForm" class="guestBook-form" method="post" action="submitGuestBook.g"> -->
			<form name="guestBookForm" class="guestBook-form" method="post" action="${ctp}/submitGuestBook">
				<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
				<div class="form-group row">
					<label for="placeNameInput" class="col-sm-4 col-form-label text-left" id="placeLabel">
						<b>공간 추가 <span style="color: lightcoral;">*</span></b>
					</label>
					<div class="col" style="position: relative;">
						<!-- 공간 이름 입력 필드 -->
						<input type="text" class="form-control" id="placeNameInput" name="placeName" value="${sessionScope.temporaryPlace != null ? sessionScope.temporaryPlace.placeName : ''}" readonly style="${sessionScope.temporaryPlace != null ? 'display:block;' : 'display:none;'}">

						<!-- 공간이 선택되지 않았을 때 보여야하는 링크 -->
						<c:if test="${sessionScope.temporaryPlace == null}">
							<a href="#" id="placeLink" class="form-control" data-toggle="modal" data-target="#searchAPlaceModal">
								<i class="ph ph-caret-right"></i>
							</a>
						</c:if>
					</div>
				</div>
				<div class="form-group row mb-4">
					<label for="visitDate" class="col-sm-4 col-form-label text-left" id="visitdateLabel">
						<b>방문한 날짜 <span style="color: lightcoral;">*</span></b>
					</label>
					<div class="col">
						<input type="date" class="form-control" name="visitDate" id="visitDateInput" />
					</div>
				</div>
				<div class="form-group row mb-4">
					<div class="col">
						<textarea name="content" rows="4" class="form-control" name="content" placeholder="방명록을 작성해 보세요." id="contentInput"></textarea>
					</div>
				</div>
				<div class="form-group row mb-4">
					<div class="col text-left">
						<label id="companionsLabel" class="text-left">
							<b>누구와 방문했나요?</b>
						</label>
						<fieldset class="companions-options">
							<legend class="sr-only">Choose companions</legend>

							<input type="checkbox" name="companions" id="family" value="부모님 & 가족">
							<label for="family" class="option-btn">👨‍👩‍👧‍👦 부모님 & 가족</label>

							<input type="checkbox" name="companions" id="friend" value="친구">
							<label for="friend" class="option-btn">👋 친구</label>

							<input type="checkbox" name="companions" id="lover" value="연인">
							<label for="lover" class="option-btn">💑 연인</label>

							<input type="checkbox" name="companions" id="child" value="아이">
							<label for="child" class="option-btn">🐤 아이</label>

							<input type="checkbox" name="companions" id="alone" value="혼자">
							<label for="alone" class="option-btn">👤 혼자</label>

							<input type="checkbox" name="companions" id="pet" value="반려견">
							<label for="pet" class="option-btn">🐕 반려견</label>

							<input type="checkbox" name="companions" id="other" value="기타">
							<label for="other" class="option-btn">💬 기타</label>
						</fieldset>
					</div>
					<div class="col-sm-10 text-left mt-2">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" value="public" name="visibility" id="visibility" checked>
							<label class="form-check-label" for="visibility">전체공개</label>
						</div>
					</div>
				</div>
				<!-- 				<div class="form-group row mb-4">
					<div class="col text-left">
						<label for="companions" id="companionsLabel" class="text-left">
							<b>누구와 방문했나요?</b>
						</label>
						<div class="companions-options">
							<input type="checkbox" name="companions" id="family" value="부모님 & 가족">
							<label for="family" class="option-btn">👨‍👩‍👧‍👦 부모님 & 가족</label>

							<input type="checkbox" name="companions" id="friend" value="친구">
							<label for="friend" class="option-btn">👋 친구</label>

							<input type="checkbox" name="companions" id="lover" value="연인">
							<label for="lover" class="option-btn">💑 연인</label>

							<input type="checkbox" name="companions" id="child" value="아이">
							<label for="child" class="option-btn">🐤 아이</label>

							<input type="checkbox" name="companions" id="alone" value="혼자">
							<label for="alone" class="option-btn">👤 혼자</label>

							<input type="checkbox" name="companions" id="pet" value="반려견">
							<label for="pet" class="option-btn">🐕 반려견</label>

							<input type="checkbox" name="companions" id="other" value="기타">
							<label for="other" class="option-btn">💬 기타</label>
						</div>
					</div>
					<div class="col-sm-10 text-left mt-2">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" value="public" name="visibility" id="visibility" checked>
							<label class="form-check-label" for="visibility">전체공개</label>
						</div>
					</div>
				</div> -->
				<div class="form-group text-center">
					<div>
						<button type="submit" class="btn btn-custom btn-lg form-control" id="submitBtn">등록</button>
					</div>
				</div>
				<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
			</form>
		</div>
	</div>
	<!-- 공간 검색 모달 -->
	<div class="modal fade" id="searchAPlaceModal" tabindex="-1" role="dialog" aria-labelledby="searchAPlaceModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="searchAPlaceModalLabel">공간 추가하기</h5>
				</div>
				<div class="modal-body">
					<div class="text-center mb-4">
						<div>검색 결과가 없다면</div>
						<a href="#" id="goToNewModal" onclick="switchModals()">이 곳을 클릭해 새로운 공간을 추가해보세요.</a>
					</div>
					<div class="my-3 mx-5" style="position: relative;">
						<form id="searchForm" action="${ctp}/searchPlace.g" method="get" onsubmit="searchAPlace(event)">
							<input type="search" name="placeName" placeholder="공간명 검색" aria-label="Search" id="searching">
							<button id="searchBtn" type="submit">
								<i class="ph ph-magnifying-glass"></i>
							</button>
						</form>
					</div>
					<div id="placeList" class="mx-5 pl-3">
						<jsp:include page="/WEB-INF/record/searchPlaceResults.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
</body>
</html>