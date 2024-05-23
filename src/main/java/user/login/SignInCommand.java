package user.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;
import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class SignInCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id") == null ? "" : request.getParameter("id");
		String password = request.getParameter("password") == null ? "" : request.getParameter("password");

		if (id.isEmpty() || password.isEmpty()) {
			request.setAttribute("message", "모든 정보를 입력해주세요.");
			request.setAttribute("url", "login.l");
			return;
		}

		// DB에서 아이디 유무 확인
		UserDAO userDAO = new UserDAO();
		UserVO userVO = userDAO.validateUser(id);

		if (userVO == null) {
			request.setAttribute("message", "아이디를 확인해주세요.");
			request.setAttribute("url", "login.l");
			return;
		}

		// 비밀번호 암호화
		String storedPassword = userVO.getPassword();
		String salt = storedPassword.substring(0, 8);
		SecurityUtil security = new SecurityUtil();
		String hashedPassword = security.encryptSHA256(salt + password);

		if (!storedPassword.equals(salt + hashedPassword)) {
			request.setAttribute("message", "비밀번호를 확인해주세요.");
			request.setAttribute("url", "login.l");
			return;
		} else {
			// 아이디 저장을 위한 쿠키 처리
			boolean rememberId = request.getParameter("rememberId") != null;
			Cookie cookieId = new Cookie("cookieId", id);
			cookieId.setPath("/");
			cookieId.setMaxAge(rememberId ? 60 * 60 * 24 * 7 : 0);
			response.addCookie(cookieId);
			
			// 세션 처리
			HttpSession session = request.getSession();
			session.setAttribute("sessionUserIdx", userVO.getUserIdx());
			session.setAttribute("sessionId", userVO.getId());
			session.setAttribute("sessionNickname", userVO.getNickname());
			session.setAttribute("SessionName", userVO.getName());
			session.setAttribute("sessionRole", userVO.getRole());
			
			response.sendRedirect(request.getContextPath() + "/main");
		}
	}
}
