package archive;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserVO;

public class ArchiveLocalLogCommand implements ArchiveInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/archive/archive-localLog.jsp";

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
		UserVO userVO = userDAO.getUserByIdx(sessionUserIdx);

		if (userVO == null) {
			request.setAttribute("message", "사용자 정보를 가져오지 못했습니다.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		request.setAttribute("userVO", userVO);
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
