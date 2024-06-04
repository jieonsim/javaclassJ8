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
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container" id="archive-container" style="padding-top: 60px;">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-8">
				<div class="d-flex justify-content-first">
					<div>
						<a href="javascript:history.back()" style="text-decoration: none;" class="text-dark">
							<i class="ph ph-caret-left"></i>
						</a>
						<span class="text-dark" style="font-size: 18px;">${localLog.visitDate}&nbsp;방문</span>
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
	<jsp:include page="/WEB-INF/include/footer.jsp" />
	<input type="hidden" id="message" value="${message}" />
	<input type="hidden" id="url" value="${url}" />
	<input type="hidden" id="sessionUserIdx" value="${sessionScope.sessionUserIdx}" />
</body>
</html>