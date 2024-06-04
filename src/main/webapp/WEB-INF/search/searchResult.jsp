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
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5">
		<form>
			<div class="search-result-header">
				<input type="text" name="query" value="${param.query}" class="search-result-input">
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
				<div class="text-center" style="margin-top: 100px;">
					<i class="ph ph-binoculars"></i>
					<div id="noResult">검색 결과가 없습니다.</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" id="totalPages" value="${totalPages}" />
</body>
</html>