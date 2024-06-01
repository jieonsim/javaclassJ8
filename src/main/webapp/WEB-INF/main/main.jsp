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
<style>
#localLogCardContainer {
	width: 300px;
}

#localLogCard {
	-webkit-box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
	-moz-box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
	-ms-box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
	-o-box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
	border-radius: 10px;
	width: 300px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp" />
	<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container mt-5" id="localLogCardContainer">
		<div class="card" id="localLogCard">
			<img class="card-img-top" src="${ctp}/images/dummy/1.jpg" alt="Card image" style="width: 100%;">
			<div class="card-body">
				<div class="card-title" style="font-size: 18px;">멀티피치</div>
				<div class="text-mute" style="font-size: 14px">충청북도, 청주시 카페</div>
				<div class="card-text">에그파이 냠냠</div>
				<a href="#" class="stretched-link"></a>
			</div>
		</div>
	</div>
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
					<li>새로운 공간 추가 백단 처리</li>
					<li>공간 검색 백단 처리</li>
					<li>방명록 crud</li>
					<li>방명록 좋아요</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="pt-5">footer</div>
</body>
</html>