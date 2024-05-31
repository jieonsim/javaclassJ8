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
		'바'🍸
		'카페'☕
		'음식점'🍴
		'디저트 / 베이커리'🍰
		'포토존'🤳🏻
		'광장'👥
		'관광지'🗽
		'종교시설'⛪
		'역사 유적지'🕌
		'자연'🍃
		'복합문화공간'🎨
		'박물관'🏛️
		'음악'🎵
		'전시'🖼️
		'공연'🎫
		'도서관'📖
		'샵'🛍️
		'서점'📚
		'시장'🛒
		'쇼핑몰'🏬
		'호텔'🏨
		'스테이'🛏️
		'미용 / 스파'💇🏻‍♀️
		'오락'🎮
		'운동'🏃🏻
		'스튜디오 / 클래스'👩🏻‍💻
		'골프장'⛳
		'캠핑장'🏕️
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
		<div class="container p-5">
			<h2>Card Image</h2>
			<p>Image at the top (card-img-top):</p>
			<div class="card" style="width: 400px">
				<img class="card-img-top" src="${ctp}/images/dummy/newjeans1.jpg" alt="Card image" style="width: 100%">
				<div class="card-body">
					<h4 class="card-title">John Doe</h4>
					<p class="card-text">Some example text some example text. John Doe is an architect and engineer</p>
					<a href="#" class="btn btn-primary">See Profile</a>
				</div>
			</div>
		</div>
		<br>
		<h2>Card Image Overlay</h2>
		<p>Turn an image into a card background and use .card-img-overlay to overlay the card's text:</p>
		<div class="card img-fluid" style="width: 500px">
			<img class="card-img-top" src="${ctp}/images/dummy/newjeans2.jpg" alt="Card image" style="width: 100%">
			<div class="card-img-overlay">
				<h4 class="card-title">John Doe</h4>
				<p class="card-text">Some example text some example text. Some example text some example text. Some example text some example text. Some example text some example text.</p>
				<a href="#" class="btn btn-primary">See Profile</a>
			</div>
		</div>
	</div>
	<div class="pt-5">footer</div>
</body>
</html>