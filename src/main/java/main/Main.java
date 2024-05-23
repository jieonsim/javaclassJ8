package main;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.UserDAO;
import user.UserVO;

@SuppressWarnings("serial")
@WebServlet("/main")
public class Main extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if ("logout".equals(action)) {
			handleLogout(request, response);
		} else {
			handleMainPage(request, response);
		}
	}

	private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session != null) {
			session.invalidate();
		}

		response.sendRedirect(request.getContextPath() + "/main");
	}

	private void handleMainPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UserVO userVO = null;

		if (session != null && session.getAttribute("sessionUserIdx") != null) {
			int userIdx = (int) session.getAttribute("sessionUserIdx");

			UserDAO userDAO = new UserDAO();
			userVO = userDAO.getUserByIdx(userIdx);

			request.setAttribute("userVO", userVO);
		}

		String viewPage = "/WEB-INF/main/main.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
