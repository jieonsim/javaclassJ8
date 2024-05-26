<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Lens</title>
<jsp:include page="/WEB-INF/include/bs4.jsp" />
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5">
		<h2>메인화면</h2>
		<div class="row">
			<c:choose>
				<c:when test="${not empty userVO}">
					<div class="col">
						<h5>로그인한 유저의 VO 정보</h5>
						<div>userVO.userIdx : ${userVO.userIdx}</div>
						<div>userVO.id : ${userVO.id}</div>
						<div>userVO.nickname : ${userVO.nickname}</div>
						<div>userVO.name : ${userVO.name}</div>
						<div>userVO.email : ${userVO.email}</div>
						<div>userVO.role : ${userVO.role}</div>
						<div>userVO.introduction : ${userVO.introduction}</div>
						<div>userVO.createdAt : ${userVO.createdAt}</div>
						<%-- <div>userVO.updatedAt : ${userVO.updatedAt != null ? userVO.updatedAt : 'N/A'}</div> --%>
						<div>userVO.updatedAt : ${userVO.updatedAt}</div>
						<div>userVO.profileImage : ${userVO.profileImage}</div>
						<div>userVO.visibility : ${userVO.visibility}</div>
					</div>
					<div class="col">
						<h5>로그인한 유저의 세션 정보</h5>
						<div>sessionUserIdx : ${sessionUserIdx}</div>
						<div>sessionId : ${sessionId}</div>
						<div>sessionNickname : ${sessionNickname}</div>
						<div>sessionName : ${sessionName}</div>
						<div>sessionEmail : ${sessionEmail}</div>
						<div>sessionRole : ${sessionRole}</div>
						<div>sessionIntroduction : ${sessionIntroduction}</div>
						<div>sessionProfileImage : ${sessionProfileImage}</div>
					</div>
				</c:when>
				<c:otherwise>
					<h2>미로그인 상태</h2>
				</c:otherwise>
			</c:choose>
			<div class="col">
				<div style="font-size: 45px;">to-do-list</div>
				<ul>
					<li>카카오맵 api 가져오기</li>
					<li>방명록 crud</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>