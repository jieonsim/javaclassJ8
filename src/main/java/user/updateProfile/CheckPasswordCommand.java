package user.updateProfile;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;
import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class CheckPasswordCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/user/updateProfile/checkPassword.jsp";
		
		String password = request.getParameter("password") == null ? "" : request.getParameter("password");

		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		// Null 검사
		if (sessionUserIdx == null) {
			request.setAttribute("message", "세션이 만료되었습니다. 다시 로그인 해주세요.");
			viewPage = "/WEB-INF/user/login/login.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		UserDAO userDAO = new UserDAO();
		UserVO userVO = userDAO.getUserByIdx(sessionUserIdx);

		// 저장된 비밀번호에서 salt를 추출
		String storedPassword = userVO.getPassword();
		String salt = storedPassword.substring(0, 8);
		String storedHashedPassword = storedPassword.substring(8);

		// 입력된 비밀번호와 추출한 salt를 사용해 해시 생성
		SecurityUtil security = new SecurityUtil();
		String hashedPassword = security.encryptSHA256(salt + password);

		// 저장된 비밀번호와 비교
		if (!storedHashedPassword.equals(hashedPassword)) {
			request.setAttribute("message", "비밀번호를 확인해주세요.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		} else {
			session.setAttribute("sessionUserIdx", userVO.getUserIdx());
			response.sendRedirect("updateProfile.u");
		}
	}
}