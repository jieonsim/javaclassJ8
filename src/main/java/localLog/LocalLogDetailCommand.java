package localLog;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bookmark.BookmarkDAO;
import guestBook.GuestBookDAO;
import guestBook.GuestBookVO;
import place.PlaceDAO;
import place.PlaceVO;
import user.UserDAO;
import user.UserVO;

public class LocalLogDetailCommand implements LocalLogInterface {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

        int localLogIdx = Integer.parseInt(request.getParameter("localLogIdx"));

        LocalLogDAO localLogDAO = new LocalLogDAO();
        LocalLogVO localLog = localLogDAO.getLocalLogByIdx(localLogIdx);

        UserDAO userDAO = new UserDAO();
        UserVO user = userDAO.getUserByIdx(localLog.getUserIdx());

        PlaceDAO placeDAO = new PlaceDAO();
        PlaceVO place = placeDAO.getPlaceByPlaceIdx(localLog.getPlaceIdx());

        GuestBookDAO guestBookDAO = new GuestBookDAO();
        List<GuestBookVO> guestBooks = guestBookDAO.getGuestBooksByPlaceIdx(localLog.getPlaceIdx(), sessionUserIdx != null ? sessionUserIdx : 0);

        boolean isBookmarked = false;
        if (sessionUserIdx != null) {
            BookmarkDAO bookmarkDAO = new BookmarkDAO();
            isBookmarked = bookmarkDAO.isBookmarked(sessionUserIdx, localLogIdx);
        }

        request.setAttribute("localLog", localLog);
        request.setAttribute("user", user);
        request.setAttribute("place", place);
        request.setAttribute("isBookmarked", isBookmarked);
        request.setAttribute("guestBooks", guestBooks);

        String viewPage = "/WEB-INF/localLog/localLogDetail.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
    }
}