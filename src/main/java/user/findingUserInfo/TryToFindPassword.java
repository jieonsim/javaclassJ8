package user.findingUserInfo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserInterface;

public class TryToFindPassword implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");

		UserDAO dao = new UserDAO();

	}

}
