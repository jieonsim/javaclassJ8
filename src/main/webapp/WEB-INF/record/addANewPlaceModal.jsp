<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${ctp}/css/record/addANewPlaceModal.css" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/common/basicAlert.css" />
<div class="modal fade" id="addANewPlaceModal" tabindex="-1" role="dialog" aria-labelledby="addANewPlaceModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addANewPlaceModalLabel">새로운 공간 추가하기</h5>
			</div>
			<div class="modal-body">
				<form name="addAPlaceForm" class="addAPlace-form" method="post" action="${ctp}/addANewPlace.g" onsubmit="return validateForm()">
					<!-- 장소 최초 등록한 userIdx hidden 처리 -->
					<input type="hidden" name="createdBy" value="${sessionScope.sessionUserIdx}" />
					<div class="form-group mr-5 pb-4">
						<label for="placeName" class="col-sm-4 col-form-label text-left">
							<b>이름 <span style="color: lightcoral;">*</span></b>
						</label>
						<input type="text" class="form-control ml-3" name="placeName" id="inputPlaceName" placeholder="공간의 이름을 입력해 주세요.">
					</div>
					<div class="form-group pb-4">
						<label for="address" class="col-sm-4 col-form-label text-left">
							<b>주소 <span style="color: lightcoral;">*</span></b>
						</label>
						<div class="row mx-2">
							<div class="col-sm-6">
								<select class="form-control" id="region_1depth_name" name="region1DepthName">
									<option value="" selected disabled>특별시·광역시·도</option>
									<option value="서울특별시">서울특별시</option>
									<option value="부산광역시">부산광역시</option>
									<option value="대구광역시">대구광역시</option>
									<option value="인천광역시">인천광역시</option>
									<option value="대전광역시">대전광역시</option>
									<option value="광주광역시">광주광역시</option>
									<option value="울산광역시">울산광역시</option>
									<option value="세종특별자치시">세종특별자치시</option>
									<option value="경기도">경기도</option>
									<option value="충청북도">충청북도</option>
									<option value="충청남도">충청남도</option>
									<option value="전라남도">전라남도</option>
									<option value="경상북도">경상북도</option>
									<option value="경상남도">경상남도</option>
									<option value="강원특별자치도">강원특별자치도</option>
									<option value="전북특별자치도">전북특별자치도</option>
									<option value="제주특별자치도">제주특별자치도</option>
								</select>
							</div>
							<div class="col-sm-6">
								<select class="form-control" id="region_2depth_name" name="region2DepthName">
									<option value="" selected disabled>시·군·구·읍·면·동</option>
									<!-- 서울특별시 -->
									<option data-parent="서울특별시">강남구</option>
									<option data-parent="서울특별시">강동구</option>
									<option data-parent="서울특별시">강북구</option>
									<option data-parent="서울특별시">강서구</option>
									<option data-parent="서울특별시">관악구</option>
									<option data-parent="서울특별시">광진구</option>
									<option data-parent="서울특별시">구로구</option>
									<option data-parent="서울특별시">금천구</option>
									<option data-parent="서울특별시">노원구</option>
									<option data-parent="서울특별시">도봉구</option>
									<option data-parent="서울특별시">동대문구</option>
									<option data-parent="서울특별시">동작구</option>
									<option data-parent="서울특별시">마포구</option>
									<option data-parent="서울특별시">서대문구</option>
									<option data-parent="서울특별시">서초구</option>
									<option data-parent="서울특별시">성동구</option>
									<option data-parent="서울특별시">성북구</option>
									<option data-parent="서울특별시">송파구</option>
									<option data-parent="서울특별시">양천구</option>
									<option data-parent="서울특별시">영등포구</option>
									<option data-parent="서울특별시">용산구</option>
									<option data-parent="서울특별시">은평구</option>
									<option data-parent="서울특별시">종로구</option>
									<option data-parent="서울특별시">종구</option>
									<option data-parent="서울특별시">중랑구</option>
									<!-- 부산광역시 -->
									<option data-parent="부산광역시">중구</option>
									<option data-parent="부산광역시">서구</option>
									<option data-parent="부산광역시">동구</option>
									<option data-parent="부산광역시">영도구</option>
									<option data-parent="부산광역시">부산진구</option>
									<option data-parent="부산광역시">동래구</option>
									<option data-parent="부산광역시">남구</option>
									<option data-parent="부산광역시">북구</option>
									<option data-parent="부산광역시">해운대구</option>
									<option data-parent="부산광역시">사하구</option>
									<option data-parent="부산광역시">금정구</option>
									<option data-parent="부산광역시">강서구</option>
									<option data-parent="부산광역시">연제구</option>
									<option data-parent="부산광역시">수영구</option>
									<option data-parent="부산광역시">사상구</option>
									<option data-parent="부산광역시">기장군</option>
									<!-- 대구광역시 -->
									<option data-parent="대구광역시">중구</option>
									<option data-parent="대구광역시">동구</option>
									<option data-parent="대구광역시">서구</option>
									<option data-parent="대구광역시">남구</option>
									<option data-parent="대구광역시">북구</option>
									<option data-parent="대구광역시">수성구</option>
									<option data-parent="대구광역시">달서구</option>
									<option data-parent="대구광역시">달성군</option>
									<option data-parent="대구광역시">군위군</option>
									<!-- 인천광역시 -->
									<option data-parent="인천광역시">중구</option>
									<option data-parent="인천광역시">동구</option>
									<option data-parent="인천광역시">서구</option>
									<option data-parent="인천광역시">미추홀구</option>
									<option data-parent="인천광역시">연수구</option>
									<option data-parent="인천광역시">남동구</option>
									<option data-parent="인천광역시">부평구</option>
									<option data-parent="인천광역시">계양구</option>
									<option data-parent="인천광역시">서구</option>
									<option data-parent="인천광역시">강화군</option>
									<option data-parent="인천광역시">웅진군</option>
									<!-- 대전광역시 -->
									<option data-parent="대전광역시">동구</option>
									<option data-parent="대전광역시">중구</option>
									<option data-parent="대전광역시">서구</option>
									<option data-parent="대전광역시">유성구</option>
									<option data-parent="대전광역시">대덕구</option>
									<!-- 광주광역시 -->
									<option data-parent="광주광역시">동구</option>
									<option data-parent="광주광역시">서구</option>
									<option data-parent="광주광역시">남구</option>
									<option data-parent="광주광역시">북구</option>
									<option data-parent="광주광역시">광산구</option>
									<!-- 울산광역시 -->
									<option data-parent="울산광역시">동구</option>
									<option data-parent="울산광역시">서구</option>
									<option data-parent="울산광역시">남구</option>
									<option data-parent="울산광역시">북구</option>
									<!-- 세종특별자치시 -->
									<option data-parent="세종특별자치시">조치원읍</option>
									<option data-parent="세종특별자치시">고운동</option>
									<option data-parent="세종특별자치시">다정동</option>
									<option data-parent="세종특별자치시">반곡동</option>
									<option data-parent="세종특별자치시">종촌동</option>
									<option data-parent="세종특별자치시">새롬동</option>
									<option data-parent="세종특별자치시">도담동</option>
									<option data-parent="세종특별자치시">아름동</option>
									<option data-parent="세종특별자치시">소담동</option>
									<option data-parent="세종특별자치시">보람동</option>
									<option data-parent="세종특별자치시">한솔동</option>
									<option data-parent="세종특별자치시">나성동</option>
									<!-- 경기도 -->
									<option data-parent="경기도">수원시</option>
									<option data-parent="경기도">성남시</option>
									<option data-parent="경기도">의정부시</option>
									<option data-parent="경기도">안양시</option>
									<option data-parent="경기도">부천시</option>
									<option data-parent="경기도">광명시</option>
									<option data-parent="경기도">평택시</option>
									<option data-parent="경기도">동두천시</option>
									<option data-parent="경기도">안산시</option>
									<option data-parent="경기도">고양시</option>
									<option data-parent="경기도">과천시</option>
									<option data-parent="경기도">구리시</option>
									<option data-parent="경기도">남양주시</option>
									<option data-parent="경기도">오산시</option>
									<option data-parent="경기도">시흥시</option>
									<option data-parent="경기도">군포시</option>
									<option data-parent="경기도">의왕시</option>
									<option data-parent="경기도">하남시</option>
									<option data-parent="경기도">용인시</option>
									<option data-parent="경기도">파주시</option>
									<option data-parent="경기도">이천시</option>
									<option data-parent="경기도">안성시</option>
									<option data-parent="경기도">김포시</option>
									<option data-parent="경기도">화성시</option>
									<option data-parent="경기도">광주시</option>
									<option data-parent="경기도">양주시</option>
									<option data-parent="경기도">포천시</option>
									<option data-parent="경기도">여주시</option>
									<option data-parent="경기도">연천군</option>
									<option data-parent="경기도">가평군</option>
									<option data-parent="경기도">양평군</option>
									<!-- 충청북도 -->
									<option data-parent="충청북도">청주시</option>
									<option data-parent="충청북도">충주시</option>
									<option data-parent="충청북도">제천시</option>
									<option data-parent="충청북도">보은군</option>
									<option data-parent="충청북도">옥천군</option>
									<option data-parent="충청북도">영동군</option>
									<option data-parent="충청북도">증평군</option>
									<option data-parent="충청북도">진천군</option>
									<option data-parent="충청북도">괴산군</option>
									<option data-parent="충청북도">음성군</option>
									<option data-parent="충청북도">단양군</option>
									<!-- 충청남도 -->
									<option data-parent="충청남도">천안시</option>
									<option data-parent="충청남도">공주시</option>
									<option data-parent="충청남도">보령시</option>
									<option data-parent="충청남도">아산시</option>
									<option data-parent="충청남도">서산시</option>
									<option data-parent="충청남도">논산시</option>
									<option data-parent="충청남도">계룡시</option>
									<option data-parent="충청남도">당진시</option>
									<option data-parent="충청남도">금산군</option>
									<option data-parent="충청남도">부여군</option>
									<option data-parent="충청남도">서천군</option>
									<option data-parent="충청남도">청양군</option>
									<option data-parent="충청남도">홍성군</option>
									<option data-parent="충청남도">예산군</option>
									<option data-parent="충청남도">태안군</option>
									<!-- 전라남도 -->
									<option data-parent="전라남도">목포시</option>
									<option data-parent="전라남도">여수시</option>
									<option data-parent="전라남도">순천시</option>
									<option data-parent="전라남도">나주시</option>
									<option data-parent="전라남도">광양시</option>
									<option data-parent="전라남도">담양군</option>
									<option data-parent="전라남도">곡성군</option>
									<option data-parent="전라남도">구례군</option>
									<option data-parent="전라남도">고흥군</option>
									<option data-parent="전라남도">보성군</option>
									<option data-parent="전라남도">화순군</option>
									<option data-parent="전라남도">장흥군</option>
									<option data-parent="전라남도">강진군</option>
									<option data-parent="전라남도">해남군</option>
									<option data-parent="전라남도">영암군</option>
									<option data-parent="전라남도">무안군</option>
									<option data-parent="전라남도">함평군</option>
									<option data-parent="전라남도">영광군</option>
									<option data-parent="전라남도">장성군</option>
									<option data-parent="전라남도">완도군</option>
									<option data-parent="전라남도">진도군</option>
									<option data-parent="전라남도">신안군</option>
									<!-- 경상북도 -->
									<option data-parent="경상북도">포항시</option>
									<option data-parent="경상북도">경주시</option>
									<option data-parent="경상북도">김천시</option>
									<option data-parent="경상북도">안동시</option>
									<option data-parent="경상북도">구미시</option>
									<option data-parent="경상북도">영주시</option>
									<option data-parent="경상북도">영천시</option>
									<option data-parent="경상북도">상주시</option>
									<option data-parent="경상북도">문경시</option>
									<option data-parent="경상북도">경산시</option>
									<option data-parent="경상북도">의성군</option>
									<option data-parent="경상북도">청송군</option>
									<option data-parent="경상북도">영양군</option>
									<option data-parent="경상북도">영덕군</option>
									<option data-parent="경상북도">청도군</option>
									<option data-parent="경상북도">고령군</option>
									<option data-parent="경상북도">성주군</option>
									<option data-parent="경상북도">칠곡군</option>
									<option data-parent="경상북도">예천군</option>
									<option data-parent="경상북도">봉화군</option>
									<option data-parent="경상북도">울진군</option>
									<option data-parent="경상북도">울릉군</option>
									<!-- 경상남도 -->
									<option data-parent="경상남도">창원시</option>
									<option data-parent="경상남도">진주시</option>
									<option data-parent="경상남도">통영시</option>
									<option data-parent="경상남도">사천시</option>
									<option data-parent="경상남도">김해시</option>
									<option data-parent="경상남도">밀양시</option>
									<option data-parent="경상남도">거제시</option>
									<option data-parent="경상남도">양산시</option>
									<option data-parent="경상남도">의령군</option>
									<option data-parent="경상남도">함안군</option>
									<option data-parent="경상남도">창녕군</option>
									<option data-parent="경상남도">고성군</option>
									<option data-parent="경상남도">남해군</option>
									<option data-parent="경상남도">하동군</option>
									<option data-parent="경상남도">산청군</option>
									<option data-parent="경상남도">함양군</option>
									<option data-parent="경상남도">거창군</option>
									<option data-parent="경상남도">합천군</option>
									<!-- 강원특별자치도 -->
									<option data-parent="강원특별자치도">춘천시</option>
									<option data-parent="강원특별자치도">원주시</option>
									<option data-parent="강원특별자치도">강릉시</option>
									<option data-parent="강원특별자치도">동해시</option>
									<option data-parent="강원특별자치도">태백시</option>
									<option data-parent="강원특별자치도">속초시</option>
									<option data-parent="강원특별자치도">삼척시</option>
									<option data-parent="강원특별자치도">홍천군</option>
									<option data-parent="강원특별자치도">횡성군</option>
									<option data-parent="강원특별자치도">영월군</option>
									<option data-parent="강원특별자치도">평창군</option>
									<option data-parent="강원특별자치도">정선군</option>
									<option data-parent="강원특별자치도">철원군</option>
									<option data-parent="강원특별자치도">화천군</option>
									<option data-parent="강원특별자치도">양구군</option>
									<option data-parent="강원특별자치도">인제군</option>
									<option data-parent="강원특별자치도">고성군</option>
									<option data-parent="강원특별자치도">양양군</option>
									<!-- 전북특별자치도 -->
									<option data-parent="전북특별자치도">전주시</option>
									<option data-parent="전북특별자치도">군산시</option>
									<option data-parent="전북특별자치도">익산시</option>
									<option data-parent="전북특별자치도">정읍시</option>
									<option data-parent="전북특별자치도">남원시</option>
									<option data-parent="전북특별자치도">김제시</option>
									<option data-parent="전북특별자치도">완주군</option>
									<option data-parent="전북특별자치도">진안군</option>
									<option data-parent="전북특별자치도">무주군</option>
									<option data-parent="전북특별자치도">장수군</option>
									<option data-parent="전북특별자치도">임실군</option>
									<option data-parent="전북특별자치도">순창군</option>
									<option data-parent="전북특별자치도">고창군</option>
									<option data-parent="전북특별자치도">부안군</option>
									<!-- 제주특별자치도 -->
									<option data-parent="제주특별자치도">제주시</option>
									<option data-parent="제주특별자치도">서귀포시</option>
									<option data-parent="제주특별자치도">애월읍</option>
									<option data-parent="제주특별자치도">조천읍</option>
									<option data-parent="제주특별자치도">구좌읍</option>
									<option data-parent="제주특별자치도">성산읍</option>
									<option data-parent="제주특별자치도">표선면</option>
									<option data-parent="제주특별자치도">남원읍</option>
									<option data-parent="제주특별자치도">안덕면</option>
									<option data-parent="제주특별자치도">대정읍</option>
									<option data-parent="제주특별자치도">한경면</option>
									<option data-parent="제주특별자치도">한림읍</option>
									<option data-parent="제주특별자치도">추자면</option>
									<option data-parent="제주특별자치도">우도면</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="category" class="col-sm-4 col-form-label text-left mb-3">
							<b>공간 유형 <span style="color: lightcoral;">*</span></b>
						</label>
						<div class="mx-3 mb-4" style="font-size: 14px;">공간을 가장 잘 나타내는 유형 하나를 선택해주세요.</div>
						<div class="category-section mx-3" id="categorySection">
							<c:forEach var="categoryType" items="${categoriesByType.keySet()}">
								<b>${categoryType}</b>
								<div class="category-options mb-2">
									<c:forEach var="category" items="${categoriesByType[categoryType]}">
										<label>
											<input type="radio" name="categoryIdx" value="${category.categoryIdx}">
											<span class="option-btn">${category.categoryName}</span>
										</label>
									</c:forEach>
								</div>
							</c:forEach>
						</div>
					</div>
					<button type="submit" class="form-control mb-3" id="complete">완료</button>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	document.getElementById('region_1depth_name').addEventListener('change', function() {
		var selectedRegion = this.value;
		var subRegionSelect = document.getElementById('region_2depth_name');
		var subRegions = subRegionSelect.querySelectorAll('option');

		subRegions.forEach(function(option) {
			if (option.getAttribute('data-parent') === selectedRegion) {
				option.style.display = 'block';
			} else {
				option.style.display = 'none';
			}
		});

		// 첫 번째 일치하는 옵션으로 값을 설정
		var firstMatchingOption = subRegionSelect.querySelector('option[data-parent="' + selectedRegion + '"]');
		if (firstMatchingOption) {
			subRegionSelect.value = firstMatchingOption.value;
		} else {
			subRegionSelect.value = '';
		}

		// subRegionSelect를 활성화
		subRegionSelect.disabled = false;
	});

	// 초기 상태에서 region_2depth_name을 비활성화
	document.getElementById('region_2depth_name').disabled = true;

	function validateForm() {
		const createdBy = document.forms["addAPlaceForm"].createdBy.value.trim();
		const placeName = document.forms["addAPlaceForm"].placeName.value.trim();
		const region1DepthName = document.forms["addAPlaceForm"].region1DepthName.value.trim();
		const region2DepthName = document.forms["addAPlaceForm"].region2DepthName.value.trim();
		const categoryIdx = document.forms["addAPlaceForm"].categoryIdx.value;

		if (createdBy === "") {
			showAlert("유효하지 않은 아이디입니다. 다시 로그인 후 이용해주세요.");
			document.forms["addAPlaceForm"].placeName.focus();
			return false;
		}

		if (placeName === "") {
			showAlert("공간의 이름을 입력해주세요.");
			document.forms["addAPlaceForm"].placeName.focus();
			return false;
		}

		if (region1DepthName === "") {
			showAlert("주소를 선택해 주세요.");
			document.forms["addAPlaceForm"].region1DepthName.focus();
			return false;
		}

		if (region2DepthName === "") {
			showAlert("상세 주소를 선택해 주세요.");
			document.forms["addAPlaceForm"].region2DepthName.focus();
			return false;
		}

		if (!categoryIdx) {
			showAlert("공간의 유형을 선택해 주세요.");
			return false;
		}

		return true; // 폼 제출을 허용
	}

	function showAlert(message) {
		Swal.fire({
			html : message,
			confirmButtonText : '확인',
			customClass : {
				confirmButton : 'swal2-confirm',
				popup : 'custom-swal-popup',
				htmlContainer : 'custom-swal-text'
			}
		});
	}
</script>