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
	
	function toggleBookmark(event, localLogIdx) {
	    // Stop the link from being followed
	    event.stopPropagation();
	    
	    // Retrieve the localLogIdx from the hidden input field
	    var localLogIdx = $('#localLogIdx-' + localLogIdx).val();
	    
	    $.ajax({
	        url: 'bookmarkCheck.b',
	        type: 'POST',
	        data: { localLogIdx: localLogIdx },
	        success: function(response) {
	            if (response == 'not_logged_in') {
	                showAlert("로그인 후 이용하실 수 있습니다.");
	                return false;
	            }
	            // Update the UI based on the response
	            if (response === 'bookmarked') {
	                $('#localLogBookmark-' + localLogIdx).removeClass('ph-bookmark-simple').addClass('ph-fill ph-bookmark-simple');
	                showAlert("북마크에 저장되었습니다.");
	            } else if (response === 'unbookmarked') {
	                $('#localLogBookmark-' + localLogIdx).removeClass('ph-fill ph-bookmark-simple').addClass('ph-bookmark-simple');
	            } else if (response === 'error') {
	                showAlert("로컬로그 정보를 찾지 못했습니다.");
	            }
	        },
	        error: function(error) {
	            console.error('Error toggling bookmark', error);
	            showAlert("전송 오류");
	        }
	    });
	}
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
							</h5>
							<p class="card-text text-muted">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
							<c:if test="${not empty localLog.content}">
								<p class="card-text">${fn:replace(custom:truncateWithEllipsis(localLog.content, 50), newLine, "<br>")}</p>
							</c:if>
							<a href="localLogDetail.ld?localLogIdx=${localLog.localLogIdx}" class="stretched-link"></a>
						</div>
						<%-- <div class="card-body">
							<h5 class="card-title d-flex justify-content-between align-items-center">
								<span>${localLog.placeName}</span>
							</h5>
							<p class="card-text text-muted">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
							<c:if test="${not empty localLog.content}">
								<p class="card-text">${fn:replace(custom:truncateWithEllipsis(localLog.content, 50), newLine, "<br>")}</p>
							</c:if>
							<a href="localLogDetail.ld?localLogIdx=${localLog.localLogIdx}" class="stretched-link"></a>
							<input type="hidden" id="localLogIdx-${localLog.localLogIdx}" value="${localLog.localLogIdx}" />
						</div>
						<a href="javascript:void(0);" onclick="toggleBookmark(event, ${localLog.localLogIdx});" class="bookmark-icon">
							<i class="ph ${isBookmarked ? 'ph-fill ph-bookmark-simple' : 'ph-bookmark-simple'}" id="localLogBookmark-${localLog.localLogIdx}"></i>
						</a> --%>
						<%-- <div class="card-body position-relative">
							<h5 class="card-title d-flex justify-content-between align-items-center">
								<span>${localLog.placeName}</span>
								<a href="javascript:void(0);" onclick="toggleBookmark(event, ${localLog.localLogIdx});" class="bookmark-icon">
									<i class="ph ${isBookmarked ? 'ph-fill ph-bookmark-simple' : 'ph-bookmark-simple'}" id="localLogBookmark-${localLog.localLogIdx}"></i>
								</a>
							</h5>
							<p class="card-text text-muted">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
							<c:if test="${not empty localLog.content}">
								<p class="card-text">${fn:replace(custom:truncateWithEllipsis(localLog.content, 50), newLine, "<br>")}</p>
							</c:if>
							<a href="localLogDetail.ld?localLogIdx=${localLog.localLogIdx}" class="stretched-link"></a>
							<input type="hidden" id="localLogIdx-${localLog.localLogIdx}" value="${localLog.localLogIdx}" />
						</div> --%>
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
	<%-- <input type="hidden" id="localLogIdx" value="${localLog.localLogIdx}" /> --%>
</body>
</html>