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
	} else {
		$("#topBtn").removeClass("on");
	}
	
	$("#topBtn").click(function(){
		window.scrollTo({top:0, behavior: "smooth"});
	});
});

function getNextList(curPage) {
    $.ajax({
        url: "getNextLocalLog.p",
        type: "post",
        data: { pag: curPage, userIdx: $('#userIdx').val() },
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
			<ul class="d-flex justify-content-between list-unstyled">
				<li>
					<a href="profileLocalLog.p?userIdx=${user.userIdx}" id="localLog">로컬로그</a>
					<c:if test="${not empty localLogs}">
						<span>${localLogCount}</span>
					</c:if>
				</li>
				<li>
					<a href="profileGuestbook.p?userIdx=${user.userIdx}" id="guestBook">방명록</a>
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
			<c:choose>
				<c:when test="${not empty localLogs}">
					<div class="container-fluid px-0" id="list-wrap">
						<div class="row no-gutters">
							<c:forEach var="localLog" items="${localLogs}">
								<c:if test="${localLog.visibility == 'public'}">
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
												<a href="#" class="stretched-link"></a>
											</div>
										</div>
									</div>
								</c:if>
								<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
							</c:forEach>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="text-center" style="margin-top: 100px;">
						<i class="ph ph-image" style="font-size: 48px"></i>
						<div class="mb-1 mt-3" style="font-weight: bold">콘텐츠가 없습니다.</div>
						<div style="color: dimgray">아직 콘텐츠가 존재하지 않습니다.</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<input type="hidden" id="totalPages" value="${totalPages}" />
	<input type="hidden" name="userIdx" value="${user.userIdx}" />
</body>
</html>