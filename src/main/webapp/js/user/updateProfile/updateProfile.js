document.addEventListener('DOMContentLoaded', function() {
	// 초기 프로필 이미지 설정
	const userProfilePhoto = document.getElementById('profile-photo');
	const profileImage = userProfilePhoto.getAttribute('src');
	const icon = document.getElementById('profile-icon');

	if (profileImage && profileImage.trim() !== "") {
		userProfilePhoto.classList.remove('d-none');
		if (icon) {
			icon.classList.add('d-none');
		}
	}

	// 파일 입력 변경 시 미리보기 설정
	const fileInput = document.getElementById('photo-upload');
	if (fileInput) {
		fileInput.addEventListener('change', previewPhoto);
	}
});

function previewPhoto(event) {
	const file = event.target.files[0];
	if (file) {
		const reader = new FileReader();
		reader.onload = function(e) {
			const userProfilePhoto = document.getElementById('profile-photo');
			const icon = document.getElementById('profile-icon');

			userProfilePhoto.src = e.target.result;
			userProfilePhoto.classList.remove('d-none');

			if (icon) {
				icon.classList.add('d-none');
			}
		};
		reader.readAsDataURL(file);
	}
}

document.addEventListener('DOMContentLoaded', function() {
	const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;
	const nicknameRegex = /^[a-z0-9._]{2,15}$/;
	const nameRegex = /^(?:[a-z]{2,50}|[가-힣]{2,50})$/;
	const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	const introductionRegex = /^.{0,50}$/;

	document.querySelector('input[name="newPassword"]').addEventListener('input', function() {
		validateInput(this, passwordRegex);
		validateNewPasswordConfirmation();
	});

	document.querySelector('input[name="nickname"]').addEventListener('input', function() {
		validateInput(this, nicknameRegex);
		if (this.value.trim() === "" || this.value === sessionNickname) {
			deactivateButton(document.getElementById('isNicknameDuplicatedBtn'));
		} else {
			activateButton(document.getElementById('isNicknameDuplicatedBtn'));
		}
	});

	document.querySelector('input[name="name"]').addEventListener('input', function() {
		validateInput(this, nameRegex);
	});

	document.querySelector('input[name="email"]').addEventListener('input', function() {
		validateInput(this, emailRegex);
		if (this.value.trim() === "" || this.value === sessionEmail) {
			deactivateButton(document.getElementById('isEmailDuplicatedBtn'));
		} else {
			activateButton(document.getElementById('isEmailDuplicatedBtn'));
		}
	});

	document.querySelector('input[name="newPasswordConfirmation"]').addEventListener('input', validateNewPasswordConfirmation);

	document.querySelector('input[name="introduction"]').addEventListener('input', function() {
		validateInput(this, introductionRegex);
	});
});


function validateInput(input, regex) {
	const span = input.nextElementSibling;
	if (!regex.test(input.value)) {
		span.style.display = 'inline';
	} else {
		span.style.display = 'none';
	}
}

function validateNewPasswordConfirmation() {
	const newPassword = document.querySelector('input[name="newPassword"]').value;
	const newPasswordConfirmation = document.querySelector('input[name="newPasswordConfirmation"]').value;
	const span = document.querySelector('input[name="newPasswordConfirmation"]').nextElementSibling;
	if (newPassword !== newPasswordConfirmation && newPasswordConfirmation !== "") {
		span.style.display = 'inline';
	} else {
		span.style.display = 'none';
	}
}

function activateButton(button) {
	button.classList.remove('disabled');
	button.style.backgroundColor = 'white';
	button.style.border = '1px solid black';
	button.style.color = 'black';
	button.style.pointerEvents = 'auto';
	button.disabled = false;
}

function deactivateButton(button) {
	button.classList.add('disabled');
	button.style.backgroundColor = '#eee';
	button.style.border = 'none';
	button.style.color = 'lightgray';
	button.style.pointerEvents = 'none';
	button.disabled = true;
}

let nicknameChecked = true; // 초기값을 true로 설정
let emailChecked = true; // 초기값을 true로 설정

document.addEventListener('DOMContentLoaded', function() {
	const sessionNickname = '${sessionNickname}';
	const sessionEmail = '${sessionEmail}';

	const nicknameInput = document.forms["updateProfileForm"].nickname;
	const emailInput = document.forms["updateProfileForm"].email;

	if (nicknameInput.value !== sessionNickname) {
		nicknameChecked = false;
	}
	if (emailInput.value !== sessionEmail) {
		emailChecked = false;
	}
});

function checkNicknameDuplicated() {
	const nickname = document.forms["updateProfileForm"].nickname.value.trim();
	const nicknameRegex = /^[a-z0-9._]{2,15}$/;

	if (nickname === "") {
		showAlert("닉네임을 입력하세요.");
		document.forms["updateProfileForm"].nickname.focus();
		return;
	}

	if (!nicknameRegex.test(nickname)) {
		showAlert("2자 이상 15자 이하의 영문, 숫자, 마침표, 언더바만 입력 가능");
		document.forms["updateProfileForm"].nickname.focus();
	} else {
		$.ajax({
			url: '${ctp}/checkNicknameDuplicated.u',
			type: 'POST',
			data: { nickname: nickname },
			success: function(response) {
				if (response === 'duplicated') {
					showAlert('이미 사용 중인 닉네임입니다.');
					document.forms["updateProfileForm"].nickname.focus();
					nicknameChecked = false;
				} else if (response === 'available') {
					showAlert('사용 가능한 닉네임입니다.');
					nicknameChecked = true;
					deactivateButton(document.getElementById('isNicknameDuplicatedBtn'));
				} else if (response === 'Invalid Nickname') {
					showAlert('잘못된 닉네임입니다.');
					document.forms["updateProfileForm"].nickname.focus();
				} else {
					console.error("Unexpected response:", response);
					showAlert("예상치 못한 응답: " + response);
				}
			},
			error: function() {
				showAlert("전송 오류");
			}
		});
	}
}

function checkEmailDuplicated() {
	const email = document.forms["updateProfileForm"].email.value.trim();
	const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

	if (email === "") {
		showAlert("이메일을 입력하세요.");
		document.forms["updateProfileForm"].email.focus();
		return;
	}

	if (!emailRegex.test(email)) {
		showAlert("이메일 형식에 맞춰 입력해주세요.");
		document.forms["updateProfileForm"].email.focus();
	} else {
		$.ajax({
			url: '${ctp}/checkEmailDuplicated.u',
			type: 'POST',
			data: { email: email },
			success: function(response) {
				if (response === 'duplicated') {
					showAlert('이미 사용 중인 이메일입니다.');
					document.forms["updateProfileForm"].email.focus();
					emailChecked = false;
				} else if (response === 'available') {
					showAlert('사용 가능한 이메일입니다.');
					emailChecked = true;
					deactivateButton(document.getElementById('isEmailDuplicatedBtn'));
				} else if (response === 'Invalid Email') {
					showAlert('잘못된 이메일입니다.');
					document.forms["updateProfileForm"].email.focus();
				} else {
					console.error("Unexpected response:", response);
					showAlert("예상치 못한 응답: " + response);
				}
			},
			error: function() {
				showAlert("전송 오류");
			}
		});
	}
}

function validateForm() {
	const profilePhoto = document.getElementById("photo-upload").value;
	const newPassword = document.forms["updateProfileForm"].newPassword.value.trim();
	const newPasswordConfirmation = document.forms["updateProfileForm"].newPasswordConfirmation.value.trim();
	const nickname = document.forms["updateProfileForm"].nickname.value.trim();
	const name = document.forms["updateProfileForm"].name.value.trim();
	const email = document.forms["updateProfileForm"].email.value.trim();
	const introduction = document.forms["updateProfileForm"].introduction.value.trim();

	const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;
	const nicknameRegex = /^[a-z0-9._]{2,30}$/;
	const nameRegex = /^(?:[a-z]{2,50}|[가-힣]{2,50})$/;
	const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

	if (profilePhoto.trim() != "") {
		const extension = profilePhoto.substring(profilePhoto.lastIndexOf(".") + 1).toLowerCase();
		const maxSize = 1024 * 1024 * 2;
		const fileSize = document.getElementById("photo-upload").files[0].size;

		if (extension != 'jpg' && extension != 'jpeg' && extension != 'gif' && extension != 'png') {
			showAlert("이미지 파일만 업로드 가능합니다.");
			return false;
		} else if (fileSize > maxSize) {
			showAlert("2MByte 이하의 파일만 업로드할 수 있습니다.");
			return false;
		}
	}

	if (newPassword !== "" && !passwordRegex.test(newPassword)) {
		showAlert("비밀번호는 10자 이상, 영문, 숫자, 특수문자 포함이어야 합니다.");
		document.forms["updateProfileForm"].newPassword.focus();
		return false;
	}

	if (newPassword !== newPasswordConfirmation) {
		showAlert("비밀번호가 일치하지 않습니다.");
		document.forms["updateProfileForm"].newPasswordConfirmation.focus();
		return false;
	}

	if (nickname !== "" && !nicknameRegex.test(nickname)) {
		showAlert("닉네임은 2자 이상 30자 이하의 영문, 숫자, 마침표, 언더바만 가능합니다.");
		document.forms["updateProfileForm"].nickname.focus();
		return false;
	}

	// 닉네임 중복 체크 버튼이 활성화 상태일 때만 중복 확인 필요
	if (nickname !== sessionNickname && !nicknameChecked) {
		showAlert("닉네임 중복 확인을 해주세요.");
		return false;
	}

	if (name !== "" && !nameRegex.test(name)) {
		showAlert("이름은 2자 이상 50자 이하의 한글 또는 영문만 입력 가능합니다.");
		document.forms["updateProfileForm"].name.focus();
		return false;
	}

	if (email !== "" && !emailRegex.test(email)) {
		showAlert("이메일 형식에 맞춰 입력해주세요.");
		document.forms["updateProfileForm"].email.focus();
		return false;
	}

	// 이메일 중복 체크 버튼이 활성화 상태일 때만 중복 확인 필요
	if (email !== sessionEmail && !emailChecked) {
		showAlert("이메일 중복 확인을 해주세요.");
		return false;
	}

	if (introduction.length > 50) {
		showAlert("소개글은 50자 이하로 입력해주세요.");
		document.forms["updateProfileForm"].introduction.focus();
		return false;
	}
	return true;
}
