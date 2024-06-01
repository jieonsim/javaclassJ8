<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://example.com/custom-functions" prefix="custom"%>
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
<style>
.card-container {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.card {
	max-width: 300px;
	width: 100%;
	border: none;
	/* box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); */
	/* -webkit-box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
	-moz-box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
	-ms-box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
	-o-box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22); */
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.10), 0 10px 10px rgba(0, 0, 0, 0.10);
	border-radius: 10px;
	overflow: hidden;
}

.card img {
	border-bottom: 1px solid #e0e0e0;
}

.card-body {
	padding: 15px;
	/* height: 150px; */
}

.card-title {
	font-size: 16px;
	margin-top: 5px;
	margin-bottom: 5px;
	font-weight: bold;
	margin-top: 5px;
}

.card-text {
	font-size: 14px;
	margin-bottom: 0px;
}

.card-text.text-muted {
	font-size: 12px;
	margin-bottom: 15px;
}

.card-body::before {
	content: "";
	position: absolute;
	bottom: 0;
	left: 0;
	width: 100%;
	/* height: 50px; */
	/* background: linear-gradient(to top, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0)); */
}

/* .stretched-link::after {
	height: 150px;
} */
#topBtn {
	position: fixed;
	/*right: 1rem;*/
	right: 10%;
	bottom: 3%;
	transition: 0.7s ease;
}

.on {
	/*opacity: 0.8;*/
	cursor: pointer;
	bottom: 0;
}

#arrowUp {
	font-size: 45px;
	color: gainsboro;
}
</style>
<script>
	//화살표클릭시 화면 상단으로 부드럽게 이동하기
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
			url : "${ctp}/getLocalLogs",
			type : "post",
			data : {
				pag : curPage
			},
			success : function(res) {
				console.log("AJAX Response:", res);
				$("#list-wrap").append(res);
				updateTotalPages(); // AJAX 응답 후 totalPages 요소 확인
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

	/* 	function getNextList(curPage) {
	 $.ajax({
	 url : "${ctp}/getRandomLocalLog",
	 type : "post",
	 data : {
	 pag : curPage
	 },
	 success : function(res) {
	 console.log("AJAX Response:", res);
	 $("#list-wrap").append(res);
	 updateTotalPages(); // AJAX 응답 후 totalPages 요소 확인
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
	 }); */
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container">
		<div id="list-wrap">
			<c:forEach var="localLog" items="${localLogs}">
				<div class="container card-container mt-5">
					<div class="card">
						<img class="card-img-top" src="${ctp}/images/localLog/${localLog.coverImage}" alt="Card image" style="width: 100%; height: 400px;">
						<div class="card-body position-relative">
							<h5 class="card-title">${localLog.placeName}</h5>
							<p class="card-text text-muted">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
							<c:if test="${not empty localLog.content}">
								<p class="card-text">${fn:replace(custom:truncateWithEllipsis(localLog.content, 50), newLine, "<br>")}</p>
							</c:if>
							<a href="#" class="stretched-link"></a>
						</div>
					</div>
				</div>
				<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
			</c:forEach>
		</div>
		<!-- 위로가기 버튼 -->
		<div id="topBtn">
			<i class="ph-fill ph-arrow-circle-up" id="arrowUp"></i>
		</div>
	</div>
	<div class="pt-5">footer</div>
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" id="totalPages" value="${totalPages}" />
</body>
</html>