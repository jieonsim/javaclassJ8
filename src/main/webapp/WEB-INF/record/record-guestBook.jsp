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
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/guestBook.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
    function setVisibilityValue() {
        const visibilityCheckbox = document.getElementById('visibility');
        const visibilityInput = document.createElement('input');
        visibilityInput.setAttribute('type', 'hidden');
        visibilityInput.setAttribute('name', 'visibility');
        visibilityInput.setAttribute('value', visibilityCheckbox.checked ? 'public' : 'private');
        document.forms['guestBookForm'].appendChild(visibilityInput);
    }
	
	function switchModals() {
		$('#searchAPlaceModal').modal('hide');
		$('#searchAPlaceModal').on('hidden.bs.modal', function() {
			$('#addANewPlaceModal').modal('show');
			$('#searchAPlaceModal').off('hidden.bs.modal');
		});
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<jsp:include page="/WEB-INF/record/searchAPlaceModal.jsp" />
	<jsp:include page="/WEB-INF/record/addANewPlaceModal.jsp" />
	<div class="container mt-5">
		<div class="guestBook_title">
			<i class="ph ph-map-pin-simple"></i>
			<span>방명록 작성</span>
		</div>
		<div class="gusetBook-container">
			<form name="guestBookForm" class="guestBook-form" method="post" action="submitGuestBook.g" onsubmit="setVisibilityValue()">
				<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
				<%-- <input type="hidden" name="userIdx" value="${userVO.userIdx}" /> --%>
				<div class="form-group row">
					<label for="place" class="col-sm-4 col-form-label text-left" id="placeLabel">
						<b>공간 추가 <span style="color: lightcoral;">*</span></b>
					</label>
					<!-- <div class="col"> -->
					<div class="col" style="position: relative;">
						<c:choose>
							<c:when test="${not empty sessionScope.temporaryPlace}">
								<input type="text" class="form-control" name="placeName" value="${sessionScope.temporaryPlace.placeName}" readonly>
								<!-- <a href="#" id="place" class="form-control" data-toggle="modal" data-target="#searchAPlaceModal"> -->
								<a href="#" id="placeName" class="form-control-link" data-toggle="modal" data-target="#searchAPlaceModal">
									<i class="ph ph-caret-right"></i>
								</a>
							</c:when>
							<c:otherwise>
								<a href="#" id="place" class="form-control" data-toggle="modal" data-target="#searchAPlaceModal">
									<i class="ph ph-caret-right"></i>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="form-group row mb-4">
					<label for="visit_date" class="col-sm-4 col-form-label text-left" id="visitdateLabel">
						<b>방문한 날짜 <span style="color: lightcoral;">*</span></b>
					</label>
					<div class="col">
						<input type="date" class="form-control" name="visitDate" required />
					</div>
				</div>
				<div class="form-group row mb-4">
					<div class="col">
						<textarea name="content" rows="4" class="form-control" name="content" placeholder="방명록을 작성해 보세요."></textarea>
					</div>
				</div>
				<div class="form-group row mb-4">
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
				</div>
				<div class="form-group text-center">
					<div>
						<button type="submit" class="btn btn-custom btn-lg form-control" id="submitBtn">등록</button>
					</div>
				</div>
				<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
			</form>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
</body>
</html>