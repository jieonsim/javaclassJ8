package localLog;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.UserDAO;
import user.UserVO;
import java.io.PrintWriter;

public class LocalLogLikeCommand implements LocalLogInterface {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

        if (sessionUserIdx == null) {
            response.getWriter().write("{\"status\": \"not_logged_in\"}");
            return;
        }

        String localLogIdxStr = request.getParameter("localLogIdx");

        if (localLogIdxStr == null || localLogIdxStr.isEmpty()) {
            response.getWriter().write("{\"status\": \"invalid_request\"}");
            return;
        }

        int localLogIdx;
        try {
            localLogIdx = Integer.parseInt(localLogIdxStr);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"invalid_number_format\"}");
            return;
        }

        UserDAO userDAO = new UserDAO();
        UserVO user = userDAO.getUserByIdx(sessionUserIdx);

        if (user == null) {
            response.getWriter().write("{\"status\": \"user_not_found\"}");
            return;
        }

        LocalLogDAO localLogDAO = new LocalLogDAO();
        boolean isLiked = localLogDAO.checkIfLiked(sessionUserIdx, localLogIdx);

        PrintWriter out = response.getWriter();
        response.setContentType("application/json");

        if (isLiked) {
            localLogDAO.removeLike(sessionUserIdx, localLogIdx);
            int likeCount = localLogDAO.getLikeCount(localLogIdx);
            out.write("{\"status\": \"unliked\", \"likeCount\": " + likeCount + "}");
        } else {
            localLogDAO.addLike(sessionUserIdx, localLogIdx);
            int likeCount = localLogDAO.getLikeCount(localLogIdx);
            out.write("{\"status\": \"liked\", \"likeCount\": " + likeCount + "}");
        }

        out.flush();
    }
}