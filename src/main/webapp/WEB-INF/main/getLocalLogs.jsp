<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://example.com/custom-functions" prefix="custom"%>
<%
pageContext.setAttribute("newLine", "\n");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/main/main.css" />
<jsp:include page="/WEB-INF/include/bs4.jsp" />
<div id="list-wrap">
	<c:forEach var="localLog" items="${localLogs}">
		<div class="container card-container mt-5">
			<div class="card">
				<div id="carousel-${localLog.localLogIdx}" class="carousel slide carousel-fade" data-ride="carousel" data-interval="2000">
					<div class="carousel-inner">
						<c:forEach var="photoUrl" items="${localLog.photoUrls}" varStatus="status">
							<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
								<img src="${ctp}/images/localLog/${photoUrl}" class="d-block w-100" alt="Local Log Image">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="card-body position-relative">
					<h5 class="card-title d-flex justify-content-between align-items-center">
						<span>${localLog.placeName}</span>
					</h5>
					<p class="card-text text-muted">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
					<c:if test="${not empty localLog.content}">
						<p class="card-text">${fn:replace(custom:truncateWithEllipsis(localLog.content, 50), newLine, "<br>")}</p>
					</c:if>
				</div>
				<a href="localLogDetail.ld?localLogIdx=${localLog.localLogIdx}" class="stretched-link"></a>
			</div>
		</div>
		<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
	</c:forEach>
</div>
<input type="hidden" id="message" value="${message}" />
<input type="hidden" id="url" value="${url}" />
<input type="hidden" id="totalPages" value="${totalPages}" />
<input type="hidden" id="localLogIdx" value="${localLog.localLogIdx}" />