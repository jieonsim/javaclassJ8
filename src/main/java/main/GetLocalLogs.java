package main;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import localLog.LocalLogDAO;
import localLog.LocalLogVO;

@SuppressWarnings("serial")
@WebServlet("/getLocalLogs")
public class GetLocalLogs extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pag = Integer.parseInt(request.getParameter("pag"));
        int pageSize = 10; // 페이지당 보여줄 로컬로그 수
        int startIndexNo = (pag - 1) * pageSize;

        LocalLogDAO localLogDAO = new LocalLogDAO();
        //List<LocalLogVO> localLogs = localLogDAO.getLocalLogs(startIndexNo, pageSize);
        List<LocalLogVO> localLogs = localLogDAO.getRandomLocalLogs(startIndexNo, pageSize);

        request.setAttribute("localLogs", localLogs);

        String viewPage = "/WEB-INF/main/getLocalLogs.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
    }
}