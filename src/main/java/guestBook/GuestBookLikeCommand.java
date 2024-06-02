package guestBook;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import localLog.LocalLogInterface;
import user.UserDAO;
import user.UserVO;

public class GuestBookLikeCommand implements LocalLogInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		if (sessionUserIdx == null) {
			response.getWriter().write("{\"status\": \"not_logged_in\"}");
			return;
		}

		int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));
		int guestBookIdx = Integer.parseInt(request.getParameter("guestBookIdx"));

		// Log the incoming request
		System.out.println("itemIdx: " + itemIdx + ", guestBookIdx: " + guestBookIdx + ", userIdx: " + sessionUserIdx);

		UserDAO userDAO = new UserDAO();
		UserVO user = userDAO.getUserByIdx(sessionUserIdx);

		if (user == null) {
			response.getWriter().write("{\"status\": \"user_not_found\"}");
			return;
		}

		//GuestBookDAO guestBookDAO = new GuestBookDAO();
		//boolean isLiked = guestBookDAO.checkIfLiked(sessionUserIdx, itemIdx, guestBookIdx);

		PrintWriter out = response.getWriter();
		response.setContentType("application/json");

//		if (isLiked) {
//			guestBookDAO.removeLike(sessionUserIdx, itemIdx, guestBookIdx);
//			int likeCount = guestBookDAO.getLikeCount(itemIdx, guestBookIdx);
//			out.write("{\"status\": \"unliked\", \"likeCount\": " + likeCount + "}");
//		} else {
//			guestBookDAO.addLike(sessionUserIdx, itemIdx, guestBookIdx);
//			int likeCount = guestBookDAO.getLikeCount(itemIdx, guestBookIdx);
//			out.write("{\"status\": \"liked\", \"likeCount\": " + likeCount + "}");
//		}

		out.flush();
	}
}