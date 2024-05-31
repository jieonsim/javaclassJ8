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
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/record-localLog.css" />
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
			document.forms['localLogForm'].appendChild(visibilityInput);
		}

		function validateForm() {
			const sessionUserIdx = document.forms["localLogForm"].sessionUserIdx.value.trim();
			const placeNameField = document.forms["localLogForm"].placeName;
			const placeName = placeNameField ? placeNameField.value.trim() : "";
			const visitDate = document.forms["localLogForm"].visitDate.value.trim();
			const files = document.getElementById("photo-upload").files;
			const validExtensions = [ 'jpg', 'jpeg', 'png', 'gif' ];
			const maxFileSize = 5 * 1024 * 1024; // 5MB
			const maxTotalSize = 50 * 1024 * 1024; // 50MB
			let totalSize = 0;

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
				document.forms["localLogForm"].visitDate.focus();
				return false;
			}

			if (files.length === 0) {
				showAlert("사진을 추가해주세요.");
				return false;
			}

			for (let i = 0; i < files.length; i++) {
				const fileExtension = files[i].name.split('.').pop().toLowerCase();
				if (!validExtensions.includes(fileExtension)) {
					showAlert("이미지 파일만 첨부 가능합니다. (jpg, jpeg, png, gif)");
					return false;
				}

				if (files[i].size > maxFileSize) {
					showAlert("각 파일의 크기는 5MB를 초과할 수 없습니다.");
					return false;
				}

				totalSize += files[i].size;
				if (totalSize > maxTotalSize) {
					showAlert("총 파일 크기는 50MB를 초과할 수 없습니다.");
					return false;
				}
			}

			return true;
		}

		const localLogForm = document.forms['localLogForm'];
		if (localLogForm) {
			localLogForm.addEventListener('submit', function(event) {
				if (!validateForm()) {
					event.preventDefault(); // 유효성 검사가 실패하면 폼 제출을 막음
				} else {
					setVisibilityValue();
				}
			});
		} else {
			console.error("로컬로그 폼이 존재하지 않습니다.");
		}

		// 파일 업로드 버튼 클릭 이벤트 핸들러 추가
		const photoPlaceholder = document.querySelector('.photo-placeholder');
		const fileInput = document.getElementById('photo-upload');

		function handlePhotoPlaceholderClick(event) {
			event.preventDefault();
			fileInput.click();
		}

		// 기존 이벤트 리스너를 제거하고 새로 등록
		if (photoPlaceholder) {
			photoPlaceholder.removeEventListener('click', handlePhotoPlaceholderClick);
			photoPlaceholder.addEventListener('click', handlePhotoPlaceholderClick);
		}

		fileInput.addEventListener('change', previewPhoto);
	});

	function previewPhoto(event) {
		const files = event.target.files;
		const photoPreviewContainer = document.getElementById('photoPreviewContainer');
		photoPreviewContainer.innerHTML = ""; // 기존 미리보기 내용을 초기화

		for (let i = 0; i < files.length; i++) {
			const file = files[i];
			const reader = new FileReader();

			reader.onload = function(e) {
				const img = document.createElement('img');
				img.src = e.target.result;
				img.classList.add('photo-preview');

				const td = document.createElement('td');
				td.appendChild(img);

				const tr = document.createElement('tr');
				tr.appendChild(td);

				photoPreviewContainer.appendChild(tr);
			};

			reader.readAsDataURL(file);
		}
	}

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
			url : '${ctp}/searchPlace.ll',
			type : 'GET',
			data : {
				placeName : placeName
			},
			success : function(response) {
				$('#placeList').html(response);
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
		const placeNameField = document.getElementById('placeNameInput');
		const placeLink = document.getElementById('placeLink');

		if (placeNameField) {
			placeNameField.value = placeName;
			placeNameField.style.display = 'block';

			if (placeLink) {
				placeLink.style.display = 'none';
			}

			$('#searchAPlaceModal').modal('hide');
		} else {
			showAlert('장소 이름 필드를 찾을 수 없습니다.');
		}
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<jsp:include page="/WEB-INF/record/localLog/addANewPlaceModal.jsp" />
	<div class="container mt-5">
		<div class="localLog_title">
			<i class="ph ph-image"></i>
			<span>로컬로그 작성</span>
		</div>
		<div class="localLog-container">
			<form name="localLogForm" class="localLog-form" method="post" action="submitLocalLog.ll" enctype="multipart/form-data">
				<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
				<div class="form-group row">
					<label for="place" class="col-sm-4 col-form-label text-left" id="placeLabel">
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
					<label for="visit_date" class="col-sm-4 col-form-label">
						<b>방문한 날짜 <span style="color: lightcoral;">*</span></b>
					</label>
					<div class="col">
						<input type="date" class="form-control" name="visitDate" id="visitDateInput" />
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<div class="photo-section">
							<label for="photo-upload" class="photo-placeholder">
								<span style="color: black">
									<i class="ph-fill ph-plus-circle"></i> <b> 사진 추가 </b>
									<span style="color: lightcoral;">*</span>
								</span>
							</label>
							<!-- <input type="file" id="photo-upload" name="photos" class="d-none" onchange="previewPhoto(event)" multiple /> -->
							<input type="file" id="photo-upload" name="photos" class="d-none" multiple />
						</div>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<div class="table-responsive">
							<table class="table table-borderedless">
								<tbody id="photoPreviewContainer">
									<!-- 미리보기 이미지들이 여기에 추가 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<textarea name="content" rows="6" class="form-control" id="content" placeholder="로컬로그를 작성해 보세요."></textarea>
					</div>
				</div>
				<div class="form-group row mb-4">
					<div class="col text-left">
						<label for="community">
							<b>커뮤니티 선택</b>
						</label>
						<div class="community-options">
							<input type="radio" name="community" id="travel" value="여행">
							<label for="travel" class="option-btn">✈️ 여행</label>
							<input type="radio" name="community" id="culture" value="문화생활">
							<label for="culture" class="option-btn">🎨 문화생활</label>
							<input type="radio" name="community" id="coffee" value="커피">
							<label for="coffee" class="option-btn">☕ 커피</label>
							<input type="radio" name="community" id="food" value="미식">
							<label for="food" class="option-btn">🍽 미식</label>
							<input type="radio" name="community" id="architecture" value="건축">
							<label for="architecture" class="option-btn">🏛 건축</label>
							<input type="radio" name="community" id="outdoor" value="아웃도어">
							<label for="outdoor" class="option-btn">🏕 아웃도어</label>
							<input type="radio" name="community" id="workspace" value="워크스페이스">
							<label for="workspace" class="option-btn">💼 워크스페이스</label>
							<input type="radio" name="community" id="drink" value="술">
							<label for="drink" class="option-btn">🍹 술</label>
							<input type="radio" name="community" id="pet" value="반려">
							<label for="pet" class="option-btn">🐕 반려</label>
							<input type="radio" name="community" id="tea" value="차">
							<label for="tea" class="option-btn">🍵 차</label>
							<input type="radio" name="community" id="withChild" value="아이와 함께">
							<label for="withChild" class="option-btn">👶 아이와 함께</label>
						</div>
					</div>
					<div class="col-sm-10 text-left mt-2">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" value="true" name="visibility" id="visibility" checked>
							<label class="form-check-label" for="visibility">전체공개</label>
						</div>
					</div>
				</div>
				<div class="form-group text-center">
					<div>
						<button type="submit" class="btn btn-custom btn-lg form-control mb-3" id="submitBtn">로컬로그 업로드</button>
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
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
</body>
</html>
