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
    /* window.location.href = 'updateLocalLog.a?localLogIdx=' + localLogIdx; */
    window.location.href = '${ctp}/updateLocalLog?localLogIdx=' + localLogIdx;
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
	<div class="container" id="archive-container" style="padding-top: 60px;">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-8">
				<div class="d-flex justify-content-between">
					<div>
						<a href="javascript:history.back()" style="text-decoration: none;" class="text-dark">
							<i class="ph ph-caret-left"></i>
						</a>
						<span class="text-dark" style="font-size: 18px;">${localLog.visitDate}&nbsp;방문</span>
					</div>
					<div>
						<a href="#" data-toggle="modal" data-target="#updateAndDeleteLocalLog" class="text-dark" style="text-decoration: none;" data-localLog-id="${localLog.localLogIdx}">
							<i class="ph ph-dots-three" style="font-size: 26px"></i>
						</a>
					</div>
				</div>
				<div class="d-flex">
					<div class="position-relative" style="width: 60%; margin-right: 1rem;">
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
										<div class="gradient-overlay"></div>
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="card-img-overlay">
							<div class="card-title" style="font-size: 18px; font-weight: bold;">
								<b>${localLog.placeName}</b>
							</div>
							<div class="card-text" style="font-size: 14px;">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</div>
						</div>
					</div>
					<div class="localLogContent-container" style="width: 40%; background-color: #f2f2f2; padding: 20px;">
						<c:if test="${not empty localLog.content}">
							<div>${fn:replace(localLog.content, newLine, "<br>")}</div>
						</c:if>
						<c:if test="${empty localLog.content}">
							<div>로컬로그의 내용이 없습니다.</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- updateAndDeleteLocalLog Modal -->
	<div class="modal fade" id="updateAndDeleteLocalLog" tabindex="-1" role="dialog" aria-labelledby="updateAndDeleteLocalLogLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="btn btn-block mt-2" id="updatedLocalLogBtn" onclick="editLocalLog(${localLog.localLogIdx})">로컬로그 수정</button>
					<button type="button" class="btn btn-block mt-2" id="deleteLocalLogBtn" onclick="deleteCheck(${localLog.localLogIdx})">로컬로그 삭제</button>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" id="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
</body>
</html>