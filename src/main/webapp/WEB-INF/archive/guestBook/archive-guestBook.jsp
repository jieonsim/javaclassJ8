<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive-guestBook.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<!-- <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet"> -->
<script>
$(document).ready(function() {
    $('#updateGuestBook').on('show.bs.modal', function(event) {
        var button = $(event.relatedTarget); // 클릭된 버튼
        var guestBookIdx = button.data('guestbook-id'); // data-guestbook-id의 값
        var visibilityStatus = button.data('visibility'); // data-visibility의 값
        var modal = $(this);

        if (visibilityStatus === 'private') {
            modal.find('input[type="checkbox"]').prop('checked', false);
        } else {
            modal.find('input[type="checkbox"]').prop('checked', true);
        }

        modal.find('#deleteGuestBookBtn').data('guestbook-id', guestBookIdx); // 삭제 버튼에 guestBookIdx 설정
    });

    $('input[type="checkbox"]').on('change', function() {
        var guestBookIdx = $(this).closest('#updateGuestBook').find('#deleteGuestBookBtn').data('guestbook-id');
        var visibility = this.checked ? 'public' : 'private';
        toggleVisibility(guestBookIdx, visibility);
    });
});


function toggleVisibility(guestBookIdx, visibility) {
 var message = visibility === 'public' ? '방명록이 공개 처리되었습니다.' : '방명록이 비공개 처리되었습니다.';
 
 $.ajax({
     url: 'toggleVisibility.a',
     type: 'POST',
     data: { guestBookIdx: guestBookIdx, visibility: visibility },
     success: function(response) {
         if (response === 'success') {
             $('#updateGuestBook').modal('hide');
             Swal.fire({
                 text: message,
                 confirmButtonText: '확인',
                 customClass: {
                     confirmButton: 'swal2-confirm',
                     popup: 'custom-swal-popup',
                     htmlContainer: 'custom-swal-text'
                 }
             }).then((result) => {
                 if (result.isConfirmed) {
                     location.reload(); // 페이지를 새로고침하여 변경 사항을 반영합니다.
                 }
             });
         } else {
             console.error("Unexpected response:", response);
             showAlert("예상치 못한 응답: " + response);
         }
     },
     error: function(xhr, status, error) {
         console.error("Error during AJAX request:", status, error);
         showAlert("상태 변경에 실패했습니다.");
     }
 });
}

function deleteCheck(guestBookIdx) {
	var guestBookIdx = $('#deleteGuestBookBtn').data('guestbook-id');
	console.log("guestBookIdx:", guestBookIdx);  // 추가된 콘솔 로그
	
    Swal.fire({
        text: '방명록을 삭제하시겠습니까?',
        showCancelButton: true,
        confirmButtonText: '삭제',
        cancelButtonText: '취소',
        customClass: {
            confirmButton: 'swal2-confirm custom-confirm-button',
            cancelButton: 'swal2-cancel custom-cancel-button',
            popup: 'custom-swal-popup',
            htmlContainer: 'custom-swal-text',
        },
        buttonsStyling: false
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: 'deleteGuestBook.a',
                type: 'POST',
                data: { guestBookIdx: guestBookIdx },
                success: function(response) {
                    if (response === 'deleted') {
                        $('#updateGuestBook').modal('hide'); // 모달을 숨깁니다.
                        Swal.fire({
                            text: "방명록이 삭제되었습니다.",
                            confirmButtonText: '확인',
                            customClass: {
                                confirmButton: 'swal2-confirm',
                                popup: 'custom-swal-popup',
                                htmlContainer: 'custom-swal-text'
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload(); // 페이지를 새로고침하여 삭제된 방명록을 반영합니다.
                            }
                        });
                    } else if (response === 'failed') {
                        showAlert("방명록 삭제에 실패했습니다.");
                    } else {
                        console.error("Unexpected response:", response);
                        showAlert("예상치 못한 응답: " + response);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error during AJAX request:", status, error);
                    showAlert("방명록 삭제에 실패했습니다.");
                }
            });
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            $('#updateGuestBook').modal('hide'); // 취소 버튼을 누를 때도 모달을 숨깁니다.
        }
    });
}

//화살표클릭시 화면 상단으로 부드럽게 이동하기
$(window).scroll(function(){
	if($(this).scrollTop() > 100) {
		$("#topBtn").addClass("on");
	}
	else {
		$("#topBtn").removeClass("on");
	}
	
	$("#topBtn").click(function(){
		window.scrollTo({top:0, behavior: "smooth"});
	});
});

function getNextList(curPage) {
    $.ajax({
        url: "getNextGuestBook.a",
        type: "post",
        data: { pag: curPage },
        success: function(res) {
            console.log("AJAX Response:", res);
            $("#list-wrap").append(res);
            updateTotalPages(); // AJAX 응답 후 totalPages 요소 확인
        },
        error: function(err) {
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
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container px-5" id="archive-container">
		<jsp:include page="/WEB-INF/archive/archive-profile.jsp" />
		<div id="list-wrap">
			<c:choose>
				<c:when test="${not empty guestBooks}">
					<c:forEach var="guestBook" items="${guestBooks}">
						<div class="d-flex flex-column border-bottom py-3">
							<div>
								<div id="guestBookPlaceName" class="d-flex justify-content-between">
									<b>${guestBook.placeName}</b>
									<span class="guestbook-like-button" style="cursor: default;">
										<i class="ph ph-thumbs-up"></i>&nbsp;${guestBook.likeCount}
									</span>
								</div>
								<div class="text-muted">${guestBook.region1DepthName},&nbsp;${guestBook.region2DepthName}&nbsp;·&nbsp;${guestBook.categoryName}</div>
							</div>
							<c:if test="${not empty guestBook.content}">
								<div class="mt-2 p-3" id="guestBookContent">${fn:replace(guestBook.content, newLine, "<br>")}</div>
							</c:if>
							<div class="row">
								<div class="col-sm-6">
									<div class="text-muted small mt-2">
										<fmt:formatDate value="${guestBook.visitDate}" pattern="yyyy년 MM월 dd일" />
										방문
										<c:if test="${not empty guestBook.companions && guestBook.companions != '기타'}">&nbsp;·&nbsp;&nbsp;${guestBook.companions}</c:if>
									</div>
								</div>
								<div class="col-sm-6" id="guestBookSetUp">
									<div class="d-flex justify-content-end mt-2">
										<c:if test="${guestBook.visibility == 'private'}">
											<i class="ph ph-lock mr-2"></i>
										</c:if>
										<a href="#" data-toggle="modal" data-target="#updateGuestBook" class="text-dark" style="text-decoration: none;" data-guestbook-id="${guestBook.guestBookIdx}" data-visibility="${guestBook.visibility}">
											<i class="ph ph-dots-three"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
						<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
					</c:forEach>
					<!-- 위로가기 버튼 -->
					<div id="topBtn" class="">
						<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
					</div>
				</c:when>
				<c:otherwise>
					<div class="text-center" style="margin-top: 100px; margin-bottom: 150px;">
						<div class="mb-2">다녀온 공간에 대한 후기를 남겨보세요.</div>
						<button class="btn btn-custom" id="firstRecord" onclick="location.href='record-guestBook.g'">첫 방명록 남기기</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!-- updateGuestBook Modal -->
	<div class="modal fade" id="updateGuestBook" tabindex="-1" role="dialog" aria-labelledby="updateGuestBookLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body p-4">
					<div class="row">
						<div class="mx-4 pb-3" id="visibilityStatus">전체공개</div>
						<label class="switch">
							<input type="checkbox">
							<span class="slider round"></span>
						</label>
					</div>
					<button type="button" class="btn btn-block mt-2" id="deleteGuestBookBtn" onclick="deleteCheck()">방명록 삭제</button>
				</div>
			</div>
		</div>
	</div>
	<!-- updateGuestBook Modal -->
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<input type="hidden" id="totalPages" value="${totalPages}" />
</body>
</html>