package user.leave;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserInterface;

public class TryToLeaveCommand implements UserInterface {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String viewPage = "/WEB-INF/user/leave/leave.jsp";

        HttpSession session = request.getSession();
        Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

        if (sessionUserIdx == null) {
            request.setAttribute("message", "로그인 후 이용하실 수 있습니다.");
            viewPage = "/WEB-INF/user/login/login.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
            dispatcher.forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        boolean isDeleted = userDAO.deleteUserContentAndAccount(sessionUserIdx);

        if (isDeleted) {
            session.invalidate(); // 세션 무효화
            request.setAttribute("message", "탈퇴가 완료되었습니다.");
            viewPage = "/WEB-INF/user/login/login.jsp";
        } else {
            request.setAttribute("message", "탈퇴 처리 중 오류가 발생했습니다.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
    }
}