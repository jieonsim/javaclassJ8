<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://example.com/custom-functions" prefix="custom"%>
<%
pageContext.setAttribute("newLine", "\n");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Lens</title>
<jsp:include page="/WEB-INF/include/bs4.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/main/main.css" />
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
	function reinitializeCarousel() {
		$('.carousel').each(function() {
			$(this).carousel({
				interval : 2000,
				ride : 'carousel'
			});
		});
	}

	function getNextList(curPage) {
		$.ajax({
			url : "${ctp}/getLocalLogs",
			type : "post",
			data : {
				pag : curPage
			},
			success : function(res) {
				//console.log("AJAX Response:", res);
				$("#list-wrap").append(res);
				updateTotalPages(); // AJAX 응답 후 totalPages 요소 확인
				reinitializeCarousel(); // Reinitialize carousel after new content is appended
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
			console.log("Total Pages after AJAX:", totalPages);
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

		// Initialize carousel on page load
		reinitializeCarousel();
	});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container">
		<div id="list-wrap">
			<c:forEach var="localLog" items="${localLogs}">
				<div class="container card-container mt-5">
					<div class="card">
						<div id="carousel-${localLog.localLogIdx}" class="carousel slide carousel-fade" data-ride="carousel" data-interval="2000">
							<div class="carousel-inner">
								<c:forEach var="photoUrl" items="${localLog.photoUrls}" varStatus="status">
									<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
										<img src="${ctp}/images/localLog/${photoUrl}" class="d-block w-100" alt="Local Log Image">
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="card-body position-relative">
							<h5 class="card-title d-flex justify-content-between align-items-center">
								<span>${localLog.placeName}</span>
								<a href="#">
									<i class="ph ph-bookmark-simple" id="localLogBookmark"></i>
								</a>
							</h5>
							<p class="card-text text-muted">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
							<c:if test="${not empty localLog.content}">
								<p class="card-text">${fn:replace(custom:truncateWithEllipsis(localLog.content, 50), newLine, "<br>")}</p>
							</c:if>
							<a href="localLogDetail.ld" class="stretched-link"></a>
						</div>
					</div>
				</div>
				<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
			</c:forEach>
		</div>
		<!-- 위로가기 버튼 -->
		<div id="topBtn">
			<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
		</div>
	</div>
	<div class="pt-5">footer</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" id="totalPages" value="${totalPages}" />
</body>
</html>