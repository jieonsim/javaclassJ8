package user.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserInterface;

public class CheckNicknameDuplicated implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nickname = request.getParameter("nickname") == null ? "" : request.getParameter("nickname");

		if (nickname.isEmpty()) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("Invalid Nickname");
			return;
		}

		UserDAO dao = new UserDAO();
		boolean isDuplicated = dao.checkNicknameDuplicated(nickname);

		response.setContentType("text/plain");
		if (isDuplicated) {
			response.getWriter().write("duplicated");
		} else {
			response.getWriter().write("available");
		}
	}
}