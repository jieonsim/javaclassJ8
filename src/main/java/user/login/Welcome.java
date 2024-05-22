package user.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class Welcome implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		String id = (String) session.getAttribute("sessionId");

		UserDAO userDAO = new UserDAO();
		UserVO userVO = userDAO.validateUser(id);

		request.setAttribute("userVO", userVO);
	}
}
