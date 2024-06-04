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
<style>
.photo-preview-container {
	position: relative;
	display: inline-block;
}

.delete-photo-icon {
	position: absolute;
	top: 5px;
	right: 5px;
	cursor: pointer;
	color: white;
	font-size: 18px;
}
</style>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const existingPhotos = '${localLog.photos}'.split('/').filter(photo => photo.trim() !== '');
    previewExistingPhotos(existingPhotos);

    function previewExistingPhotos(photos) {
        const photoPreviewContainer = document.getElementById('photoPreviewContainer');
        photoPreviewContainer.innerHTML = "";

        photos.forEach(photo => {
            const img = document.createElement('img');
            img.src = '${ctp}/images/localLog/' + photo;
            img.classList.add('photo-preview');

            const deleteIcon = document.createElement('span');
            deleteIcon.innerHTML = '✖';
            deleteIcon.classList.add('delete-photo-icon');
            deleteIcon.onclick = () => removePhoto(photo);

            const container = document.createElement('div');
            container.classList.add('photo-preview-container');
            container.appendChild(img);
            container.appendChild(deleteIcon);

            const td = document.createElement('td');
            td.appendChild(container);

            const tr = document.createElement('tr');
            tr.appendChild(td);

            photoPreviewContainer.appendChild(tr);
        });
    }

    function removePhoto(photo) {
        const index = existingPhotos.indexOf(photo);
        if (index > -1) {
            existingPhotos.splice(index, 1);
            removedPhotos.push(photo);
        }
        previewExistingPhotos(existingPhotos);
    }

    function previewPhoto(event) {
        const files = event.target.files;
        const photoPreviewContainer = document.getElementById('photoPreviewContainer');
        photoPreviewContainer.innerHTML = "";

        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const reader = new FileReader();

            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.classList.add('photo-preview');

                const container = document.createElement('div');
                container.classList.add('photo-preview-container');
                container.appendChild(img);

                const td = document.createElement('td');
                td.appendChild(container);

                const tr = document.createElement('tr');
                tr.appendChild(td);

                photoPreviewContainer.appendChild(tr);
            };

            reader.readAsDataURL(file);
        }
    }

    const fileInput = document.getElementById('photo-upload');
    fileInput.addEventListener('change', previewPhoto);
    
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
        const visitDate = document.forms["localLogForm"].visitDate.value.trim();
        const files = document.getElementById("photo-upload").files;
        const validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
        const maxFileSize = 5 * 1024 * 1024; // 5MB
        const maxTotalSize = 50 * 1024 * 1024; // 50MB
        let totalSize = 0;

        if (sessionUserIdx === "") {
            showAlert("세션이 만료되었습니다. 다시 로그인 후 이용해주세요.", "login.l");
            return false;
        }

        if (visitDate === "") {
            showAlert("방문한 날짜를 선택해 주세요.");
            document.forms["localLogForm"].visitDate.focus();
            return false;
        }

        if (existingPhotos.length === 0 && files.length === 0) {
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
    localLogForm.addEventListener('submit', function(event) {
        if (!validateForm()) {
            event.preventDefault(); // 유효성 검사가 실패하면 폼 제출을 막음
            const localLogIdx = document.forms["localLogForm"].localLogIdx.value;
            window.location.href = 'updateLocalLog.a?localLogIdx=' + localLogIdx; // 유효성 검사 실패 후 페이지 리로드
        } else {
            setVisibilityValue();
            document.getElementById('existingPhotos').value = existingPhotos.join('/');
            document.getElementById('removedPhotos').value = removedPhotos.join('/');
        }
    });

    const removedPhotos = [];
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<jsp:include page="/WEB-INF/record/localLog/addANewPlaceModal.jsp" />
	<div class="container mt-5">
		<div class="localLog_title">
			<!-- <i class="ph ph-image"></i> -->
			<a href="javascript:history.back()" style="text-decoration: none;" class="text-dark">
				<i class="ph ph-caret-left"></i>
			</a>
			<span>로컬로그 수정</span>
		</div>
		<div class="localLog-container">
			<form name="localLogForm" class="localLog-form" method="post" action="submitUpdateLocalLog.a" enctype="multipart/form-data">
				<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
				<input type="hidden" name="localLogIdx" value="${localLog.localLogIdx}" />
				<input type="hidden" name="placeIdx" value="${place.placeIdx}" />
				<input type="hidden" name="placeName" value="${place.placeName}" />
				<input type="hidden" id="existingPhotos" name="existingPhotos" value="${localLog.photos}" />
				<input type="hidden" name="removedPhotos" id="removedPhotos" value="" />
				<div class="form-group row">
					<label for="place" class="col-sm-4 col-form-label text-left text-mute" id="placeLabel">
						<b>공간 추가 <span style="color: lightcoral;">*</span></b>
					</label>
					<div class="col" style="position: relative;">
						<input type="text" class="form-control text-mute" id="placeNameInput" name="placeName" value="${localLog.placeName}" readonly>
					</div>
				</div>
				<div class="form-group row mb-4">
					<label for="visit_date" class="col-sm-4 col-form-label">
						<b>방문한 날짜 <span style="color: lightcoral;">*</span></b>
					</label>
					<div class="col">
						<input type="date" class="form-control" name="visitDate" id="visitDateInput" value="${localLog.visitDate}" />
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
							<input type="file" id="photo-upload" name="photos" class="d-none" multiple value="${localLog.photos}" />
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
						<textarea name="content" rows="6" class="form-control" id="content" placeholder="로컬로그를 작성해 보세요.">${localLog.content}</textarea>
					</div>
				</div>
				<div class="form-group row mb-4">
					<div class="col text-left">
						<label for="community">
							<b>커뮤니티 선택</b>
						</label>
						<div class="community-options">
							<input type="radio" name="community" id="travel" value="여행" ${localLog.community == '여행' ? 'checked' : ''}>
							<label for="travel" class="option-btn">✈️ 여행</label>
							<input type="radio" name="community" id="culture" value="문화생활" ${localLog.community == '문화생활' ? 'checked' : ''}>
							<label for="culture" class="option-btn">🎨 문화생활</label>
							<input type="radio" name="community" id="coffee" value="커피" ${localLog.community == '커피' ? 'checked' : ''}>
							<label for="coffee" class="option-btn">☕ 커피</label>
							<input type="radio" name="community" id="food" value="미식" ${localLog.community == '미식' ? 'checked' : ''}>
							<label for="food" class="option-btn">🍽 미식</label>
							<input type="radio" name="community" id="architecture" value="건축" ${localLog.community == '건축' ? 'checked' : ''}>
							<label for="architecture" class="option-btn">🏛 건축</label>
							<input type="radio" name="community" id="outdoor" value="아웃도어" ${localLog.community == '아웃도어' ? 'checked' : ''}>
							<label for="outdoor" class="option-btn">🏕 아웃도어</label>
							<input type="radio" name="community" id="workspace" value="워크스페이스" ${localLog.community == '워크스페이스' ? 'checked' : ''}>
							<label for="workspace" class="option-btn">💼 워크스페이스</label>
							<input type="radio" name="community" id="drink" value="술" ${localLog.community == '술' ? 'checked' : ''}>
							<label for="drink" class="option-btn">🍹 술</label>
							<input type="radio" name="community" id="pet" value="반려" ${localLog.community == '반려' ? 'checked' : ''}>
							<label for="pet" class="option-btn">🐕 반려</label>
							<input type="radio" name="community" id="tea" value="차" ${localLog.community == '차' ? 'checked' : ''}>
							<label for="tea" class="option-btn">🍵 차</label>
							<input type="radio" name="community" id="withChild" value="아이와 함께" ${localLog.community == '아이와 함께' ? 'checked' : ''}>
							<label for="withChild" class="option-btn">👶 아이와 함께</label>
						</div>
					</div>
					<div class="col-sm-10 text-left mt-2">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" value="true" name="visibility" id="visibility" ${localLog.visibility == 'public' ? 'checked' : ''}>
							<label class="form-check-label" for="visibility">전체공개</label>
						</div>
					</div>
				</div>
				<div class="form-group text-center">
					<div>
						<button type="submit" class="btn btn-custom btn-lg form-control mb-3" id="submitBtn">로컬로그 수정</button>
					</div>
				</div>
				<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
			</form>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
</body>
</html>