<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<%
    // 아이디 저장을 위한 쿠키 처리
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("cookieId")) {
                pageContext.setAttribute("id", cookie.getValue());
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Lens</title>
<jsp:include page="/WEB-INF/include/bs4.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/user/login/login.css" />
</head>
<body>
    <jsp:include page="/WEB-INF/include/header.jsp" />
    <jsp:include page="/WEB-INF/include/nav.jsp" />
    <div class="container mt-5 pt-3">
        <div class="login-container">
            <h4 class="mb-5">로그인</h4>
            <c:if test="${not empty message}">
                <div class="alert alert-success" role="alert">${message}</div>
                <script>
                    alert("${message}");
                    <c:if test="${not empty url}">
                        window.location.href = "${ctp}/${url}";
                    </c:if>
                </script>
            </c:if>
            <form name="loginForm" class="login-form" method="post" action="${ctp}/welcome.l">
                <div class="form-group row">
                    <div class="col">
                        <input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력해주세요." value="${id}" autofocus required />
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col">
                        <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력해주세요." required />
                    </div>
                    <div class="col-sm-10 offset-sm-2 text-right mt-2 mb-2">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="true" name="rememberId" checked>
                            <label class="form-check-label" for="rememberId" id="rememberId">아이디 저장</label>
                        </div>
                    </div>
                </div>
                <div class="form-group text-center">
                    <div>
                        <button type="submit" class="btn btn-custom btn-lg form-control mb-3" id="logIn">로그인</button>
                    </div>
                    <div>
                        <button onclick="location.href='signup.s'" type="button" class="btn btn-custom btn-lg form-control mb-2" id="signup">회원가입</button>
                    </div>
                    <div class="col">
                        <a href="findingId.fi" class="link-small">아이디 찾기</a>
                        <span id="divisionLine">I</span>
                        <a href="findingPassword.fi" class="link-small">비밀번호 찾기</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
