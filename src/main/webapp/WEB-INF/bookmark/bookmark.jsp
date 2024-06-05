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
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/bookmark/bookmark.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
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
			url : "getNextBookmarks.b",
			type : "post",
			data : {
				pag : curPage
			},
			success : function(res) {
				console.log("AJAX Response:", res);
				$("#list-wrap").append(res);
				totalPages = updateTotalPages();
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
	});

	$(document).ready(function() {
	    let editMode = false;
	    let initialState = [];

	    $('#bookmarkEdit').click(function() {
	        if (!editMode) {
	            // Store the initial state
	            $('.bookmark-container .image-container').each(function() {
	                initialState.push({
	                    card: $(this).closest('.card').data('locallogid'),
	                    selected: $(this).find('.overlay').hasClass('selected')
	                });
	            });

	            $('.bookmark-container .image-container').append('<div class="overlay"><div class="checkbox"></div></div>');
	            $(this).text('삭제');
	            editMode = true;
	        } else {
	            const selectedBookmarks = [];
	            $('.overlay.selected').each(function() {
	                const localLogIdx = $(this).closest('.card').data('locallogid');
	                selectedBookmarks.push(localLogIdx);
	            });

	            if (selectedBookmarks.length === 0) {
	                // Revert to initial state if no items are selected
	                revertToInitialState();
	                return;
	            }

	            showConfirmAlert(selectedBookmarks);
	        }
	    });

	    $(document).on('click', '.overlay', function(e) {
	        e.stopPropagation(); // Prevent the stretched link from triggering
	        $(this).toggleClass('selected');
	        $(this).parent().toggleClass('checked');
	    });

	    function showConfirmAlert(selectedBookmarks) {
	        Swal.fire({
	            text: '선택된 공간을 정말 삭제하시겠어요?',
	            showCancelButton: true,
	            confirmButtonText: '삭제',
	            cancelButtonText: '취소',
	            customClass: {
	                confirmButton: 'swal2-confirm',
	                cancelButton: 'swal2-cancel',
	                popup: 'custom-swal-popup',
	                htmlContainer: 'custom-swal-text',
	            },
	        }).then((result) => {
	            if (result.isConfirmed) {
	                if (selectedBookmarks.length > 0) {
	                    $.ajax({
	                        url: 'deleteBookmarks.b',
	                        type: 'POST',
	                        data: { localLogIdxs: selectedBookmarks },
	                        traditional: true,
	                        success: function(response) {
	                            if (response === 'success') {
	                                window.location.reload();
	                            } else {
	                                showAlert('북마크 삭제에 실패하였습니다.');
	                            }
	                        },
	                        error: function() {
	                            showAlert("에러 발생");
	                        }
	                    });
	                }
	            } else {
	                // Revert to initial state if "취소" is clicked
	                revertToInitialState();
	            }
	        });
	    }

	    function revertToInitialState() {
	        $('.bookmark-container .image-container').each(function(index) {
	            const state = initialState[index];
	            const overlay = $(this).find('.overlay');
	            if (state.selected) {
	                overlay.addClass('selected');
	                $(this).addClass('checked');
	            } else {
	                overlay.removeClass('selected');
	                $(this).removeClass('checked');
	            }
	        });
	        $('#bookmarkEdit').text('편집');
	        $('.overlay').remove();
	        editMode = false;
	    }
	});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="bookmark-container">
		<c:if test="${not empty bookmarks}">
			<div class="d-flex justify-content-between mb-3">
				<span style="font-size: 18px;"><b>저장된 공간</b></span>
				<a href="#" id="bookmarkEdit">편집</a>
			</div>
		</c:if>
		<c:choose>
			<c:when test="${not empty bookmarks}">
				<div class="container-fluid px-0" id="list-wrap">
					<div class="row no-gutters">
						<c:forEach var="bookmark" items="${bookmarks}">
							<div class="col-md-4">
								<div class="card img-fluid" id="bookmark-localLog-card" data-locallogid="${bookmark.localLogIdx}">
									<div class="image-container">
										<img class="card-img-top" src="${ctp}/images/localLog/${bookmark.coverImage}" alt="Card image" id="bookmark-localLog-card-img">
										<div class="gradient-overlay"></div>
										<div class="card-img-overlay h-100 d-flex flex-column justify-content-end">
											<p class="card-text">
												<c:choose>
													<c:when test="${bookmark.categoryName == '바'}">🍸&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '카페'}">☕&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '음식점'}">🍴&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '디저트 / 베이커리'}">🍰&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '포토존'}">🤳🏻&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '광장'}">👥&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '관광지'}">🗽&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '종교시설'}">⛪&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '역사 유적지'}">🕌&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '자연'}">🍃&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '복합문화공간'}">🎨&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '박물관'}">🏛️&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '음악'}">🎵&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '전시'}">🖼️&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '공연'}">🎫&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '도서관'}">📖&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '샵'}">🛍️&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '서점'}">📚&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '시장'}">🛒&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '쇼핑몰'}">🏬&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '호텔'}">🏨&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '스테이'}">🛏️&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '미용 / 스파'}">💇🏻‍♀️&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '오락'}">🎮&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '운동'}">🏃🏻&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '스튜디오 / 클래스'}">👩🏻‍💻&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '골프장'}">⛳&nbsp;</c:when>
													<c:when test="${bookmark.categoryName == '캠핑장'}">🏕️&nbsp;</c:when>
												</c:choose>
												<span>&nbsp;${bookmark.region1DepthName},&nbsp;${bookmark.region2DepthName}</span>
											</p>
											<!-- <div class="gradient-overlay"></div> -->
											<a href="localLogDetail.ld?localLogIdx=${bookmark.localLogIdx}" class="stretched-link"></a>
										</div>
									</div>
									<div class="card-body">
										<b>${bookmark.placeName}</b>
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
				<div class="text-center" style="margin-top: 150px; margin-bottom: 200px;">
					<div class="mb-2" style="font-weight: bold; font-size: 18px;">저장된 콘텐츠가 없습니다.</div>
					<div class="mb-2">궁금한 공간을 검색하고 저장해보세요.</div>
					<button class="btn btn-custom" id="goToSearch" onclick="location.href='${ctp}/main'">둘러보기</button>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<input type="hidden" id="totalPages" value="${totalPages}" />
</body>
</html>