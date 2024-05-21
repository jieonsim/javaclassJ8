package user.signup;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserInterface;

public class CheckIdDuplicated implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");

		UserDAO dao = new UserDAO();
		boolean isDuplicated = dao.isIdDuplicated(id);

		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();
		if (isDuplicated) {
			out.print("duplicated");
		} else {
			out.print("available");
		}
		out.flush();
	}
}
