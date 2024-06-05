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
	<div class="container px-5" id="archive-container">
		<jsp:include page="/WEB-INF/profile/anotherUserProfile.jsp" />
		<div id="list-wrap">
			<c:choose>
				<c:when test="${not empty guestBooks}">
					<c:forEach var="guestBook" items="${guestBooks}">
						<c:if test="${guestBook.visibility == 'public'}">
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
					<div class="text-center" style="margin-top: 100px; margin-bottom: 150px;">
						<i class="ph ph-image" style="font-size: 48px"></i>
						<div class="mb-1 mt-3" style="font-weight: bold">콘텐츠가 없습니다.</div>
						<div style="color: dimgray">아직 콘텐츠가 존재하지 않습니다.</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="message" />
	<input type="hidden" id="url" value="url" />
	<input type="hidden" name="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
	<input type="hidden" id="totalPages" value="${totalPages}" />
	<input type="hidden" name="userIdx" value="${user.userIdx}" />
</body>
</html>