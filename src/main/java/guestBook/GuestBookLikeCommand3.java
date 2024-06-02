package guestBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import localLog.LocalLogInterface;

public class GuestBookLikeCommand3 implements LocalLogInterface {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

        if (sessionUserIdx == null) {
            response.getWriter().write("{\"status\": \"not_logged_in\"}");
            return;
        }

        String guestBookIdxStr = request.getParameter("guestBookIdx");

        if (guestBookIdxStr == null || guestBookIdxStr.isEmpty()) {
            response.getWriter().write("{\"status\": \"invalid_request\"}");
            return;
        }

        //int guestBookIdx;
//        try {
//            guestBookIdx = Integer.parseInt(guestBookIdxStr);
//        } catch (NumberFormatException e) {
//            response.getWriter().write("{\"status\": \"invalid_number_format\"}");
//            return;
//        }
//
//        UserDAO userDAO = new UserDAO();
//        UserVO user = userDAO.getUserByIdx(sessionUserIdx);
//
//        if (user == null) {
//            response.getWriter().write("{\"status\": \"user_not_found\"}");
//            return;
//        }

//        /GuestBookDAO guestBookDAO = new GuestBookDAO();
//        boolean isLiked = guestBookDAO.checkIfLiked(sessionUserIdx, guestBookIdx);
//
//        PrintWriter out = response.getWriter();
//        response.setContentType("application/json");
//
//        if (isLiked) {
//            guestBookDAO.removeLike(sessionUserIdx, guestBookIdx);
//            int likeCount = guestBookDAO.getLikeCount(guestBookIdx);
//            out.write("{\"status\": \"unliked\", \"likeCount\": " + likeCount + "}");
//        } else {
//            guestBookDAO.addLike(sessionUserIdx, guestBookIdx);
//            int likeCount = guestBookDAO.getLikeCount(guestBookIdx);
//            out.write("{\"status\": \"liked\", \"likeCount\": " + likeCount + "}");
//        }

//        out.flush();
    }
}