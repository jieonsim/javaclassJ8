<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/include/header.css" />
<header class="container-fluid mt-5">
	<div class="container">
		<div class="row align-items-center justify-content-between">
			<div class="col-auto">
				<a href="#" class="header-link" id="localLens">Local Lens</a>
			</div>	
            <div class="col-auto position-relative">
                <input class="search-input" type="search" placeholder="find a lil spot? use me!" aria-label="Search">
                <button class="search-btn" type="submit"><i class="ph ph-magnifying-glass"></i></button>
            </div>
			
			<div class="col-auto d-flex align-items-center">
			    <a href="signup.s" class="header-link">
			    	<i class="ph ph-user"></i>
			    	<span class="ml-2 mr-4">sign up</span>
			    </a>
			    <a href="login.l" class="header-link">
			    	<i class="ph ph-sign-in"></i>
			    	<span class="ml-2">login</span>
			    </a>
			</div>
			<div class="col-auto d-flex align-items-center">
			<div class="dropdown">
			<button type="button" class="btn btn-custom btn-lg dropdown-toggle" data-toggle="dropdown" id="user">
					<i class="ph ph-user"></i>
			    	<span class="ml-2">locallens</span>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
			    <a class="dropdown-item" href="confirmPassword.u">내 정보 수정</a>
			    <a class="dropdown-item" href="#">로그아웃</a>
  			</div>
			</div>
		</div>
		</div>
	</div>
</header>