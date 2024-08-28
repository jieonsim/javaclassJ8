<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/include/footer.css" />
<footer class="footer">
	<div class="footer__addr">
		<h1 class="footer__logo">Local Lens</h1>

		<h2>Contact</h2>

		<address>
			109, Sajik-daero, Seowon-gu, Cheongju-si,<br>Chungcheongbuk-do, Republic of Korea<br>
		</address>
	</div>

	<ul class="footer__nav">
		<li class="nav__item">
			<h2 class="nav__title">Help</h2>

			<ul class="nav__ul">
				<li>
					<a href="#">Contact us</a>
				</li>

				<li>
					<a href="#">FAQ</a>
				</li>

				<li>
					<a href="#">Alternative Ads</a>
				</li>
			</ul>
		</li>

		<li class="nav__item nav__item--extra">
			<h2 class="nav__title">Legal Info</h2>

			<ul class="nav__ul nav__ul--extra">
				<li>
					<a href="#">Privacy Policy</a>
				</li>

				<li>
					<a href="#">Terms & Conditions</a>
				</li>

				<li>
					<a href="#">Digital Signage</a>
				</li>

				<li>
					<a href="#">Automation</a>
				</li>

				<li>
					<a href="#">Artificial Intelligence</a>
				</li>

				<li>
					<a href="#">IoT</a>
				</li>
			</ul>
		</li>

		<li class="nav__item">
			<h2 class="nav__title">Follow Us</h2>

			<ul class="nav__ul">
				<li>
					<a href="#">Instagram</a>
				</li>

				<li>
					<a href="#">Facebook</a>
				</li>

				<li>
					<a href="#">Threads</a>
				</li>
			</ul>
		</li>
	</ul>

	<div class="legal">
		<p>&copy; 2024 Local Lens. All rights reserved.</p>

		<div class="legal__links">
			<span> 로컬렌즈와 함께 특별한 장소를 발견해보세요. </span>
		</div>
	</div>
</footer>