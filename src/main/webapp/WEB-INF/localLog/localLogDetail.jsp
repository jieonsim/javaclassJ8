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

	$(document).ready(function() {
		// 방명록 좋아요 버튼 클릭 시
		$(document).on('click', '.like-button', function() {
			var $this = $(this);
			var guestBookIdx = $this.data('guest-book-idx');
			var itemIdx = guestBookIdx; // guestBookIdx를 itemIdx로 설정
			var userIdx = $('input[name="sessionUserIdx"]').val();

			if (!userIdx) {
				showAlert("로그인 후 이용하실 수 있습니다.");
				return;
			}

			$.ajax({
				url : "guestBookLike.gb",
				type : "post",
				data : {
					itemIdx : itemIdx,
					guestBookIdx : guestBookIdx
				},
				success : function(res) {
					if (res.status === 'liked') {
						$this.removeClass('beforelike').addClass('afterlike');
						$this.html('<i class="ph-fill ph-thumbs-up"></i> ' + res.likeCount);
					} else if (res.status === 'unliked') {
						$this.removeClass('afterlike').addClass('beforelike');
						$this.html('<i class="ph ph-thumbs-up"></i> 도움이 됐어요');
					}
				},
				error : function() {
					showAlert("전송 오류1");
				}
			});
		});
	});

	/* $(document).ready(function() {
	    // 로컬로그 좋아요 버튼 클릭 시
	    $(document).on('click', '#localLogClap', function() {
	        var $this = $(this);
	        var localLogIdx = $('input[name="localLogIdx"]').val();
	        var userIdx = $('input[name="sessionUserIdx"]').val();

	        console.log('localLogIdx:', localLogIdx);  // Debug log
	        console.log('userIdx:', userIdx);  // Debug log
	        
	        if (!userIdx) {
	            showAlert("로그인 후 이용하실 수 있습니다.");
	            return;
	        }

	        $.ajax({
	            url : "localLogLike.ld",
	            type : "post",
	            data : {
	                localLogIdx : localLogIdx,
	                userIdx : userIdx
	            },
	            success : function(res) {
	                if (res.status === 'liked') {
	                    $this.removeClass('beforelike').addClass('afterlike');
	                    $this.html('<i class="ph-fill ph-hands-clapping"></i> ' + res.likeCount);
	                } else if (res.status === 'unliked') {
	                    $this.removeClass('afterlike').addClass('beforelike');
	                    $this.html('<i class="ph ph-hands-clapping"></i> ' + res.likeCount);
	                }
	            },
	            error : function() {
	                showAlert("전송 오류2");
	            }
	        });
	    });

	    // 로드 시 좋아요 상태 확인
	    checkLikeStatus();

	    function checkLikeStatus() {
	        var localLogIdx = $('input[name="localLogIdx"]').val();
	        var userIdx = $('input[name="sessionUserIdx"]').val();

	        console.log('localLogIdx:', localLogIdx);  // Debug log
	        console.log('userIdx:', userIdx);  // Debug log
	        
	        if (!userIdx) {
	            return;
	        }

	        $.ajax({
	            url: "checkLocalLogLikeStatus.ld",
	            type: "post",
	            data: {
	                localLogIdx: localLogIdx,
	                userIdx: userIdx
	            },
	            success: function(res) {
	                var $clapButton = $('#localLogClap');
	                if (res.status === 'liked') {
	                    $clapButton.html('<i class="ph-fill ph-hands-clapping"></i> ' + res.likeCount).removeClass('beforelike').addClass('afterlike');
	                } else {
	                    $clapButton.html('<i class="ph ph-hands-clapping"></i> ' + res.likeCount).removeClass('afterlike').addClass('beforelike');
	                }
	            },
	            error: function() {
	                showAlert("좋아요 상태 확인 오류");
	            }
	        });
	    }
	}); */

	/* 	$(document).ready(function() {
	 // 로컬로그 좋아요 버튼 클릭 시
	 $(document).on('click', '#localLogClap', function() {
	 var $this = $(this);
	 var itemIdx = $('input[name="localLogIdx"]').val();
	 var itemType = 'localLog';
	 var userIdx = $('input[name="sessionUserIdx"]').val();

	 if (!userIdx) {
	 showAlert("로그인 후 이용하실 수 있습니다.");
	 return;
	 }

	 $.ajax({
	 url : "localLogLike.ld",
	 type : "post",
	 data : {
	 itemIdx : itemIdx,
	 itemType : itemType
	 },
	 success : function(res) {
	 if (res.status === 'liked') {
	 $this.removeClass('beforelike').addClass('afterlike');
	 $this.html('<i class="ph-fill ph-hands-clapping"></i> ' + res.likeCount);
	 } else if (res.status === 'unliked') {
	 $this.removeClass('afterlike').addClass('beforelike');
	 $this.html('<i class="ph ph-hands-clapping"></i> ' + res.likeCount);
	 }
	 },
	 error : function() {
	 showAlert("전송 오류2");
	 }
	 });
	 });

	 // 로드 시 좋아요 상태 확인
	 checkLikeStatus();

	 function checkLikeStatus() {
	 var itemIdx = $('input[name="localLogIdx"]').val();
	 var itemType = 'localLog';
	 var userIdx = $('input[name="sessionUserIdx"]').val();

	 if (!userIdx) {
	 return;
	 }

	 $.ajax({
	 url : "checkLocalLogLikeStatus.ld",
	 type : "post",
	 data : {
	 itemIdx : itemIdx,
	 itemType : itemType,
	 userIdx : userIdx
	 },
	 success : function(res) {
	 var $clapButton = $('#localLogClap');
	 if (res.status === 'liked') {
	 $clapButton.html('<i class="ph-fill ph-hands-clapping"></i> ' + res.likeCount).removeClass('beforelike').addClass('afterlike');
	 } else {
	 $clapButton.html('<i class="ph ph-hands-clapping"></i> ' + res.likeCount).removeClass('afterlike').addClass('beforelike');
	 }
	 },
	 error : function() {
	 showAlert("좋아요 상태 확인 오류");
	 }
	 });
	 }
	 }); */

/* 	$(document).ready(function() {
		// 로컬로그 좋아요 버튼 클릭 시
		$(document).on('click', '#localLogClap', function() {
			var $this = $(this);
			var localLogIdx = $this.data('local-log-idx');
			var userIdx = $('input[name="sessionUserIdx"]').val();

			if (!userIdx) {
				showAlert("로그인 후 이용하실 수 있습니다.");
				return;
			}

			$.ajax({
				url : "localLogLike.ld",
				type : "post",
				data : {
					localLogIdx : localLogIdx
				},
				success : function(res) {
					if (res.status === 'liked') {
						$this.html('<i class="ph-fill ph-hands-clapping"></i> ' + res.likeCount);
					} else if (res.status === 'unliked') {
						$this.html('<i class="ph ph-hands-clapping"></i> ' + res.likeCount);
					}
				},
				error : function() {
					showAlert("전송 오류2");
				}
			});
		});

		// 로드 시 좋아요 상태 확인
		checkLikeStatus();

		function checkLikeStatus() {
			var localLogIdx = $('input[name="localLogIdx"]').val();
			var userIdx = $('input[name="sessionUserIdx"]').val();

			if (!userIdx) {
				return;
			}

			$.ajax({
				url : "checkLocalLogLikeStatus.ld",
				type : "post",
				data : {
					localLogIdx : localLogIdx
				},
				success : function(res) {
					var $clapButton = $('#localLogClap');
					if (res.status === 'liked') {
						$clapButton.html('<i class="ph-fill ph-hands-clapping"></i> ' + res.likeCount);
					} else {
						$clapButton.html('<i class="ph ph-hands-clapping"></i> ' + res.likeCount);
					}
				},
				error : function() {
					showAlert("좋아요 상태 확인 오류");
				}
			});
		}
	}); */
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<a href="javascript:history.back()" class="back-button">
		<i class="ph ph-caret-left"></i>
	</a>
	<div class="container mx-auto" style="width: 700px; padding-top: 50px;">
		<div class="row">
			<div class="col-md-6">
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
					<a href="#" style="color: black; font-decoration: none">
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
				<div class="mb-3">
					<p>${fn:replace(localLog.content, newLine, "<br>")}</p>
				</div>
				<a href="#">
					<i class="ph ph-bookmark-simple" id="localLogBookmark"></i>
				</a>
				<%-- <a href="javascript:void(0);" class="text-dark like-button beforelike" id="localLogClap" data-local-log-idx="${localLog.localLogIdx}" style="text-decoration: none; font-size: 14px;">
					<i class="ph ph-hands-clapping"></i> ${localLog.likeCount}
				</a> --%>
				<%-- <a href="javascript:void(0);" class="text-dark like-button beforelike" id="localLogClap" data-item-idx="${localLog.localLogIdx}" data-item-type="localLog" style="text-decoration: none; font-size: 14px;">
					<i class="ph ph-hands-clapping"></i> ${localLog.likeCount}
				</a> --%>
				<%-- <a href="javascript:void(0);" class="text-dark" id="localLogClap" data-item-idx="${localLog.localLogIdx}" data-item-type="localLog" style="text-decoration: none; font-size: 14px;">
					<i class="ph ph-hands-clapping"></i> ${localLog.likeCount}
				</a> --%>
				<a href="#">
					<i class="ph ph-hands-clapping" id="localLogClap"></i>
				</a>
			</div>
		</div>
		<hr>
		<div class="row mt-3 pb-5">
			<div class="col-12">
				<p style="font-size: 14px;">
					<c:if test="${not empty place.createdBy}">
						<span>
							<b><c:out value="${place.createdByNickname}" /></b>
						</span>
                    님이 처음으로 발견한 공간이에요!
                </c:if>
				</p>
				<c:choose>
					<c:when test="${not empty guestBooks}">
						<c:forEach var="guestBook" items="${guestBooks}">
							<div class="d-flex align-items-center mb-3 pt-2">
								<a href="#" style="color: black; text-decoration: none">
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
							<div class="d-flex justify-content-between mt-3">
								<a href="javascript:void(0);" class="text-dark like-button beforelike" data-item-idx="${guestBook.itemIdx}" data-guest-book-idx="${guestBook.guestBookIdx}" style="text-decoration: none; font-size: 14px;">
									<i class="ph ph-thumbs-up"></i> 도움이 됐어요
								</a>
								<%-- <a href="javascript:void(0);" class="text-dark like-button beforelike" data-item-idx="${guestBook.guestBookIdx}" data-item-type="guestBook" style="text-decoration: none; font-size: 14px;">
									<i class="ph ph-thumbs-up"></i> 도움이 됐어요
								</a> --%>
								<a href="#" class="text-dark" style="text-decoration: none;">
									<i class="ph ph-dots-three"></i>
								</a>
							</div>
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
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<input type="hidden" name="localLogIdx" value="${localLog.localLogIdx}" />
</body>
</html>