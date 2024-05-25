package user.updateProfile;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserInterface;
import user.common.CheckEmailDuplicated;
import user.common.CheckNicknameDuplicated;

@SuppressWarnings("serial")
@WebServlet("*.u")
public class UpdateProfileController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserInterface command = null;
		String viewPage = "/WEB-INF/user/updateProfile/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));
		
		if (com.equals("checkPassword")) {
			viewPage += "checkPassword.jsp";
		} 
		else if (com.equals("tryToCheckPassword")) {
			command = new CheckPasswordCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("updateProfile")) {
			command = new LoadProfileCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("tryToUpdateProfile")) {
			command = new UpdateProfileCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("checkNicknameDuplicated")) {
			command = new CheckNicknameDuplicated();
			command.execute(request, response);
			return;
		}
		else if (com.equals("checkEmailDuplicated")) {
			command = new CheckEmailDuplicated();
			command.execute(request, response);
			return;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
