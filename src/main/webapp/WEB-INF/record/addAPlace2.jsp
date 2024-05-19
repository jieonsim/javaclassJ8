<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/addAPlace.css" />
<div class="modal fade" id="addAPlace">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-body">
				<div><b>공간 추가</b></div>
				<form name="searchPlace" method="post" action="">
					<div>
						<input class="search-input" type="search" placeholder="공간명 검색"
							aria-label="Search">
						<button class="search-btn" type="submit">
							<i class="ph ph-magnifying-glass"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>