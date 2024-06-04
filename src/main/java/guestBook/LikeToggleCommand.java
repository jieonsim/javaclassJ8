package guestBook;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LikeToggleCommand implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		if (sessionUserIdx == null) {
			response.getWriter().write("not_logged_in");
			return;
		}

		String guestBookIdxStr = request.getParameter("guestBookIdx");
		if (guestBookIdxStr == null) {
			response.getWriter().write("error");
			return;
		}

		int guestBookIdx = Integer.parseInt(guestBookIdxStr);
		GuestBookDAO guestBookDAO = new GuestBookDAO();

		// Check if the user is trying to like their own guestbook
		GuestBookVO guestBook = guestBookDAO.getGuestBookByGuestBookIdx(guestBookIdx);
		if (guestBook.getUserIdx() == sessionUserIdx) {
			response.getWriter().write("cannot_like_own");
			return;
		}

		boolean isLiked = guestBookDAO.isLikedByUser(guestBookIdx, sessionUserIdx);

		if (isLiked) {
			guestBookDAO.removeLike(guestBookIdx, sessionUserIdx);
			response.getWriter().write("unliked");
		} else {
			guestBookDAO.addLike(guestBookIdx, sessionUserIdx);
			response.getWriter().write("liked");
		}
	}
}