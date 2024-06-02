package localLog;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckLocalLogLikeStatusCommand implements LocalLogInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		if (sessionUserIdx == null) {
			response.getWriter().write("{\"status\": \"not_logged_in\"}");
			return;
		}

		String localLogIdxStr = request.getParameter("localLogIdx");
		String userIdxStr = request.getParameter("userIdx");

		if (localLogIdxStr == null || localLogIdxStr.isEmpty() || userIdxStr == null || userIdxStr.isEmpty()) {
			response.getWriter().write("{\"status\": \"invalid_request\"}");
			return;
		}

		int localLogIdx = Integer.parseInt(localLogIdxStr);
		int userIdx = Integer.parseInt(userIdxStr);

		LocalLogDAO localLogDAO = new LocalLogDAO();
		boolean isLiked = localLogDAO.checkIfLiked(userIdx, localLogIdx);
		int likeCount = localLogDAO.getLikeCount(localLogIdx);

		PrintWriter out = response.getWriter();
		response.setContentType("application/json");

		if (isLiked) {
			out.write("{\"status\": \"liked\", \"likeCount\": " + likeCount + "}");
		} else {
			out.write("{\"status\": \"not_liked\", \"likeCount\": " + likeCount + "}");
		}

		out.flush();
	}
}
