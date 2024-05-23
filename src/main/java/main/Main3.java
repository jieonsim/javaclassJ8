package main;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.UserDAO;
import user.UserVO;

@SuppressWarnings("serial")
//@WebServlet("/main")
public class Main3 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserVO userVO = null;

        try {
            if (session != null && session.getAttribute("sessionUserIdx") != null) {
                int userIdx = (int) session.getAttribute("sessionUserIdx");

                UserDAO userDAO = new UserDAO();
                userVO = userDAO.getUserByIdx(userIdx);

                request.setAttribute("userVO", userVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 메시지 설정 및 에러 페이지로 포워딩
            request.setAttribute("errorMessage", "An error occurred while processing your request.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/error/error.jsp");
            dispatcher.forward(request, response);
            return;
        }

        String viewPage = "/WEB-INF/main/main.jsp"; 
        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
    }
}
