package record.guestBook;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import record.LoadCategoriesHelper;
import user.UserDAO;
import user.UserVO;

public class RecordGuestBookCommand implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/record/guestBook/record-guestBook.jsp";

		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		// Null 검사
		if (sessionUserIdx == null) {
			request.setAttribute("message", "로그인 후 이용하실 수 있습니다.");
			viewPage = "/WEB-INF/user/login/login.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		UserDAO userDAO = new UserDAO();
		UserVO users = userDAO.getUserByIdx(sessionUserIdx);

		if (users == null) {
			request.setAttribute("message", "사용자 정보를 가져오지 못했습니다.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}
		
		// 카테고리 데이터 로드
		LoadCategoriesHelper.loadCategories(request);
		
		request.setAttribute("users", users);
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
