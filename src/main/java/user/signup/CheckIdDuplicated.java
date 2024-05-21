package user.signup;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserInterface;

public class CheckIdDuplicated implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id") == null ? "" : request.getParameter("id");

		if (id.isEmpty()) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("Invalid ID");
			return;
		}

		UserDAO dao = new UserDAO();
		boolean isDuplicated = dao.checkIdDuplicated(id);

		response.setContentType("text/plain");
		if (isDuplicated) {
			response.getWriter().write("duplicated");
		} else {
			response.getWriter().write("available");
		}
	}
}
