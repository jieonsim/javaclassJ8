<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<script src="${ctp}/js/common/basicAlert.js"></script>
<div class="container-fluid px-0" id="list-wrap">
	<div class="row no-gutters">
		<c:forEach var="bookmark" items="${bookmarks}">
			<div class="col-md-4">
				<div class="card img-fluid" id="bookmark-localLog-card">
					<div class="image-container">
						<img class="card-img-top" src="${ctp}/images/localLog/${bookmark.coverImage}" alt="Card image" id="bookmark-localLog-card-img">
						<div class="card-img-overlay h-100 d-flex flex-column justify-content-end">
							<p class="card-text">
								<c:choose>
									<c:when test="${bookmark.categoryName == '바'}">🍸&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '카페'}">☕&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '음식점'}">🍴&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '디저트 / 베이커리'}">🍰&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '포토존'}">🤳🏻&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '광장'}">👥&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '관광지'}">🗽&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '종교시설'}">⛪&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '역사 유적지'}">🕌&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '자연'}">🍃&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '복합문화공간'}">🎨&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '박물관'}">🏛️&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '음악'}">🎵&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '전시'}">🖼️&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '공연'}">🎫&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '도서관'}">📖&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '샵'}">🛍️&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '서점'}">📚&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '시장'}">🛒&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '쇼핑몰'}">🏬&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '호텔'}">🏨&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '스테이'}">🛏️&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '미용 / 스파'}">💇🏻‍♀️&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '오락'}">🎮&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '운동'}">🏃🏻&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '스튜디오 / 클래스'}">👩🏻‍💻&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '골프장'}">⛳&nbsp;</c:when>
									<c:when test="${bookmark.categoryName == '캠핑장'}">🏕️&nbsp;</c:when>
								</c:choose>
								<span>&nbsp;${bookmark.region1DepthName},&nbsp;${bookmark.region2DepthName}</span>
							</p>
						</div>
						<div class="gradient-overlay"></div>
						<a href="localLogDetail.ld?localLogIdx=${bookmark.localLogIdx}" class="stretched-link"></a>
					</div>
					<div class="card-body">
						<b>${bookmark.placeName}</b>
					</div>
				</div>
			</div>
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
		</c:forEach>
	</div>
</div>
<input type="hidden" id="message" value="${message}" />
<input type="hidden" id="url" value="${url}" />
<input type="hidden" id="totalPages" value="${totalPages}" />