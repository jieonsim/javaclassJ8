package user.findingUserInfo;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import user.UserInterface;

@SuppressWarnings("serial")
@WebServlet("*.fi")
public class FindingUserInfoController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserInterface command = null;
		String viewPage = "/WEB-INF/user/findingUserInfo/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

		if (com.equals("findingId")) {
			viewPage += "findingId.jsp";
		} else if (com.equals("tryToFindId")) {
			command = new TryToFindId();
			command.execute(request, response);
			return;
		} else if (com.equals("foundIdDisplay")) {
			viewPage += "foundIdDisplay.jsp";
		} else if (com.equals("findingPassword")) {
			viewPage += "findingPassword.jsp";
		} else if (com.equals("tryToFindPassword")) {
			command = new TryToFindPassword();
			command.execute(request, response);
			return;
		} else if (com.equals("resetPassword")) {
			viewPage += "resetPassword.jsp";
		} else if (com.equals("tryToResetPassword")) {
			command = new TryToResetPassword();
			command.execute(request, response);
			return;
		} else if (com.equals("passwordResetComplete")) {
			viewPage += "passwordResetComplete.jsp";
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
