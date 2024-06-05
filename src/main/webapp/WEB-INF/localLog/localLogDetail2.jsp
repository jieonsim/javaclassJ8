<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/localLog/localLogDetail.css" />
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

	// 북마크 토글
	function toggleBookmark(event, localLogIdx) {
	    event.preventDefault();
	    event.stopPropagation();

	    $.ajax({
	        url: 'bookmarkCheck.b',
	        type: 'POST',
	        data: { localLogIdx: localLogIdx },
	        success: function(response) {
	            if (response === 'not_logged_in') {
	                showAlert("로그인 후 이용하실 수 있습니다.");
	                return;
	            }
	            if (response === 'bookmarked') {
	                $('#localLogBookmark-' + localLogIdx).removeClass('ph-bookmark-simple').addClass('ph-fill ph-bookmark-simple');
	                //showAlert("북마크에 저장되었습니다.");
	            } else if (response === 'unbookmarked') {
	                $('#localLogBookmark-' + localLogIdx).removeClass('ph-fill ph-bookmark-simple').addClass('ph-bookmark-simple');
	                //showAlert("북마크가 삭제되었습니다.");
	            } else if (response === 'error') {
	                showAlert("로컬로그 정보를 찾지 못했습니다.");
	            }
	        },
	        error: function(error) {
	            console.error('Error toggling bookmark', error);
	            showAlert("전송 오류가 발생했습니다.");
	        }
	    });
	}
	
	function toggleGuestBookLike(event, guestBookIdx, userIdx) {
	    event.preventDefault();
	    event.stopPropagation();

	    console.log("Sending AJAX request to likeToggle.gb with guestBookIdx:", guestBookIdx, "and userIdx:", userIdx);

	    $.ajax({
	        url: 'likeToggle.gb',
	        type: 'POST',
	        data: {
	            guestBookIdx: guestBookIdx,
	            userIdx: userIdx
	        },
	        success: function(response) {
	            console.log("Response from server:", response);
	            if (response === 'not_logged_in') {
	                showAlert("로그인 후 이용하실 수 있습니다.");
	                return;
	            } else if (response === 'cannot_like_own') {
	                showAlert("자신의 방명록에는 좋아요를 누를 수 없습니다.");
	                return;
	            }

	            const likeIconSelector = `#guestBookLikeIcon-${guestBookIdx}`;
	            const likeIcon = $(likeIconSelector);
	            const likeButton = $(`#guestBookLikeButton-${guestBookIdx}`);
	            console.log("Selector for like icon:", likeIconSelector);
	            console.log("Current like icon:", likeIcon.attr('class'));

	            if (response === 'liked') {
	                likeIcon.removeClass('ph-thumbs-up').addClass('ph-fill ph-thumbs-up');
	                likeButton.data('liked', true);
	                console.log("Icon updated to liked state:", likeIcon.attr('class'));
	            } else if (response === 'unliked') {
	                likeIcon.removeClass('ph-fill ph-thumbs-up').addClass('ph-thumbs-up');
	                likeButton.data('liked', false);
	                console.log("Icon updated to unliked state:", likeIcon.attr('class'));
	            } else {
	                showAlert("예외 오류가 발생했습니다.");
	            }
	        },
	        error: function(error) {
	            console.error('Error toggling like', error);
	            showAlert("전송 오류가 발생했습니다.");
	        }
	    });
	}
/* function toggleGuestBookLike(event, guestBookIdx, userIdx) {
    event.preventDefault();
    event.stopPropagation();

    $.ajax({
        url: 'likeToggle.gb',
        type: 'POST',
        data: {
            guestBookIdx: guestBookIdx,
            userIdx: userIdx
        },
        success: function(response) {
            if (response === 'not_logged_in') {
            	showAlert("로그인 후 이용하실 수 있습니다.");
                return;
            } else if (response === 'cannot_like_own') {
            	showAlert("자신의 방명록에는 좋아요를 누를 수 없습니다.");
                return;
            }
            
            const likeIcon = $(`#guestBookLikeIcon-${guestBookIdx}`);

            if (response === 'liked') {
                likeIcon.removeClass('ph-thumbs-up').addClass('ph-fill ph-thumbs-up');
            } else if (response === 'unliked') {
                likeIcon.removeClass('ph-fill ph-thumbs-up').addClass('ph-thumbs-up');
            } else {
                showAlert("예외 오류가 발생했습니다.");
            }
        },
        error: function(error) {
            console.error('Error toggling like', error);
            showAlert("전송 오류가 발생했습니다.");
        }
    });
} */
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5">
		<div class="localLogDetail-container">
			<div class="row">
				<div class="col-md-1">
					<a href="javascript:history.back()" class="back-button">
						<i class="ph ph-caret-left"></i>
					</a>
				</div>
				<div class="col-md-5">
					<div id="cardCarousel" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators">
							<c:forEach var="photo" items="${fn:split(localLog.photos, '/')}" varStatus="status">
								<li data-target="#cardCarousel" data-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}"></li>
							</c:forEach>
						</ol>
						<div class="carousel-inner">
							<c:forEach var="photo" items="${fn:split(localLog.photos, '/')}" varStatus="status">
								<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
									<img class="d-block w-100" src="${ctp}/images/localLog/${photo}" alt="Slide ${status.index + 1}">
									<div class="gradient-overlay"></div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="card-img-overlay">
						<div class="card-title" style="font-size: 20px;">
							<b><c:out value="${localLog.placeName}" /></b>
						</div>
						<div class="card-text" style="font-size: 14px;">
							<c:out value="${localLog.region1DepthName}" />
							,
							<c:out value="${localLog.region2DepthName}" />
							·
							<c:out value="${localLog.categoryName}" />
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="d-flex align-items-center mb-3">
						<a href="profileLocalLog.p?userIdx=${user.userIdx}" style="color: black; text-decoration: none;">
							<c:choose>
								<c:when test="${not empty user.profileImage}">
									<img src="${ctp}/images/profileImage/${user.profileImage}" alt="User Profile" class="rounded-circle" style="width: 40px; height: 40px; margin-right: 10px;">
								</c:when>
								<c:otherwise>
									<div class="rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; margin-right: 10px;">
										<i class="ph ph-user"></i>
									</div>
								</c:otherwise>
							</c:choose>
						</a>
						<div>
							<div style="font-size: 18px; font-weight: bold;">
								<c:out value="${user.nickname}" />
							</div>
							<div class="text-muted" style="font-size: 14px;">
								<c:out value="${localLog.visitDate}" />
								방문
							</div>
						</div>
					</div>
					<div class="localLogContent-container" style="background-color: #f2f2f2; padding: 20px; height: 87%">
						<c:choose>
							<c:when test="${not empty localLog.content}">
								<p>${fn:replace(localLog.content, newLine, "<br>")}</p>
							</c:when>
							<c:otherwise>
								<p>로컬로그 내용이 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="icons-container position-absolute" style="top: 0; right: 0;">
						<a href="javascript:void(0);" onclick="toggleBookmark(event, ${localLog.localLogIdx});" class="bookmark-icon" style="text-decoration: none;">
							<i class="ph ${isBookmarked ? 'ph-fill ph-bookmark-simple' : 'ph-bookmark-simple'}" id="localLogBookmark-${localLog.localLogIdx}"></i>
						</a>
						<a href="#" class="clapping-icon" style="text-decoration: none;">
							<i class="ph ph-hands-clapping" id="localLogClap"></i>
						</a>
					</div>
				</div>
			</div>
			<hr>
			<div class="row pb-5">
				<div class="col-12 d-flex justify-content-between mb-3">
					<div style="font-size: 14px;">
						<c:if test="${not empty place.createdBy}">
							<div>
								<b><c:out value="${place.createdByNickname}" /></b> 님이 처음으로 발견한 공간이에요!
							</div>
						</c:if>
					</div>
					<c:if test="${not empty guestBooks}">
						<a href="record-guestBook.g" id="writeToGuestBook"> 방명록 작성하러 가기 </a>
					</c:if>
				</div>
				<div class="col-12">
					<c:choose>
						<c:when test="${not empty guestBooks}">
							<c:forEach var="guestBook" items="${guestBooks}">
								<div class="d-flex align-items-center mb-3 pt-2">
									<a href="profileLocalLog.p?userIdx=${guestBook.userIdx}" style="color: black; text-decoration: none">
										<c:choose>
											<c:when test="${not empty guestBook.profileImage}">
												<img src="${ctp}/images/profileImage/${guestBook.profileImage}" alt="User Profile" class="rounded-circle" style="width: 40px; height: 40px; margin-right: 10px;">
											</c:when>
											<c:otherwise>
												<div class="rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; margin-right: 10px;">
													<i class="ph ph-user"></i>
												</div>
											</c:otherwise>
										</c:choose>
									</a>
									<div>
										<div style="font-size: 16px; font-weight: bold;">
											<c:out value="${guestBook.nickname}" />
										</div>
										<div class="text-muted" style="font-size: 14px;">
											<c:out value="${guestBook.visitDate}" />
											방문
										</div>
									</div>
								</div>
								<div>${fn:replace(guestBook.content, newLine, "<br>")}</div>
								<%-- <c:if test="${guestBook.userIdx != sessionUserIdx}">
									<div class="d-flex justify-content-between mt-3">
										<a href="javascript:void(0);" onclick="toggleGuestBookLike(event, ${guestBook.guestBookIdx}, ${sessionScope.sessionUserIdx});" class="text-dark guestbook-like-button">
											<i class="ph ${guestBook.likedByUser ? 'ph-fill ph-thumbs-up' : 'ph-thumbs-up'}" id="guestBookLikeIcon-${guestBook.guestBookIdx}"></i>&nbsp;도움이 됐어요
										</a>
									</div>
									<div class="d-flex justify-content-between mt-3">
										<a href="javascript:void(0);" onclick="toggleGuestBookLike(event, ${guestBook.guestBookIdx}, ${sessionScope.sessionUserIdx});" class="text-dark guestbook-like-button" id="guestBookLikeButton-${guestBook.guestBookIdx}" data-liked="${guestBook.likedByUser}">
											<i class="ph ${guestBook.likedByUser ? 'ph-fill ph-thumbs-up' : 'ph-thumbs-up'}" id="guestBookLikeIcon-${guestBook.guestBookIdx}"></i>&nbsp;&nbsp;도움이 됐어요
										</a>
									</div>
								</c:if> --%>
								<c:if test="${guestBook.userIdx != sessionUserIdx}">
									<div class="d-flex justify-content-between mt-3">
										<a href="javascript:void(0);" onclick="toggleGuestBookLike(event, ${guestBook.guestBookIdx}, ${sessionScope.sessionUserIdx});" class="text-dark guestbook-like-button" id="guestBookLikeButton-${guestBook.guestBookIdx}" data-liked="${guestBook.likedByUser}">
											<i class="ph ${guestBook.likedByUser ? 'ph-fill ph-thumbs-up' : 'ph-thumbs-up'}" id="guestBookLikeIcon-${guestBook.guestBookIdx}"></i>&nbsp;&nbsp;도움이 됐어요
										</a>
									</div>
								</c:if>
								<hr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="guestbook-container">
								<a href="record-guestBook.g" style="text-decoration: none;">
									<span class="guestbook-question" style="color: black;">이 공간에 방문해본 적 있나요?</span>
									<span class="guestbook-instruction">
										다음 방문자를 도와 줄 방명록 남기기 <i class="ph ph-pencil-simple"></i>
									</span>
								</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<!-- 위로가기 버튼 -->
			<div id="topBtn" class="">
				<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" id="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<input type="hidden" id="guestBookIdx" value="${guestBook.guestBookIdx}" />
	<input type="hidden" name="localLogIdx" value="${localLog.localLogIdx}" />
	<input type="hidden" name="userIdx" value="${user.userIdx}" />
</body>
</html>