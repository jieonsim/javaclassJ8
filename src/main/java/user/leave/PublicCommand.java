package user.leave;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserInterface;

public class PublicCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// String viewPage = "/WEB-INF/archive/localLog/archive-localLog.jsp";

		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		// Null 검사
		if (sessionUserIdx == null) {
			request.setAttribute("message", "로그인 후 이용하실 수 있습니다.");
			String viewPage = "/WEB-INF/user/login/login.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		UserDAO userDAO = new UserDAO();
		boolean hasLocalLogs = userDAO.checkUserLocalLogs(sessionUserIdx);
		boolean hasGuestBooks = userDAO.checkUserGuestBooks(sessionUserIdx);

		if (hasLocalLogs || hasGuestBooks) {
			if (hasLocalLogs) {
				userDAO.updateLocalLogsVisibilityToPublic(sessionUserIdx);
			}
			if (hasGuestBooks) {
				userDAO.updateGuestBooksVisibilityToPublic(sessionUserIdx);
			}
			userDAO.updateUserVisibilityToPublic(sessionUserIdx);
		}
		response.sendRedirect("archive-localLog.a");
	}
}
