<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<script src="${ctp}/js/common/basicAlert.js"></script>
<c:forEach var="localLog" items="${searchResults}">
	<div class="col-md-4 mb-4">
		<div class="search-item">
			<img src="${ctp}/images/localLog/${localLog.coverImage}" class="search-item-img img-fluid" alt="${localLog.placeName}">
			<div class="search-item-details">
				<h4>${localLog.placeName}</h4>
				<p>${localLog.region1DepthName},&nbsp;${localLog.region2DepthName}&nbsp;·&nbsp;${localLog.categoryName}</p>
			</div>
			<a href="localLogDetail.ld?localLogIdx=${localLog.localLogIdx}" class="stretched-link"></a>
		</div>
	</div>
</c:forEach>
<input type="hidden" id="message" value="${message}" />
<input type="hidden" id="url" value="${url}" />
<input type="hidden" id="totalPages" value="${totalPages}" />
<input type="hidden" id="query" name="query" value="${param.query}">