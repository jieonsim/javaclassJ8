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
<link rel="stylesheet" type="text/css" href="${ctp}/css/search/search.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="search-container">
		<div class="search-header">
			<input type="text" placeholder="지역, 공간을 검색해 보세요." class="search-input">
			<a href="searchResult.search" class="search-icon">
				<i class="ph ph-magnifying-glass"></i>
			</a>
		</div>
		<div class="recommended-searches">
			<h3>
				<b>추천검색어</b>
			</h3>
			<ul>
				<li><b>1</b>&nbsp;&nbsp;성수</li>
				<li><b>2</b>&nbsp;&nbsp;강릉</li>
				<li><b>3</b>&nbsp;&nbsp;청주</li>
				<li><b>4</b>&nbsp;&nbsp;속초</li>
				<li><b>5</b>&nbsp;&nbsp;행궁동</li>
				<li><b>6</b>&nbsp;&nbsp;북카페</li>
				<li><b>7</b>&nbsp;&nbsp;드라이브</li>
				<li><b>8</b>&nbsp;&nbsp;경주</li>
				<li><b>9</b>&nbsp;&nbsp;파주</li>
				<li><b>10</b>&nbsp;&nbsp;부산</li>
				<li><b>11</b>&nbsp;&nbsp;제주도</li>
			</ul>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
</body>
</html>