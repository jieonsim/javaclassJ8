<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Lens</title>
<jsp:include page="/WEB-INF/include/bs4.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive-guestBook.css" />
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
        url: "getNextGuestBook.p",
        type: "post",
        data: { pag: curPage, userIdx: $('input[name="userIdx"]').val() },
        success: function(res) {
            //console.log("AJAX Response:", res);
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
	<div class="container">
		<div class="archive-container">
			<div class="row mb-4">
				<div class="col-3">
					<div class="photo-placeholder">
						<c:choose>
							<c:when test="${not empty user.profileImage}">
								<img id="profile-photo" src="${ctp}/images/profileImage/${user.profileImage}" alt="Profile Photo" class="profile-photo" />
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
					<div class="nickname-container">
						<c:if test="${user.visibility == 'private'}">
							<i class="ph ph-lock"></i>
						</c:if>
						<span id="nickname">${user.nickname}</span>
					</div>
					<c:choose>
						<c:when test="${not empty user.introduction}">
							<div>${user.introduction}</div>
						</c:when>
					</c:choose>
				</div>
			</div>
			<ul class="d-flex justify-content-between list-unstyled pb-3">
				<li>
					<a href="profileLocalLog.p?userIdx=${user.userIdx}" id="localLog">로컬로그</a>
				</li>
				<li>
					<a href="profileGuestbook.p?userIdx=${user.userIdx}" id="guestBook">방명록</a>
					<c:if test="${not empty guestBooks}">
						<span>${guestBookCount}</span>
					</c:if>
				</li>
				<li>
					<a href="#" id="curation">큐레이션</a>
				</li>
			</ul>
			<c:if test="${user.visibility == 'private'}">
				<div class="text-center" style="margin-top: 100px;">
					<i class="ph ph-lock" style="font-size: 48px"></i>
					<div class="mb-1 mt-3" style="color: dimgray">비공개 계정입니다.</div>
				</div>
			</c:if>
			<div id="list-wrap">
				<c:choose>
					<c:when test="${not empty guestBooks}">
						<c:forEach var="guestBook" items="${guestBooks}">
							<c:if test="${guestBook.visibility == 'public'}">
								<div class="d-flex flex-column border-bottom py-3">
									<div>
										<div id="guestBookPlaceName">
											<b>${guestBook.placeName}</b>
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
												<c:if test="${guestBook.companions != '기타'}">&nbsp;·&nbsp;&nbsp;${guestBook.companions}</c:if>
											</div>
										</div>
										<div class="col-sm-6" id="guestBookSetUp">
											<div class="d-flex justify-content-end mt-2">
												<c:if test="${guestBook.visibility == 'private'}">
													<i class="ph ph-lock mr-2"></i>
												</c:if>
											</div>
										</div>
									</div>
								</div>
							</c:if>
							<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
						</c:forEach>
						<!-- 위로가기 버튼 -->
						<div id="topBtn" class="">
							<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
						</div>
					</c:when>
					<c:otherwise>
						<div class="text-center" style="margin-top: 100px;">
							<div class="mb-2">다녀온 공간에 대한 후기를 남겨보세요.</div>
							<button class="btn btn-custom" id="firstRecord" onclick="location.href='record-guestBook.g'">첫 방명록 남기기</button>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<input type="hidden" id="message" value="message" />
	<input type="hidden" id="url" value="url" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<input type="hidden" id="totalPages" value="${totalPages}" />
	<input type="hidden" name="userIdx" value="${user.userIdx}" />
</body>
</html>