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
	<div class="container">
		<div class="search-result-header">
			<input type="text" value="성수" class="search-input">
			<a href="searchResult.search" class="search-icon">
				<i class="ph ph-magnifying-glass"></i>
			</a>
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
		<div class="search-result-content">
			<div class="search-item">
				<img src="${ctp}/images/dummy/1.jpg" class="search-item-img">
				<div class="search-item-details">
					<h4>웹 성수</h4>
					<p>서울, 성동구 · 음식점</p>
				</div>
			</div>
			<div class="search-item">
				<img src="${ctp}/images/dummy/2.jpg" class="search-item-img">
				<div class="search-item-details">
					<h4>SILD 성수</h4>
					<p>서울, 성동구 · 샵</p>
				</div>
			</div>
			<div class="search-item">
				<img src="${ctp}/images/dummy/3.jpg" class="search-item-img">
				<div class="search-item-details">
					<h4>린 성수</h4>
					<p>서울, 성동구 · 바</p>
				</div>
			</div>
			<div class="search-item">
				<img src="${ctp}/images/dummy/newjeans1.jpg" class="search-item-img">
				<div class="search-item-details">
					<h4>29CM 성수</h4>
					<p>서울, 성수 · 복합문화공간</p>
				</div>
			</div>
			<div class="search-item">
				<img src="${ctp}/images/dummy/newjeans2.jpg" class="search-item-img">
				<div class="search-item-details">
					<h4>TTRS 성수</h4>
					<p>서울, 성수 · 샵</p>
				</div>
			</div>
			<div class="search-item">
				<img src="${ctp}/images/dummy/newjeans3.jpg" class="search-item-img">
				<div class="search-item-details">
					<h4>베통 성수</h4>
					<p>서울, 성동구 · 디저트 / 베이커리</p>
				</div>
			</div>
			<div class="search-item">
				<img src="${ctp}/images/dummy/newjeans4.jpg" class="search-item-img">
				<div class="search-item-details">
					<h4>강별 성수</h4>
					<p>서울, 성동구 · 음식점</p>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
</body>
</html>