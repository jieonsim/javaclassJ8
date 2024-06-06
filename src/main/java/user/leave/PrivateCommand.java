package user.leave;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserInterface;

public class PrivateCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/user/leave/leave.jsp";

		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		// Null 검사
		if (sessionUserIdx == null) {
			request.setAttribute("message", "로그인 후 이용하실 수 있습니다.");
			viewPage = "/WEB-INF/user/login/login.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		UserDAO userDAO = new UserDAO();
		boolean hasLocalLogs = userDAO.checkUserLocalLogs(sessionUserIdx);
		boolean hasGuestBooks = userDAO.checkUserGuestBooks(sessionUserIdx);

		if (hasLocalLogs || hasGuestBooks) {
			if (hasLocalLogs) {
				userDAO.updateLocalLogsVisibilityToPrivate(sessionUserIdx);
			}
			if (hasGuestBooks) {
				userDAO.updateGuestBooksVisibilityToPrivate(sessionUserIdx);
			}
			userDAO.updateUserVisibilityToPrivate(sessionUserIdx); 
			request.setAttribute("message", "모든 콘텐츠가 비공개 처리되었습니다.");
		} else {
			request.setAttribute("message", "작성하신 로컬로그 및 방명록이 없습니다.");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
