package profile;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import guestBook.GuestBookDAO;
import guestBook.GuestBookVO;
import user.UserDAO;
import user.UserVO;

public class GetNextGuestBookCommand implements ProfileInterface {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String viewPage = "/WEB-INF/profile/getNextGuestBook.jsp";

        HttpSession session = request.getSession();
        Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

        String userIdxStr = request.getParameter("userIdx");
        Integer userIdx = null;
        if (userIdxStr != null) {
            try {
                userIdx = Integer.parseInt(userIdxStr);
            } catch (NumberFormatException e) {
                System.out.println("Invalid userIdx parameter: " + userIdxStr);
                viewPage = "/WEB-INF/profile/profile-guestbook.jsp";
                request.setAttribute("message", "유효하지 않은 계정입니다.");
                RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
                dispatcher.forward(request, response);
                return;
            }
        }
        //System.out.println("userIdx : " + userIdx);

        if (sessionUserIdx != null && sessionUserIdx.equals(userIdx)) {
            response.sendRedirect("archive-localLog.a");
            request.setAttribute("sessionUserIdx", sessionUserIdx);
            return;
        }

        UserDAO userDAO = new UserDAO();
        UserVO user = userDAO.getUserByIdx(userIdx);

        if (user == null) {
            request.setAttribute("message", "사용자 정보를 가져오지 못했습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
            dispatcher.forward(request, response);
            return;
        }

        GuestBookDAO guestBookDAO = new GuestBookDAO();

        int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
        int pageSize = 3;
        int totRecCnt = guestBookDAO.getGuestBookCountByUserIdx(userIdx);
        int totalPages = (int) Math.ceil((double) totRecCnt / pageSize);
        int startIndexNo = (pag - 1) * pageSize;
        int curScrStartNo = totRecCnt - startIndexNo;

        List<GuestBookVO> guestBooks = guestBookDAO.getGuestBooksByUserIdx(userIdx, startIndexNo, pageSize);

        request.setAttribute("guestBooks", guestBooks);
        request.setAttribute("curScrStartNo", curScrStartNo);
        request.setAttribute("totalPages", totalPages);

        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
    }
}