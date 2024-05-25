package user.signup;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;
import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class SignupCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/user/singup/signup.jsp";
		
		String id = request.getParameter("id") == null ? "" : request.getParameter("id");
		String password = request.getParameter("password") == null ? "" : request.getParameter("password");
		String nickname = request.getParameter("nickname") == null ? "" : request.getParameter("nickname");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");

		if (id.isEmpty() || password.isEmpty() || nickname.isEmpty() || name.isEmpty() || email.isEmpty()) {
			request.setAttribute("message", "모든 정보를 입력해주세요.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		// 비밀번호 암호화
		String salt = UUID.randomUUID().toString().substring(0, 8);
		SecurityUtil security = new SecurityUtil();
		String hashedPassword = security.encryptSHA256(salt + password);
		String storedPassword = salt + hashedPassword;

		// 저장
		UserVO vo = new UserVO();
		vo.setId(id);
		vo.setPassword(storedPassword);
		vo.setNickname(nickname);
		vo.setName(name);
		vo.setEmail(email);

		UserDAO dao = new UserDAO();
		int result = dao.insertUser(vo);

		if (result != 0) {
			response.sendRedirect("signupComplete.s");
		} else {
			request.setAttribute("message", "회원 가입이 정상적으로 완료되지 않았습니다. 다시 시도해주세요.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
	}
}