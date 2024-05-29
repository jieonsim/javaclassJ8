package archive.guestBook;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import archive.ArchiveInterface;
import record.guestBook.GuestBookDAO;
import record.guestBook.GuestBookVO;
import user.UserDAO;
import user.UserVO;

public class ArchiveGuestBookCommand implements ArchiveInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/archive/archive-guestBook.jsp";

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
		
		GuestBookDAO guestBookDAO = new GuestBookDAO();
        List<GuestBookVO> guestBooks = guestBookDAO.getGuestBooksByUserIdx(sessionUserIdx);
        
		request.setAttribute("users", users);
		request.setAttribute("guestBooks", guestBooks);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}