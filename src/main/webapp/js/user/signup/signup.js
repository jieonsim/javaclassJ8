    document.addEventListener('DOMContentLoaded', function() {
        const idRegex = /^[a-z][a-z0-9]{4,14}$/;
        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;
        const nicknameRegex = /^[a-z0-9._]{2,15}$/;
        const nameRegex = /^(?:[a-z]{2,50}|[가-힣]{2,50})$/;
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

		document.getElementById('id').addEventListener('input', function() {
            validateInput(this, idRegex);
            activateButton(document.getElementById('isIdDuplicatedBtn'));
        });

        document.querySelector('input[name="password"]').addEventListener('input', function() {
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

        document.querySelector('input[name="passwordConfirmation"]').addEventListener('input', validatePasswordConfirmation);
    });

    function validateInput(input, regex) {
        const span = input.nextElementSibling;
        if (!regex.test(input.value)) {
            span.style.display = 'inline';
        } else {
            span.style.display = 'none';
        }
    }

    function validatePasswordConfirmation() {
        const password = document.querySelector('input[name="password"]').value;
        const passwordConfirmation = document.querySelector('input[name="passwordConfirmation"]').value;
        const span = document.querySelector('input[name="passwordConfirmation"]').nextElementSibling;
        if (password !== passwordConfirmation && passwordConfirmation !== "") {
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

    let idChecked = false;
    let nicknameChecked = false;
    let emailChecked = false;

    function checkIdDuplicated() {
        const id = document.forms["signupForm"].id.value.trim();
        const idRegex = /^[a-z][a-z0-9]{4,14}$/;

        if (id === "") {
            showAlert("아이디를 입력하세요.");
            document.forms["signupForm"].id.focus();
            return;
        }

        if (!idRegex.test(id)) {
            showAlert("5자 이상 15자 이하의 영문 혹은 영문과 숫자를 조합");
            document.forms["signupForm"].id.focus();
        } else {
            $.ajax({
                url : '${ctp}/checkIdDuplicated.s',
                type : 'POST',
                data : { id : id },
                success : function(response) {
                    if (response === 'duplicated') {
                        showAlert('이미 사용 중인 아이디입니다.');
                        document.forms["signupForm"].id.focus();
                        idChecked = false;
                        activateButton(document.getElementById('isIdDuplicatedBtn'));
                    } else if (response === 'available') {
                        showAlert('사용 가능한 아이디입니다.');
                        idChecked = true;
                        deactivateButton(document.getElementById('isIdDuplicatedBtn'));
                    } else if (response === 'Invalid ID') {
                        showAlert('잘못된 아이디입니다.');
                        document.forms["signupForm"].id.focus();
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

    function checkNicknameDuplicated() {
        const nickname = document.forms["signupForm"].nickname.value.trim();
        const nicknameRegex = /^[a-z0-9._]{2,15}$/;

        if (nickname === "") {
            showAlert("닉네임을 입력하세요.");
            document.forms["signupForm"].nickname.focus();
            return;
        }

        if (!nicknameRegex.test(nickname)) {
            showAlert("2자 이상 15자 이하의 영문, 숫자, 마침표, 언더바만 입력 가능");
            document.forms["signupForm"].nickname.focus();
        } else {
            $.ajax({
                url : '${ctp}/checkNicknameDuplicated.s',
                type : 'POST',
                data : { nickname : nickname },
                success : function(response) {
                    if (response === 'duplicated') {
                        showAlert('이미 사용 중인 닉네임입니다.');
                        document.forms["signupForm"].nickname.focus();
                        nicknameChecked = false;
                        activateButton(document.getElementById('isNicknameDuplicatedBtn'));
                    } else if (response === 'available') {
                        showAlert('사용 가능한 닉네임입니다.');
                        nicknameChecked = true;
                        deactivateButton(document.getElementById('isNicknameDuplicatedBtn'));
                    } else if (response === 'Invalid Nickname') {
                        showAlert('잘못된 닉네임입니다.');
                        document.forms["signupForm"].nickname.focus();
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
        const email = document.forms["signupForm"].email.value.trim();
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (email === "") {
            showAlert("이메일을 입력하세요.");
            document.forms["signupForm"].email.focus();
            return;
        }

        if (!emailRegex.test(email)) {
            showAlert("이메일 형식에 맞춰 입력해주세요.");
            document.forms["signupForm"].email.focus();
        } else {
            $.ajax({
                url : '${ctp}/checkEmailDuplicated.s',
                type : 'POST',
                data : { email : email },
                success : function(response) {
                    if (response === 'duplicated') {
                        showAlert('이미 사용 중인 이메일입니다.');
                        document.forms["signupForm"].email.focus();
                        emailChecked = false;
                        activateButton(document.getElementById('isEmailDuplicatedBtn'));
                    } else if (response === 'available') {
                        showAlert('사용 가능한 이메일입니다.');
                        emailChecked = true;
                        deactivateButton(document.getElementById('isEmailDuplicatedBtn'));
                    } else if (response === 'Invalid Email') {
                        showAlert('잘못된 이메일입니다.');
                        document.forms["signupForm"].email.focus();
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

    function validateForm() {
        const id = document.forms["signupForm"].id.value.trim();
        const password = document.forms["signupForm"].password.value.trim();
        const passwordConfirmation = document.forms["signupForm"].passwordConfirmation.value.trim();
        const nickname = document.forms["signupForm"].nickname.value.trim();
        const name = document.forms["signupForm"].name.value.trim();
        const email = document.forms["signupForm"].email.value.trim();

        const idRegex = /^[a-z][a-z0-9]{4,14}$/;
        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{10,30}$/;
        const nicknameRegex = /^[a-z0-9._]{2,30}$/;
        const nameRegex = /^(?:[a-z]{2,50}|[가-힣]{2,50})$/;
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (id === "") {
            showAlert("아이디를 입력해주세요.");
            document.forms["signupForm"].id.focus();
            return false;
        }

        if (!idRegex.test(id)) {
            showAlert("아이디는 5자 이상 15자 이하의<br>영문 혹은 영문과 숫자를 조합");
            document.forms["signupForm"].id.focus();
            return false;
        }

        if (!idChecked) {
            showAlert("아이디 중복 확인을 해주세요.");
            return false;
        }

        if (password === "") {
            showAlert("비밀번호를 입력해주세요.");
            document.forms["signupForm"].password.focus();
            return false;
        }

        if (!passwordRegex.test(password)) {
            showAlert("비밀번호는 10자 이상,<br>영문, 숫자, 특수문자 포함");
            document.forms["signupForm"].password.focus();
            return false;
        }

        if (password !== passwordConfirmation) {
            showAlert("비밀번호가 일치하지 않습니다.");
            document.forms["signupForm"].passwordConfirmation.focus();
            return false;
        }

        if (nickname === "") {
            showAlert("닉네임을 입력해주세요.");
            document.forms["signupForm"].nickname.focus();
            return false;
        }

        if (!nicknameRegex.test(nickname)) {
            showAlert("닉네임은 2자 이상 30자 이하의<br>영문, 숫자, 마침표, 언더바만 가능");
            document.forms["signupForm"].nickname.focus();
            return false;
        }

        if (!nicknameChecked) {
            showAlert("닉네임 중복 확인을 해주세요.");
            return false;
        }

        if (name === "") {
            showAlert("이름을 입력해주세요.");
            document.forms["signupForm"].name.focus();
            return false;
        }

        if (!nameRegex.test(name)) {
            showAlert("이름은 2자 이상 50자 이하의<br>한글 또는 영문만 입력 가능");
            document.forms["signupForm"].name.focus();
            return false;
        }

        if (email === "") {
            showAlert("이메일을 입력해주세요.");
            document.forms["signupForm"].email.focus();
            return false;
        }

        if (!emailRegex.test(email)) {
            showAlert("이메일 형식에 맞춰 입력해주세요.");
            document.forms["signupForm"].email.focus();
            return false;
        }

        if (!emailChecked) {
            showAlert("이메일 중복 확인을 해주세요.");
            return false;
        }

        return true;
    }

