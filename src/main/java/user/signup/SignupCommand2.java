package user.signup;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;
import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class SignupCommand2 implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id") == null ? "" : request.getParameter("id");
		String password = request.getParameter("password") == null ? "" : request.getParameter("password");
		String nickname = request.getParameter("nickname") == null ? "" : request.getParameter("nickname");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");

        if (id.isEmpty() || password.isEmpty() || nickname.isEmpty() || name.isEmpty() || email.isEmpty()) {
            request.setAttribute("message", "모든 정보를 입력해주세요.");
            request.setAttribute("url", "signup.s");
            request.getRequestDispatcher("/WEB-INF/user/signup/signup.jsp").forward(request, response);
            return;
        }

		// 아이디, 닉네임, 이메일 중복 체크
		UserDAO dao = new UserDAO();

		if (dao.checkIdDuplicated(id)) {
			setMessage(request, response, "이미 사용 중인 아이디입니다.", "signup.s");
			return;
		}

		if (dao.checkNicknameDuplicated(nickname)) {
			setMessage(request, response, "이미 사용 중인 닉네임입니다.", "signup.s");
			return;
		}

		if (dao.checkEmailDuplicated(email)) {
			setMessage(request, response, "이미 사용 중인 이메일입니다.", "signup.s");
			return;
		}

		// 비밀번호 암호화
		String salt = UUID.randomUUID().toString().substring(0, 8);
		SecurityUtil security = new SecurityUtil();
		password = security.encryptSHA256(salt + password);
		password = salt + password;

		// 저장
		UserVO vo = new UserVO();
		vo.setId(id);
		vo.setPassword(password);
		vo.setNickname(nickname);
		vo.setName(name);
		vo.setEmail(email);

		int result = dao.insertUser(vo);

		if (result != 0) {
			request.setAttribute("url", "signupComplete.s");
		} else {
			setMessage(request, response, "회원 가입이 정상적으로 완료되지 않았습니다. 다시 시도해주세요.", "signup.s");
			return;
		}
	}

	private void setMessage(HttpServletRequest request, HttpServletResponse response, String message, String url) throws ServletException, IOException {
		request.setAttribute("message", message);
		request.setAttribute("url", url);
		request.getRequestDispatcher("/WEB-INF/user/signup/signup.jsp").forward(request, response);
	}
}
