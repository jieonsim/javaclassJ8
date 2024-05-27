<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/searchAPlaceModal.css" />
<div class="modal fade" id="searchAPlaceModal" tabindex="-1" role="dialog" aria-labelledby="searchAPlaceModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="searchAPlaceModalLabel">공간 추가하기</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form name="searchAPlaceForm" class="searchAPlace-form" method="post" action="">
					<div class="my-3 mx-3">
						<input type="search" placeholder="공간명 검색" aria-label="Search" id="searching">
						<!-- <button id="searchBtn" type="button" onclick="searchPlaces()">
							<i class="ph ph-magnifying-glass"></i>
						</button> -->
					</div>
				<div id="placesList"></div>
				</form>
				<div class="text-center my-5">
					<div>검색 결과가 없습니다.</div>
					<a href="#" id="goToNewModal" onclick="switchModals()">이 곳을 클릭해 새로운 공간을 추가해보세요.</a>
				</div>
			</div>
		</div>
	</div>
</div>