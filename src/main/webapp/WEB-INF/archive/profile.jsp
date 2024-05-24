<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<div class="row mb-5">
	<div class="col-2">
		<i class="ph ph-user-focus" id="profileNoimage"></i>
		<%-- <img src="${ctp}/images/pds/user/${mVo.photo}" width="200px"/> --%>
	</div>
	<div class="col-10">
		<div id="nickname">${sessionNickname}</div>
		<c:if test="${empty userVO.introduction}">
			<div>
				<a href="updateProfile-checkPassword.u" id="updateProfile">클릭하고 소개 글을 입력해 보세요.</a>
			</div>
		</c:if>
		<c:if test="${not empty userVO.introduction}">
			<div>
				<a href="updateProfile-checkPassword.u" id="updateProfile">${userVO.introduction}</a>
			</div>
		</c:if>
	</div>
	<input type="hidden" id="message" value="message" />
	<input type="hidden" id="url" value="url" />
</div>