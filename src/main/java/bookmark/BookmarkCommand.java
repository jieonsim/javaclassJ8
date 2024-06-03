package bookmark;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserVO;

public class BookmarkCommand implements BookmarkInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/bookmark/bookmark.jsp";

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
		
		BookmarkDAO bookmarkDAO = new BookmarkDAO();
		
		int pag = 1;
		int pageSize = 6;
		int totRecCnt = bookmarkDAO.getBookmarkCountByUserIdx(sessionUserIdx);
		int totalPages = (int) Math.ceil((double) totRecCnt / pageSize);
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		List<BookmarkVO> bookmarks = bookmarkDAO.getBookmarksByUserIdx(sessionUserIdx, startIndexNo, pageSize);
		
		request.setAttribute("bookmarks", bookmarks);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("totalPages", totalPages);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
