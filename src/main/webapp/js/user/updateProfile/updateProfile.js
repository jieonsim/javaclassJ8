    document.addEventListener('DOMContentLoaded', function() {
        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;
        const nicknameRegex = /^[a-z0-9._]{2,15}$/;
        const nameRegex = /^(?:[a-z]{2,50}|[가-힣]{2,50})$/;
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        document.querySelector('input[name="currentPassword"]').addEventListener('input', function() {
            validateInput(this, passwordRegex);
            validatePasswordConfirmation();
        });
        
        document.querySelector('input[name="newPassword"]').addEventListener('input', function() {
            validateInput(this, passwordRegex);
            validatePasswordConfirmation();
        });

        document.querySelector('input[name="nickname"]').addEventListener('input', function() {
            validateInput(this, nicknameRegex);
            activateButton(document.getElementById('isNicknameDuplicatedBtn'));
        });

        document.querySelector('input[name="name"]').addEventListener('input', function() {
            validateInput(this, nameRegex);
        });

        document.querySelector('input[name="email"]').addEventListener('input', function() {
            validateInput(this, emailRegex);
            activateButton(document.getElementById('isEmailDuplicatedBtn'));
        });

        document.querySelector('input[name="newPasswordConfirmation"]').addEventListener('input', validateNewPasswordConfirmation);
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
        const newPasswordConfirmation = document.querySelector('input[name="newPasswordConfirm"]').value;
        const span = document.querySelector('input[name="newPasswordConfirm"]').nextElementSibling;
        if (newPassword !== newPasswordConfirmation && newPasswordConfirmation !== "") {
            span.style.display = 'inline';
        } else {
            span.style.display = 'none';
        }
    }

    function activateButton(button) {
        button.classList.remove('disabled');
        button.disabled = false;
    }

    function deactivateButton(button) {
        button.classList.add('disabled');
        button.disabled = true;
    }

    let nicknameChecked = false;
    let emailChecked = false;

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
                url : '${ctp}/checkNicknameDuplicated.s',
                type : 'POST',
                data : { nickname : nickname },
                success : function(response) {
                    if (response === 'duplicated') {
                        showAlert('이미 사용 중인 닉네임입니다.');
                        document.forms["updateProfileForm"].nickname.focus();
                        nicknameChecked = false;
                        activateButton(document.getElementById('isNicknameDuplicatedBtn'));
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
                error : function() {
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
                url : '${ctp}/checkEmailDuplicated.s',
                type : 'POST',
                data : { email : email },
                success : function(response) {
                    if (response === 'duplicated') {
                        showAlert('이미 사용 중인 이메일입니다.');
                        document.forms["updateProfileForm"].email.focus();
                        emailChecked = false;
                        activateButton(document.getElementById('isEmailDuplicatedBtn'));
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
                error : function() {
                    showAlert("전송 오류");
                }
            });
        }
    }