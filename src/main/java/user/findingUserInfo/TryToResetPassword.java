package user.findingUserInfo;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;
import user.UserDAO;
import user.UserInterface;

public class TryToResetPassword implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id") == null ? "" : request.getParameter("id");
		String newPassword = request.getParameter("password")==null ? "" : request.getParameter("password");
		
		// 비밀번호 암호화
		String salt = UUID.randomUUID().toString().substring(0, 8);
		SecurityUtil security = new SecurityUtil();
		String hashedPassword = security.encryptSHA256(salt + newPassword);
		String storedPassword = salt + hashedPassword;
		
		UserDAO dao = new UserDAO();
		boolean resetSuccess = dao.updatePasswordById(id, storedPassword);
        if (resetSuccess) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/user/findingUserInfo/passwordResetComplete.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("message", "비밀번호 재설정에 실패했습니다. 다시 시도해 주세요.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/user/findingUserInfo/resetPassword.jsp");
            dispatcher.forward(request, response);
        }
	}

}
