<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ page import="record.localLog.LocalLogVO"%>
<!-- 디버깅용 데이터 출력 -->
<%
if (request.getAttribute("localLogs") == null) {
	out.println("localLogs is null");
} else {
	List<LocalLogVO> localLogs = (List<LocalLogVO>) request.getAttribute("localLogs");
	out.println("localLogs size: " + localLogs.size());
	for (LocalLogVO log : localLogs) {
		out.println("LocalLog: " + log.toString());
	}
}
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

function getNextList(curPage) {
    $.ajax({
        url: "/javaclassJ8/getNextLocalLog.a",  // 여기서 your_context_path를 프로젝트 이름으로 변경합니다.
        type: "post",
        data: {
            pag: curPage
        },
        success: function(res) {
            console.log("AJAX Response:", res); // 응답 데이터를 콘솔에 출력
            $("#list-wrap").append(res);
            checkTotalPages(); // AJAX 응답 후에 totalPages 요소 확인
        },
        error: function(err) {
            console.log("Error: ", err);
        }
    });
}

function checkTotalPages() {
    let totalPagesElement = document.getElementById('totalPages');
    if (totalPagesElement) {
        let totalPages = parseInt(totalPagesElement.value, 10);
        console.log("Total Pages after AJAX:", totalPages); // AJAX 응답 후 totalPages 값 확인
    } else {
        console.error("totalPages element not found after AJAX!");
    }
}

document.addEventListener("DOMContentLoaded", function() {
    let lastScroll = 0;
    let curPage = 1;
    checkTotalPages(); // DOMContentLoaded 후 totalPages 요소 확인

    $(document).scroll(function() {
        let totalPagesElement = document.getElementById('totalPages');
        if (totalPagesElement) {
            let totalPages = parseInt(totalPagesElement.value, 10);
            let currentScroll = $(this).scrollTop(); // 스크롤바 위쪽 시작 위치, 처음은 0이다.
            let documentHeight = $(document).height(); // 화면에 표시되는 전체 문서의 높이
            let nowHeight = $(this).scrollTop() + $(window).height(); // 현재 화면 상단 + 현재 화면 높이

            // 스크롤이 아래로 내려갔을 때 이벤트 처리..
            if (currentScroll > lastScroll && curPage < totalPages) {
                if (documentHeight < (nowHeight + (documentHeight * 0.1))) {
                    console.log("Get next page");
                    curPage++;
                    getNextList(curPage);
                }
            }
            lastScroll = currentScroll;
        } else {
            console.error("totalPages element not found in scroll event!");
        }
    });
});

function checkTotalPages() {
    let totalPagesElement = document.getElementById('totalPages');
    if (totalPagesElement) {
        let totalPages = parseInt(totalPagesElement.value, 10);
        console.log("Total Pages after DOMContentLoaded:", totalPages); // DOMContentLoaded 후 totalPages 값 확인
    } else {
        console.error("totalPages element not found after DOMContentLoaded!");
    }
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
					<div class="nickname-container">
						<c:if test="${users.visibility == 'private'}">
							<i class="ph ph-lock"></i>
						</c:if>
						<span id="nickname">${users.nickname}</span>
					</div>
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
			<c:choose>
				<c:when test="${not empty localLogs}">
					<div class="container-flud px-0">
						<div class="row no-gutters">
							<c:forEach var="localLog" items="${localLogs}">
								<div class="col-md-4">
									<div class="card" id="archive-localLog-card">
										<div class="image-container">
											<img class="card-img-top" src="${ctp}/images/localLog/${localLog.coverImage}" alt="Card image" id="archive-localLog-card-img">
											<c:if test="${localLog.visibility == 'private'}">
												<i class="ph ph-lock icon-top-right"></i>
											</c:if>
										</div>
										<div class="card-body">
											<h4 class="card-title">${localLog.placeName}</h4>
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
											<a href="localLogDetail.a?localLogIdx=${localLog.localLogIdx}" class="stretched-link"></a>
										</div>
									</div>
								</div>
								<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
							</c:forEach>
						</div>
					</div>
					<!-- 위로가기 버튼 -->
					<div id="topBtn" class="">
						<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
					</div>
				</c:when>
				<c:otherwise>
					<div class="text-center" style="margin-top: 100px;">
						<div class="mb-2">내가 방문한 공간을 기록해보세요.</div>
						<button class="btn btn-custom" id="firstRecord" onclick="location.href='record-localLog.ll'">첫 로컬로그 남기기</button>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="text-center" style="margin-top: 100px;">
				<i class="ph ph-image" style="font-size: 48px"></i>
				<div class="mb-1 mt-3" style="font-weight: bold">콘텐츠가 없습니다.</div>
				<div style="color: dimgray">아직 콘텐츠가 존재하지 않습니다.</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<!-- 총 페이지 수를 숨김 필드로 설정 -->
	<input type="hidden" id="totalPages" value="${totalPages}" />
</body>
</html>