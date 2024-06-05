<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Lens</title>
<jsp:include page="/WEB-INF/include/bs4.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive.css" />
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive-localLog.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
	// 화살표클릭시 화면 상단으로 부드럽게 이동하기
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
		$.ajax({
			url : "getNextLocalLog.a",
			type : "post",
			data : {
				pag : curPage
			},
			success : function(res) {
				//console.log("AJAX Response:", res);
				$("#list-wrap").append(res);
				updateTotalPages(); // AJAX 응답 후 totalPages 요소 확인
			},
			error : function(err) {
				console.log("Error: ", err);
			}
		});
	}

	function updateTotalPages() {
		let totalPagesElement = document.getElementById('totalPages');
		if (totalPagesElement) {
			let totalPages = parseInt(totalPagesElement.value, 10);
			//console.log("Total Pages after AJAX:", totalPages);
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
	<div class="container px-5" id="archive-container">
		<jsp:include page="/WEB-INF/archive/archive-profile.jsp" />
		<c:choose>
			<c:when test="${not empty localLogs}">
				<div class="container-flud px-0" id="list-wrap">
					<div class="row no-gutters">
						<c:forEach var="localLog" items="${localLogs}">
							<div class="col-md-4">
								<div class="card" id="archive-localLog-card">
									<div class="image-container">
										<img class="card-img-top" src="${ctp}/images/localLog/${localLog.coverImage}" alt="Card image" id="archive-localLog-card-img">
										<c:if test="${localLog.visibility == 'private'}">
											<i class="ph ph-lock icon-top-right"></i>
										</c:if>
									</div>
									<div class="card-body">
										<h4 class="card-title" style="color: black;">${localLog.placeName}</h4>
										<p class="card-text text-muted">
											<c:choose>
												<c:when test="${localLog.categoryName == '바'}">🍸&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '카페'}">☕&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '음식점'}">🍴&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '디저트 / 베이커리'}">🍰&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '포토존'}">🤳🏻&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '광장'}">👥&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '관광지'}">🗽&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '종교시설'}">⛪&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '역사 유적지'}">🕌&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '자연'}">🍃&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '복합문화공간'}">🎨&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '박물관'}">🏛️&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '음악'}">🎵&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '전시'}">🖼️&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '공연'}">🎫&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '도서관'}">📖&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '샵'}">🛍️&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '서점'}">📚&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '시장'}">🛒&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '쇼핑몰'}">🏬&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '호텔'}">🏨&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '스테이'}">🛏️&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '미용 / 스파'}">💇🏻‍♀️&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '오락'}">🎮&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '운동'}">🏃🏻&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '스튜디오 / 클래스'}">👩🏻‍💻&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '골프장'}">⛳&nbsp;</c:when>
												<c:when test="${localLog.categoryName == '캠핑장'}">🏕️&nbsp;</c:when>
											</c:choose>
											${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}
										</p>
										<a href="myLocalLogDetail.a?localLogIdx=${localLog.localLogIdx}" class="stretched-link"></a>
										<input type="hidden" id="localLogIdx" value="${localLog.localLogIdx}">
									</div>
								</div>
							</div>
							<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
						</c:forEach>
					</div>
				</div>
				<!-- 위로가기 버튼 -->
				<div id="topBtn">
					<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
				</div>
			</c:when>
			<c:otherwise>
				<div class="text-center" style="margin-top: 100px; margin-bottom: 150px;">
					<div class="mb-2">내가 방문한 공간을 기록해보세요.</div>
					<button class="btn btn-custom" id="firstRecord" onclick="location.href='record-localLog.ll'">첫 로컬로그 남기기</button>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<!-- 총 페이지 수를 숨김 필드로 설정 -->
	<input type="hidden" id="totalPages" value="${totalPages}" />
</body>
</html>