<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://example.com/custom-functions" prefix="custom"%>
<%
pageContext.setAttribute("newLine", "\n");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<div id="list-wrap">
	<c:forEach var="localLog" items="${localLogs}">
		<div class="container card-container mt-5">
			<div class="card">
				<img class="card-img-top" src="${ctp}/images/localLog/${localLog.coverImage}" alt="Card image" style="width: 100%; height: 400px;">
				<div class="card-body">
					<h5 class="card-title">${localLog.placeName}</h5>
					<p class="card-text text-muted">${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
					<p class="card-text">${fn:replace(custom:truncateWithEllipsis(localLog.content, 50), newLine, "<br>")}</p>
					<a href="#" class="stretched-link"></a>
				</div>
			</div>
		</div>
		<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
	</c:forEach>
</div>
<input type="hidden" id="message" value="${message}" />
<input type="hidden" id="url" value="${url}" />
<input type="hidden" id="totalPages" value="${totalPages}" />