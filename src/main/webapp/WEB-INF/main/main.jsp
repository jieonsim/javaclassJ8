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
						<div>IDX : ${userVO.userIdx}</div>
						<div>아이디 : ${userVO.id}</div>
						<div>닉네임 : ${userVO.nickname}</div>
						<div>이름 : ${userVO.name}</div>
						<div>이메일 : ${userVO.email}</div>
						<div>등급 : ${userVO.role}</div>
					</div>
					<div class="col">
						<h5>로그인한 유저의 세션 정보</h5>
						<div>세션 IDX : ${sessionUserIdx}</div>
						<div>세션 아이디 : ${sessionId}</div>
						<div>세션 닉네임 : ${sessionNickname}</div>
						<div>세션 이름 : ${sessionName}</div>
						<div>세션 등급 : ${sessionRole}</div>
					</div>
				</c:when>
				<c:otherwise>
					<h2>미로그인 상태</h2>
				</c:otherwise>
			</c:choose>
			<div class="col">
				<div>to-do-list</div>
				<ul>
					<li>회원 정보 수정 페이지 가장 상단에 기본 프로필 아이콘 넣고 사진 파일 추가 버튼 넣기</li>
					<li>비밀번호 재설정 시 기존 비밀번호랑 동일하게 변경 불가</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>