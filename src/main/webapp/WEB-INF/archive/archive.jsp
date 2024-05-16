<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Lens</title>
<jsp:include page="/WEB-INF/include/bs4.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/archive/archive.css" />
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&display=swap" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/include/header.jsp" />
<jsp:include page="/WEB-INF/include/nav.jsp" />
	<div class="container">
		<div class="archive-container">
			<div class="row mb-5">
				<div class="col-2">
					<i class="ph ph-user-focus" id="profileNoimage"></i>
				</div>
				<div class="col-10">
					<div id="nickname">locallens</div>
					<div style="color: gray">탭하고 소개 글을 입력해 보세요.</div>
				</div>
			</div>
			<ul class="d-flex justify-content-between list-unstyled">
				<li>
					<a href="#" id="localLog">로컬로그</a>
				</li>
				<li>
					<a href="#" id="guestBook"  style="color: lightgray">방명록</a>
				</li>
				<li>
					<a href="#" id="curation"  style="color: lightgray">큐레이션</a>
				</li>
			</ul>
			<div class="text-center" style="margin-top: 100px;">
				<div class="mb-2">내가 방문한 공간을 기록해보세요.</div>
				<button class="btn btn-custom" id="recordFirstCuration">첫 로컬로그 남기기</button>
			</div>
			<div class="text-center" style="margin-top: 100px;">	
				<div class="mb-2">다녀온 공간에 대한 후기를 남겨보세요.</div>
				<button class="btn btn-custom" id="recordFirstCuration">첫 방명록 남기기</button>
			</div>
			<div class="text-center" style="margin-top: 100px;">	
				<div class="mb-2">추천하고 싶은 나만의 공간 가이드를 만들어보세요.</div>
				<button class="btn btn-custom" id="recordFirstCuration">첫 큐레이션 작성하기</button>
			</div>			
		</div>
	</div>
</body>
</html>