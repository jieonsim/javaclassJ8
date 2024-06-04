<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
pageContext.setAttribute("newLine", "\n");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<script src="${ctp}/js/common/basicAlert.js"></script>
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
						<c:if test="${not empty guestBook.companions && guestBook.companions != '기타'}">&nbsp;·&nbsp;&nbsp;${guestBook.companions}</c:if>
					</div>
				</div>
				<div class="col-sm-6" id="guestBookSetUp">
					<div class="d-flex justify-content-end mt-2">
						<c:if test="${guestBook.visibility == 'private'}">
							<i class="ph ph-lock mr-2"></i>
						</c:if>
						<a href="#" data-toggle="modal" data-target="#updateGuestBook" class="text-dark" style="text-decoration: none;" data-guestbook-id="${guestBook.guestBookIdx}" data-visibility="${guestBook.visibility}">
							<i class="ph ph-dots-three"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
</c:forEach>
<input type="hidden" id="message" value="${message}" />
<input type="hidden" id="url" value="${url}" />
<input type="hidden" id="totalPages" value="${totalPages}" />