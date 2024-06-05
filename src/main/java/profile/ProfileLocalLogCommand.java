package profile;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import localLog.LocalLogDAO;
import localLog.LocalLogVO;
import user.UserDAO;
import user.UserVO;

public class ProfileLocalLogCommand implements ProfileInterface {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String viewPage = "/WEB-INF/profile/profile-localLog.jsp";

        HttpSession session = request.getSession();
        Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");
        
        String userIdxStr = request.getParameter("userIdx");
        Integer userIdx = null;
        if (userIdxStr != null) {
            try {
                userIdx = Integer.parseInt(userIdxStr);
            } catch (NumberFormatException e) {
                System.out.println("Invalid userIdx parameter: " + userIdxStr);
                request.setAttribute("message", "유효하지 않은 계정입니다.");
                RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
                dispatcher.forward(request, response);
                return;
            }
        }
        // System.out.println("userIdx : " + userIdx);

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

        LocalLogDAO localLogDAO = new LocalLogDAO();

        int pag = 1; // 처음 접속시 첫 페이지는 1로 설정
        int pageSize = 6;
        int totRecCnt = localLogDAO.getLocalLogCountByUserIdx(userIdx);
        int totalPages = (int) Math.ceil((double) totRecCnt / pageSize);
        int startIndexNo = (pag - 1) * pageSize;
        int curScrStartNo = totRecCnt - startIndexNo;

        List<LocalLogVO> localLogs = localLogDAO.getLocalLogsByUserIdx(userIdx, startIndexNo, pageSize);
        int localLogCount = localLogDAO.getLocalLogCountByUserIdx(userIdx);

        request.setAttribute("user", user);
        request.setAttribute("localLogs", localLogs);
        request.setAttribute("localLogCount", localLogCount);
        request.setAttribute("curScrStartNo", curScrStartNo);
        request.setAttribute("totalPages", totalPages);

        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
    }
}