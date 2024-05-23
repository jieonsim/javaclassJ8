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
		HttpSession session = request.getSession(false);

		int userIdx = (int) session.getAttribute("sessionUserIdx");

		UserDAO userDAO = new UserDAO();
		UserVO userVO = userDAO.getUserByIdx(userIdx);

		request.setAttribute("userVO", userVO);
	}
}
