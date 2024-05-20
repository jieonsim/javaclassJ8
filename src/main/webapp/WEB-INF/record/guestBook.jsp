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
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5">
		<div class="guestBook_title">
			<a href="javascript:history.back();">
				<i class="ph ph-caret-left"></i>
			</a>
			<span>방명록 작성</span>
		</div>
		<div class="gusetBook-container">
			<form class="guestBook-form" method="post" action="">
				<!-- 숨겨진 필드 추가 -->
				<input type="hidden" id="selected-place-name" name="place_name" />
				<input type="hidden" id="selected-place-lat" name="place_lat" />
				<input type="hidden" id="selected-place-lng" name="place_lng" />
				<div class="form-group row">
					<div class="col mb-4">
						<div class="mb-4">
							<i class="ph-fill ph-map-pin" id="map-pin"></i>
						</div>
						<%-- <jsp:include page="/WEB-INF/record/addAPlace.jsp" /> --%>
						<input type="button" value="공간을 선택해주세요" data-toggle="modal" data-target="#addAPlace" id="place" />
						<i class="ph ph-caret-down" style="color: dimgrey; font-size: 20px; font-weight: bold;"></i>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<input type="date" class="form-control" name="visit_date" id="visit_date" required />
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<textarea name="content" rows="4" class="form-control" name="content" id="content" placeholder="방명록을 작성해 보세요."></textarea>
					</div>
				</div>
				<div class="form-group row mb-5">
					<div class="col text-left">
						<label for="companions" id="companions">
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
							<input class="form-check-input" type="checkbox" value="true" name="visibility" id="visibility" checked>
							<label class="form-check-label" for="visibility">전체공개</label>
						</div>
					</div>
				</div>
				<div class="form-group text-center">
					<div>
						<button type="submit" class="btn btn-custom btn-lg form-control mb-3" id="submit">등록</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
