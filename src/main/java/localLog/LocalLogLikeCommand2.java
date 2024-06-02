package localLog;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserVO;

public class LocalLogLikeCommand2 implements LocalLogInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

        if (sessionUserIdx == null) {
            response.getWriter().write("{\"status\": \"not_logged_in\"}");
            return;
        }

        //int localLogIdx = Integer.parseInt(request.getParameter("localLogIdx"));
        UserDAO userDAO = new UserDAO();
        UserVO user = userDAO.getUserByIdx(sessionUserIdx);

        if (user == null) {
            response.getWriter().write("{\"status\": \"user_not_found\"}");
            return;
        }

//        LocalLogDAO localLogDAO = new LocalLogDAO();
//        boolean isLiked = localLogDAO.checkIfLiked(sessionUserIdx, localLogIdx);
//
//        PrintWriter out = response.getWriter();
//        response.setContentType("application/json");
//
//        if (isLiked) {
//            localLogDAO.removeLike(sessionUserIdx, localLogIdx);
//            int likeCount = localLogDAO.getLikeCount(localLogIdx);
//            out.write("{\"status\": \"unliked\", \"likeCount\": " + likeCount + "}");
//        } else {
//            localLogDAO.addLike(sessionUserIdx, localLogIdx);
//            int likeCount = localLogDAO.getLikeCount(localLogIdx);
//            out.write("{\"status\": \"liked\", \"likeCount\": " + likeCount + "}");
//        }

        //out.flush();
    }
}
