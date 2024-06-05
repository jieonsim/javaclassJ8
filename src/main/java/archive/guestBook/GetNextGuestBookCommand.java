package archive.guestBook;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import archive.ArchiveInterface;
import guestBook.GuestBookDAO;
import guestBook.GuestBookVO;
import user.UserDAO;
import user.UserVO;

public class GetNextGuestBookCommand implements ArchiveInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/archive/guestBook/getNextGuestBook.jsp";

		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

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

		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = 3;
		int totRecCnt = guestBookDAO.getGuestBookCountByUserIdx(sessionUserIdx);
		int totalPages = (int) Math.ceil((double) totRecCnt / pageSize);
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		List<GuestBookVO> guestBooks = guestBookDAO.getGuestBooksByUserIdx(sessionUserIdx, startIndexNo, pageSize);
		int guestBookCount = guestBookDAO.getGuestBookCountByUserIdx(sessionUserIdx);
		
		request.setAttribute("guestBooks", guestBooks);
		request.setAttribute("guestBookCount", guestBookCount);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("totalPages", totalPages);

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}