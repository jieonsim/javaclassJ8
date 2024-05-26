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

public class LoadProfileCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/user/updateProfile/updateProfile.jsp";

		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		if (sessionUserIdx == null) {
			request.setAttribute("message", "세션이 만료되었습니다. 로그인 후 이용해주세요.");
			viewPage = "/WEB-INF/user/login/login.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}
		
		UserDAO userDAO = new UserDAO();
		UserVO userVO = userDAO.getUserByIdx(sessionUserIdx);

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