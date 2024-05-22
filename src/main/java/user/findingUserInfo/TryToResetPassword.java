package user.findingUserInfo;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;
import user.UserDAO;
import user.UserInterface;

public class TryToResetPassword implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String password = request.getParameter("password")==null ? "" : request.getParameter("password");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("sessionId");
		
		// 비밀번호 암호화
		String salt = UUID.randomUUID().toString().substring(0, 8);
		SecurityUtil security = new SecurityUtil();
		String hashedPassword = security.encryptSHA256(salt + password);
		// String storedPassword = salt + hashedPassword;
		
		UserDAO dao = new UserDAO();
		int result = dao.UpdatePassword(id, hashedPassword);
		
		if (result != 0) {
			request.setAttribute("url", "passwordResetComplete.fi");
		} else {
			request.setAttribute("message", "비밀번호 변경이 정상적으로 완료되지 않았습니다. 다시 시도해주세요.");
			request.setAttribute("url", "resetPassword.fi");
		}
	}

}
