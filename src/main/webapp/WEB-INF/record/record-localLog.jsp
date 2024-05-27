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
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/localLog.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5">
		<div class="localLog_title">
			<i class="ph ph-image"></i>
			<!-- <a href="javascript:history.back();">
				<i class="ph ph-caret-left"></i>
			</a> -->
			<span>로컬로그 작성</span>
		</div>
		<div class="localLog-container">
			<form name="localLogForm" class="localLog-form" method="post" action="" enctype="multipart/form-data">
				<div class="form-group row">
					<div class="col">
						<div class="photo-section">
							<label for="photo-upload" class="photo-placeholder">
								<span>
									사진 추가
									<span style="color: lightcoral;">*</span>
									<br>&nbsp;&nbsp;&nbsp;0 / 15
								</span>
							</label>
							<input type="file" id="photo-upload" name="photo-upload" class="d-none" />
						</div>
					</div>
				</div>
				<div class="form-group row">
					<div class="col">
						<textarea name="content" rows="6" class="form-control" id="content" placeholder="로컬로그를 작성해 보세요."></textarea>
					</div>
				</div>
				<div class="form-group row">
					<label for="place" class="col-sm-4 col-form-label">
						<b>공간 추가 <span style="color: lightcoral;">*</span></b>
					</label>
					<!-- <div class="col">
						<input type="button" value=">" class="form-control" name="place" id="place" required />
					</div> -->
					<div class="col">
						<a href="#" id="place" class="form-control" data-toggle="modal" data-target="#searchAPlaceModal">
							<i class="ph ph-caret-right"></i>
						</a>
					</div>
				</div>
				<div class="form-group row mb-4">
					<label for="visit_date" class="col-sm-4 col-form-label">
						<b>방문한 날짜 <span style="color: lightcoral;">*</span></b>
					</label>
					<div class="col">
						<input type="date" class="form-control" name="visit_date" id="visit_date" required />
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
						<button type="submit" class="btn btn-custom btn-lg form-control mb-3" id="submit">로컬로그 업로드</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
