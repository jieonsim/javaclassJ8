package bookmark;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BookmarkCheckCommand implements BookmarkInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		if (sessionUserIdx == null) {
			response.getWriter().write("not_logged_in");
			return;
		}

		String localLogIdxStr = request.getParameter("localLogIdx");

		if (localLogIdxStr == null) {
			response.getWriter().write("error");
			return;
		}

		int localLogIdx = Integer.parseInt(localLogIdxStr);
        
		BookmarkDAO bookmarkDAO = new BookmarkDAO();
		boolean isBookmarked = bookmarkDAO.isBookmarked(sessionUserIdx, localLogIdx);

		if (isBookmarked) {
			bookmarkDAO.removeBookmark(sessionUserIdx, localLogIdx);
			response.getWriter().write("unbookmarked");
		} else {
			bookmarkDAO.addBookmark(sessionUserIdx, localLogIdx);
			response.getWriter().write("bookmarked");
		}
	}
}