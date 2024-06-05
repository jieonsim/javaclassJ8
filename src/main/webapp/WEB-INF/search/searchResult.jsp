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
<script>
	//화살표클릭시 화면 상단으로 부드럽게 이동하기
	$(window).scroll(function() {
		if ($(this).scrollTop() > 100) {
			$("#topBtn").addClass("on");
		} else {
			$("#topBtn").removeClass("on");
		}

		$("#topBtn").click(function() {
			window.scrollTo({
				top : 0,
				behavior : "smooth"
			});
		});
	});

	function getNextList(curPage) {
		console.log("Getting next list for page: " + curPage); // 디버깅 로그 추가
		$.ajax({
			url : "getNextSearchResult.search",
			type : "get",
			data : {
				pag : curPage,
				query : $('#query').val(),
				categoryIdx : $('#selectedCategories').val()
			},
			success : function(res) {
				console.log("AJAX request successful, response: ", res); // 디버깅 로그 추가
				$("#list-wrap .row").append(res);
				totalPages = updateTotalPages(); // AJAX 응답 후 totalPages 요소 확인
			},
			error : function(err) {
				console.log("AJAX request error: ", err); // 디버깅 로그 추가
			}
		});
	}

	function updateTotalPages() {
		let totalPagesElement = document.getElementById('totalPages');
		if (totalPagesElement) {
			let totalPages = parseInt(totalPagesElement.value, 10);
			console.log("Total pages: " + totalPages); // 디버깅 로그 추가
			return totalPages;
		} else {
			console.error("totalPages element not found after AJAX!");
			return 0;
		}
	}

	document.addEventListener("DOMContentLoaded", function() {
		let lastScroll = 0;
		let curPage = 1;
		let totalPages = updateTotalPages();

		$(document).scroll(function() {
			let currentScroll = $(this).scrollTop();
			let documentHeight = $(document).height();
			let nowHeight = $(this).scrollTop() + $(window).height();

			if (currentScroll > lastScroll && curPage < totalPages) {
				if (documentHeight < (nowHeight + (documentHeight * 0.1))) {
					console.log("Get next page");
					curPage++;
					getNextList(curPage);
				}
			}
			lastScroll = currentScroll;
		});
	});

	/* 	function getNextList(curPage) {
	 console.log("Getting next list for page: " + curPage); // 디버깅 로그 추가
	 $.ajax({
	 url : "getNextSearchResult.search",
	 type : "get",
	 data : {
	 pag : curPage,
	 query : $('#query').val()
	 // 히든 필드에서 query 값을 가져옴
	 },
	 success : function(res) {
	 console.log("AJAX request successful, response: ", res); // 디버깅 로그 추가
	 $("#list-wrap .row").append(res);
	 totalPages = updateTotalPages(); // AJAX 응답 후 totalPages 요소 확인
	 },
	 error : function(err) {
	 console.log("AJAX request error: ", err); // 디버깅 로그 추가
	 }
	 });
	 }

	 function updateTotalPages() {
	 let totalPagesElement = document.getElementById('totalPages');
	 if (totalPagesElement) {
	 let totalPages = parseInt(totalPagesElement.value, 10);
	 console.log("Total pages: " + totalPages); // 디버깅 로그 추가
	 return totalPages;
	 } else {
	 console.error("totalPages element not found after AJAX!");
	 return 0;
	 }
	 }

	 document.addEventListener("DOMContentLoaded", function() {
	 let lastScroll = 0;
	 let curPage = 1;
	 let totalPages = updateTotalPages();

	 $(document).scroll(function() {
	 let currentScroll = $(this).scrollTop();
	 let documentHeight = $(document).height();
	 let nowHeight = $(this).scrollTop() + $(window).height();

	 if (currentScroll > lastScroll && curPage < totalPages) {
	 if (documentHeight < (nowHeight + (documentHeight * 0.1))) {
	 console.log("Get next page");
	 curPage++;
	 getNextList(curPage);
	 }
	 }
	 lastScroll = currentScroll;
	 });
	 });
	 */
	$(document).ready(function() {
		$('.all-check').click(function() {
			let type = $(this).data('type');
			console.log("Select All clicked for type: " + type); // Debugging log
			let checkboxes = $('input[data-type="' + type + '"]');
			let allChecked = checkboxes.length === checkboxes.filter(':checked').length;

			// Toggle check/uncheck all checkboxes
			checkboxes.prop('checked', !allChecked);
		});

		$('#resetBtn').click(function() {
			$('input[type="checkbox"]').prop('checked', false);
		});
	});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5">
		<form>
			<div class="search-result-header">
				<button type="submit" class="btn btn-custom" id="search-icon">
					<i class="ph ph-magnifying-glass"></i>
				</button>
				<input type="text" name="query" value="${param.query}" class="search-result-input">
				<div class="filter-options">
					<a href="#" class="filter-option" data-toggle="modal" data-target="#searchFilter" id="filterIcon">
						<i class="ph ph-sliders"></i>&nbsp;필터
					</a>
				</div>
			</div>
			<input type="hidden" id="query" name="query" value="${param.query}">
		</form>
		<c:choose>
			<c:when test="${not empty searchResults}">
				<div class="search-result-content">
					<div class="container-fluid" id="list-wrap">
						<div class="row no-gutters">
							<c:forEach var="localLog" items="${searchResults}">
								<c:if test="${localLog.visibility == 'public'}">
									<div class="col-md-4 mb-4">
										<div class="search-item">
											<img src="${ctp}/images/localLog/${localLog.coverImage}" class="search-item-img img-fluid" alt="${localLog.placeName}">
											<div class="search-item-details">
												<h4>${localLog.placeName}</h4>
												<p>${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
											</div>
											<a href="localLogDetail.ld?localLogIdx=${localLog.localLogIdx}" class="stretched-link"></a>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 위로가기 버튼 -->
				<div id="topBtn">
					<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
				</div>
			</c:when>
			<c:otherwise>
				<div class="text-center" style="margin-top: 100px; margin-bottom: 150px;">
					<i class="ph ph-binoculars"></i>
					<div id="noResult">검색 결과가 없습니다.</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="modal fade" id="searchFilter" tabindex="-1" role="dialog" aria-labelledby="addANewPlaceModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="searchFilterTitle">필터</h5>
				</div>
				<div class="modal-body">
					<form name="searchFilterForm" class="searchFilter-form" method="post" action="searchResult.search">
						<input type="hidden" name="query" value="${param.query}">
						<div class="form-group">
							<div class="category-section mx-3" id="categorySection">
								<c:forEach var="categoryType" items="${categoriesByType.keySet()}">
									<div class="d-flex justify-content-between">
										<b>${categoryType}</b>
										<button type="button" class="text-mute all-check" data-type="${categoryType}" id="allCheck">모두 선택</button>
									</div>
									<div class="category-options mb-3">
										<c:forEach var="category" items="${categoriesByType[categoryType]}">
											<label>
												<input type="checkbox" name="categoryIdx" value="${category.categoryIdx}" class="category-checkbox" data-type="${categoryType}">
												<span class="option-btn">${category.categoryName}</span>
											</label>
										</c:forEach>
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="d-flex justify-content-around mx-2 my-3">
							<button type="button" class="form-control btn btn-sm mr-3" id="resetBtn">초기화</button>
							<button type="submit" class="form-control btn btn-sm" id="submitBtn">적용</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" id="totalPages" value="${totalPages}" />
</body>
</html>