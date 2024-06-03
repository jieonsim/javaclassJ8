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
<link rel="stylesheet" type="text/css" href="${ctp}/css/search/searchResult.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5">
		<form>
			<div class="search-result-header">
				<input type="text" name="query" value="${param.query}" class="search-input">
				<button type="submit" class="btn btn-custom" id="search-icon">
					<i class="ph ph-magnifying-glass"></i>
				</button>
				<div class="filter-options">
					<span class="filter-option">인기순</span>
					<span class="filter-option">필터</span>
					<span class="filter-option">카페</span>
					<span class="filter-option">음식점</span>
					<span class="filter-option">문화</span>
					<span class="filter-option">여행</span>
					<span class="filter-option">바</span>
					<span class="filter-option">숙박</span>
					<span class="filter-option">쇼핑</span>
				</div>
			</div>
		</form>
		<div class="search-result-content">
			<div class="container-fluid">
				<div class="row no-gutters">
					<c:forEach var="localLog" items="${searchResults}">
						<div class="col-md-4">
							<div class="search-item">
								<img src="${ctp}/images/localLog/${localLog.coverImage}" class="search-item-img img-fluid" alt="${localLog.placeName}">
								<div class="search-item-details">
									<h4>${localLog.placeName}</h4>
									<p>${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

		<div class="text-center" style="margin-top: 100px;">
			<div class="mb-2">검색 결과가 없습니다.</div>
			<button class="btn btn-custom" id="firstRecord" onclick="location.href='record-localLog.ll'"></button>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
</body>
</html>