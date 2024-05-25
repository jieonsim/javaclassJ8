package user.updateProfile;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class LoadProfileCommand2 implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/user/updateProfile/updateProfile.jsp";

		/* String userIdxStr = request.getParameter("userIdx"); */
		String userIdxStr = request.getParameter("sessionUserIdx");
		System.out.println("Received userIdxStr: " + userIdxStr); // Debugging line

		if (userIdxStr == null) {
			HttpSession session = request.getSession();
			Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");
			if (sessionUserIdx != null) {
				userIdxStr = sessionUserIdx.toString();
			}
		}

		int userIdx = 0;
		try {
			userIdx = Integer.parseInt(userIdxStr);
		} catch (NumberFormatException | NullPointerException e) {
			request.setAttribute("message", "잘못된 userIdx입니다.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		UserDAO userDAO = new UserDAO();
		UserVO userVO = userDAO.getUserByIdx(userIdx); // 기존 사용자 정보를 가져옴

		if (userVO == null) {
			request.setAttribute("message", "사용자 정보를 가져오지 못했습니다.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		request.setAttribute("userVO", userVO);

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
