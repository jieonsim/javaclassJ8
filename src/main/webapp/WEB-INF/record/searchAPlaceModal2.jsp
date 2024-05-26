<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/searchAPlaceMoal.css" />
<jsp:include page="/WEB-INF/record/addANewPlaceModal.jsp" />
<div class="modal fade" id="searchAPlaceModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<div class="searchAPlace_title mb-4">
							<a href="record-guestBook.g">
								<i class="ph ph-caret-left"></i>
							</a>
							<span>공간 추가하기</span>
						</div>
					</div>
					<div class="col text-right">
						<!-- <a href="#" id="goToNewModal" onclick="switchModals()" data-toggle="modal" data-target="#addANewPlaceModal"> 찾는 공간이 없으신가요? </a> -->
						<a href="#" id="goToNewModal" onclick="switchModals()"> 찾는 공간이 없으신가요? </a>
					</div>
				</div>
				<form name="searchAPlaceForm" class="searchAPlace-form" method="post" action="">
					<div>
						<input class="searchInput" type="search" placeholder="공간명 검색" aria-label="Search" id="searching">
						<button class="searchBtn" type="button" onclick="searchPlaces()">
							<i class="ph ph-magnifying-glass"></i>
						</button>
					</div>
				</form>
				<div id="placesList"></div>
			</div>
		</div>
	</div>
</div>