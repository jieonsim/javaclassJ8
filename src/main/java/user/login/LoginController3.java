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
public class LoginController3 extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserInterface command = null;
		String viewPage = "/WEB-INF/user/login/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

		HttpSession session = request.getSession();
		String role = session.getAttribute("sessionRole") == null ? "" : (String) session.getAttribute("sessionRole");

		if (com.equals("login")) {
			viewPage += "login.jsp";
		} else if (com.equals("tryingLogin")) {
			command = new Login();
			command.execute(request, response);
			String url = (String) request.getAttribute("url");
			if (url != null && url.equals("welcome.l")) {
				viewPage = "/WEB-INF/main/main.jsp";
			} else {
				viewPage += "login.jsp";
			}
		} else if (role.isEmpty()) {
			request.setAttribute("message", "로그인 후 이용해 주세요.");
			request.setAttribute("url", "login.l");
			viewPage += "login.jsp";
		} else if (com.equals("welcome")) {
			command = new UserMain();
			command.execute(request, response);
			viewPage = "/WEB-INF/main/main.jsp";
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
