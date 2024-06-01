<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<script src="${ctp}/js/common/basicAlert.js"></script>
<div class="container-flud px-0" id="list-wrap">
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
<%-- <div id="list-wrap">
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
</div> --%>
<input type="hidden" id="message" value="${message}" />
<input type="hidden" id="url" value="${url}" />
<input type="hidden" id="totalPages" value="${totalPages}" />