<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/addANewPlaceModal.css" />
<div class="modal fade" id="addANewPlaceModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-body">
				<div class="addAPlace_title mb-4">
					<a href="record-guestBook.g">
						<i class="ph ph-caret-left"></i>
					</a>
					<span>새로운 공간 추가하기</span>
				</div>
				<form name="addAPlaceForm" class="addAPlace-form" method="post" action="">
					<div class="form-group mr-5 pb-4">
						<label for="placeName" class="col-sm-4 col-form-label text-left" id="placeName">
							<b>이름 <span style="color: lightcoral;">*</span></b>
						</label>
						<input type="text" class="form-control ml-3" name="placeName" id="inputPlaceName" placeholder="공간의 이름을 입력해 주세요." required>
					</div>
					<div class="form-group">
						<label for="category" class="col-sm-4 col-form-label text-left mb-3" id="category">
							<b>공간 유형 <span style="color: lightcoral;">*</span></b>
						</label>
						<div class="mx-3 mb-4" style="font-size: 14px;">공간을 가장 잘 나타내는 유형을 먼저 선택해주세요.</div>
						<!-- Categories and options -->
						<div class="category-section mx-3">
							<b>식음료</b>
							<div class="category-options mb-2">
								<label>
									<input type="checkbox" name="category" value="바">
									<span class="option-btn">바</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="카페">
									<span class="option-btn">카페</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="음식점">
									<span class="option-btn">음식점</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="디저트 / 베이커리">
									<span class="option-btn">디저트 / 베이커리</span>
								</label>
							</div>

							<b>여행</b>
							<div class="category-options mb-2">
								<label>
									<input type="checkbox" name="category" value="포토존">
									<span class="option-btn">포토존</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="광장">
									<span class="option-btn">광장</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="관광지">
									<span class="option-btn">관광지</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="종교시설">
									<span class="option-btn">종교시설</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="역사 유적지">
									<span class="option-btn">역사 유적지</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="자연">
									<span class="option-btn">자연</span>
								</label>
							</div>

							<b>문화</b>
							<div class="category-options mb-2">
								<label>
									<input type="checkbox" name="category" value="복합문화공간">
									<span class="option-btn">복합문화공간</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="박물관">
									<span class="option-btn">박물관</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="음악">
									<span class="option-btn">음악</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="전시">
									<span class="option-btn">전시</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="공연">
									<span class="option-btn">공연</span>
								</label>
							</div>

							<b>쇼핑</b>
							<div class="category-options mb-2">
								<label>
									<input type="checkbox" name="category" value="샵">
									<span class="option-btn">샵</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="서점">
									<span class="option-btn">서점</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="시장">
									<span class="option-btn">시장</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="쇼핑몰">
									<span class="option-btn">쇼핑몰</span>
								</label>
							</div>

							<b>숙박</b>
							<div class="category-options mb-2">
								<label>
									<input type="checkbox" name="category" value="호텔">
									<span class="option-btn">호텔</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="스테이">
									<span class="option-btn">스테이</span>
								</label>
							</div>

							<b>작업</b>
							<div class="category-options mb-2">
								<label>
									<input type="checkbox" name="category" value="학교">
									<span class="option-btn">학교</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="코워킹 공간">
									<span class="option-btn">코워킹 공간</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="도서관">
									<span class="option-btn">도서관</span>
								</label>
							</div>

							<b>액티비티</b>
							<div class="category-options mb-2">
								<label>
									<input type="checkbox" name="category" value="미용 / 스파">
									<span class="option-btn">미용 / 스파</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="오락">
									<span class="option-btn">오락</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="운동">
									<span class="option-btn">운동</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="스튜디오 / 클래스">
									<span class="option-btn">스튜디오 / 클래스</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="골프장">
									<span class="option-btn">골프장</span>
								</label>
								<label>
									<input type="checkbox" name="category" value="캠핑장">
									<span class="option-btn">캠핑장</span>
								</label>
							</div>
						</div>
					</div>
					<button type="submit" class="form-control mb-3" id="complete">완료</button>
				</form>
			</div>
		</div>
	</div>
</div>