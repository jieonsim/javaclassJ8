package user.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserInterface;

@SuppressWarnings("serial")
//@WebServlet("*.l")
public class LoginController2 extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserInterface command = null;
		String viewPage = "/WEB-INF/user/login/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

		// 인증 처리
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("sessionUserIdx") == null) {
			if (!com.equals("login") && !com.equals("tryToLogin")) {
				request.setAttribute("message", "세션이 만료되었습니다. 다시 로그인 해주세요.");
				request.setAttribute("url", "login.l");
				viewPage = "/WEB-INF/user/login/login.jsp";
				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
				dispatcher.forward(request, response);
				return;
			}
		}

		if (com.equals("login")) {
			viewPage += "login.jsp";
		} else if (com.equals("tryToLogin")) {
			command = new TryToLogin();
			command.execute(request, response);
			//viewPage += "login.jsp";
			return;
		} else if (com.equals("welcome")) {
			//command = new Welcome();
			//command.execute(request, response);
			viewPage = "/WEB-INF/main/main.jsp";
		} else if (com.equals("logout")) {
			//command = new Logout();
			//command.execute(request, response);
			viewPage = "/WEB-INF/main/main.jsp";
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
