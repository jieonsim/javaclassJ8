package localLog;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LikeToggleCommand3 implements LocalLogInterface {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

        System.out.println("Session ID: " + session.getId());
        System.out.println("sessionUserIdx: " + sessionUserIdx);

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
        System.out.println("Processing like for localLogIdx: " + localLogIdx);

        LocalLogDAO localLogDAO = new LocalLogDAO();
        boolean isLiked = localLogDAO.isLikedByUser(sessionUserIdx, localLogIdx);

        if (isLiked) {
            localLogDAO.removeLike(sessionUserIdx, localLogIdx);
            response.getWriter().write("unliked");
        } else {
            localLogDAO.addLike(sessionUserIdx, localLogIdx);
            response.getWriter().write("liked");
        }

        int likeCount = localLogDAO.getLikeCount(localLogIdx);
        response.getWriter().write((isLiked ? "unliked" : "liked") + ";" + likeCount);
    }
}