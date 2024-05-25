package user.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserInterface;

public class CheckEmailDuplicated implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");

		if (email.isEmpty()) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("Invalid Email");
			return;
		}

		UserDAO dao = new UserDAO();
		boolean isDuplicated = dao.checkEmailDuplicated(email);

		response.setContentType("text/plain");
		if (isDuplicated) {
			response.getWriter().write("duplicated");
		} else {
			response.getWriter().write("available");
		}
	}
}
