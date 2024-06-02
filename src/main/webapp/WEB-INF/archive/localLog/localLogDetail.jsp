<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive-localLog.css" />
<script src="${ctp}/js/common/basicAlert.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const links = document.querySelectorAll('.archive-container ul li a');
    const currentPage = window.location.pathname.split('/').pop();

    links.forEach(link => {
        link.addEventListener('click', function() {
            links.forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });

        if (link.getAttribute('href').includes(currentPage)) {
            link.classList.add('active');
        }
    });
});

// 화살표클릭시 화면 상단으로 부드럽게 이동하기
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

$(document).ready(function() {
$('#updateAndDeleteLocalLog').on('show.bs.modal', function(event) {
   var button = $(event.relatedTarget); // 클릭된 버튼
   var localLogIdx = button.data('localLog-id'); // data-localLog-id의 값
   var modal = $(this);

   modal.find('#deleteLocalLogBtn').data('localLog-id', localLogIdx); // 삭제 버튼에 localLogIdx 설정
   modal.find('#updateLocalLogBtn').data('localLog-id', localLogIdx); // 수정 버튼에 localLogIdx 설정
});
});

function editLocalLog(localLogIdx) {
    window.location.href = 'updateLocalLog.a?localLogIdx=' + localLogIdx;
}

function deleteCheck(localLogIdx) {
    Swal.fire({
        text: '로컬로그를 삭제하시겠습니까?',
        showCancelButton: true,
        confirmButtonText: '삭제',
        cancelButtonText: '취소',
        customClass: {
            confirmButton: 'swal2-confirm',
            cancelButton: 'swal2-cancel',
            popup: 'custom-swal-popup',
            htmlContainer: 'custom-swal-text',
        },
        buttonsStyling: false
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: 'deleteLocalLog.a',
                type: 'POST',
                data: { localLogIdx: localLogIdx },
                success: function(response) {
                    if (response === 'deleted') {
                        $('#updateAndDeleteLocalLog').modal('hide'); // 모달을 숨깁니다.
                        Swal.fire({
                            text: "로컬로그가 삭제되었습니다.",
                            confirmButtonText: '확인',
                            customClass: {
                                confirmButton: 'swal2-confirm',
                                popup: 'custom-swal-popup',
                                htmlContainer: 'custom-swal-text'
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                            	window.location.href = "archive-localLog.a";
                            }
                        });
                    } else if (response === 'failed') {
                        showAlert("로컬로그 삭제에 실패했습니다.");
                    } else {
                        console.error("Unexpected response:", response);
                        showAlert("예상치 못한 응답: " + response);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error during AJAX request:", status, error);
                    showAlert("로컬로그 삭제에 실패했습니다.");
                }
            });
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            $('#updateAndDeleteLocalLog').modal('hide'); // 취소 버튼을 누를 때도 모달을 숨깁니다.
        }
    });
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container">
		<div class="archive-container">
			<div class="row mb-5">
				<div class="col-3">
					<div class="photo-placeholder">
						<c:choose>
							<c:when test="${not empty users.profileImage}">
								<img id="profile-photo" src="${ctp}/images/profileImage/${users.profileImage}" alt="Profile Photo" class="profile-photo" />
							</c:when>
							<c:otherwise>
								<span id="profile-icon" class="profile-icon">
									<i class="ph ph-user-focus" id="profileIcon"></i>
								</span>
								<img id="profile-photo" src="" alt="Profile Photo" class="profile-photo d-none" />
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="col-9">
					<div class="mb-3" id="nickname">${users.nickname}</div>
					<c:choose>
						<c:when test="${not empty users.introduction}">
							<div>${users.introduction}</div>
						</c:when>
						<c:otherwise>
							<div>
								<a href="checkPassword.u" id="updateProfileLink">클릭하고 소개 글을 입력해 보세요.</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<ul class="d-flex justify-content-between list-unstyled">
				<li>
					<a href="archive-localLog.a" id="localLog">로컬로그</a>
					<span>${localLogCount}</span>
				</li>
				<li>
					<a href="archive-guestBook.a" id="guestBook">방명록</a>
				</li>
				<li>
					<a href="archive-curation.a" id="curation">큐레이션</a>
				</li>
			</ul>
			<hr>
			<div class="container my-4 pt-3">
				<div class="row justify-content-center">
					<div class="col-12 col-md-8 col-lg-6" style="max-width: 650px;">
						<div class="d-flex justify-content-between">
							<div>
								<a href="javascript:history.back()" style="text-decoration: none;" class="text-dark">
									<i class="ph ph-caret-left"></i>
								</a>
								<span class="text-dark" style="font-size: 14px;">${localLog.visitDate}&nbsp;방문</span>
							</div>
							<div>
								<a href="#" data-toggle="modal" data-target="#updateAndDeleteLocalLog" class="text-dark" style="text-decoration: none;" data-localLog-id="${localLog.localLogIdx}">
									<i class="ph ph-dots-three" style="font-size: 20px"></i>
								</a>
							</div>
						</div>
						<div class="position-relative" style="width: 100%; margin: auto;">
							<div id="cardCarousel" class="carousel slide" data-ride="carousel">
								<ol class="carousel-indicators">
									<c:forEach var="photo" items="${localLog.photos.split('/')}" varStatus="status">
										<li data-target="#cardCarousel" data-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}"></li>
									</c:forEach>
								</ol>
								<div class="carousel-inner">
									<c:forEach var="photo" items="${localLog.photos.split('/')}" varStatus="status">
										<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
											<img class="d-block w-100" src="${ctp}/images/localLog/${photo}" alt="Slide ${status.index + 1}">
										</div>
									</c:forEach>
								</div>
								<a class="carousel-control-prev" href="#cardCarousel" role="button" data-slide="prev">
									<span class="carousel-control-prev-icon" aria-hidden="true"></span>
									<span class="sr-only">Previous</span>
								</a>
								<a class="carousel-control-next" href="#cardCarousel" role="button" data-slide="next">
									<span class="carousel-control-next-icon" aria-hidden="true"></span>
									<span class="sr-only">Next</span>
								</a>
							</div>
							<div class="card-img-overlay">
								<div class="card-title" style="color: white; font-size: 18px">
									<b>${localLog.placeName}</b>
								</div>
								<div class="card-text" style="color: white; font-size: 14px;">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</div>
							</div>
						</div>
						<c:if test="${not empty localLog.content}">
							<div class="localLogContent-container mt-3">
								<div>${fn:replace(localLog.content, newLine, "<br>")}</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			<hr>
		</div>
		<!-- 위로가기 버튼 -->
		<div id="topBtn" class="">
			<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
		</div>
	</div>
	<!-- updateAndDeleteLocalLog Modal -->
	<div class="modal fade" id="updateAndDeleteLocalLog" tabindex="-1" role="dialog" aria-labelledby="updateAndDeleteLocalLogLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="btn btn-block mt-2" id="updatedLocalLogBtn" onclick="editLocalLog(${localLog.localLogIdx})">데이로그 수정</button>
					<button type="button" class="btn btn-block mt-2" id="deleteLocalLogBtn" onclick="deleteCheck(${localLog.localLogIdx})">데이로그 삭제</button>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
</body>
</html>