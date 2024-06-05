package localLog;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LikeToggleCommand implements LocalLogInterface {

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
		LocalLogDAO localLogDAO = new LocalLogDAO();

		// Check if the user is trying to like their own local log
		boolean isLiked = localLogDAO.isLikedByUser(sessionUserIdx, localLogIdx);

		if (isLiked) {
			localLogDAO.removeLike(sessionUserIdx, localLogIdx);
			response.getWriter().write("unliked");
		} else {
			localLogDAO.addLike(sessionUserIdx, localLogIdx);
			response.getWriter().write("liked");
		}
	}
}
