package user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.findUserInfo.FindIdCommand;
import user.login.SignInCommand;
import user.signup.CheckEmailDuplicated;
import user.signup.CheckIdDuplicated;
import user.signup.CheckNicknameDuplicated;
import user.signup.SignupCommand;
import user.updateProfile.UpdateProfileCommand;

@SuppressWarnings("serial")
@WebServlet("*.user")
public class UserController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserInterface command = null;
		String viewPage = "/WEB-INF/user/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

		switch (com) {
			case "login":
				viewPage += "login/login.jsp";
				break;
			case "signIn":
				command = new SignInCommand();
				command.execute(request, response);
				return;
			case "signup":
				viewPage += "signup/signup.jsp";
				break;
			case "register":
				command = new SignupCommand();
				command.execute(request, response);
				viewPage += "singup/signupComplete.jsp";
				// return;
			case "checkIdDuplicated":
				command = new CheckIdDuplicated();
				command.execute(request, response);
				return;
			case "checkNicknameDuplicated":
				command = new CheckNicknameDuplicated();
				command.execute(request, response);
				return;
			case "checkEmailDuplicated":
				command = new CheckEmailDuplicated();
				command.execute(request, response);
				return;
			case "findId":
				viewPage += "findUserinfo/findUserId.jsp";
				break;
			case "retrieveId":
				command = new FindIdCommand();
				command.execute(request, response);
				return;
			case "foundIdDisplay":
				viewPage += "findUserinfo/foundIdDisplay.jsp";
				break;
			case "resetPassword":
				viewPage += "findUserinfo/resetPassword.jsp";
				break;
			case "updateProfile":
				viewPage += "updateprofile/updateProfile.jsp";
				break;
			case "update":
				command = new UpdateProfileCommand();
				command.execute(request, response);
				return;
			default:
				viewPage = "/WEB-INF/user/error.jsp";
				break;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
