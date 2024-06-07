package main;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import localLog.LocalLogDAO;
import localLog.LocalLogVO;
import user.UserDAO;
import user.UserVO;

@SuppressWarnings("serial")
@WebServlet("/main")
public class Main extends HttpServlet {
//	private DataSource dataSource;
//
//    @Override
//    public void init() throws ServletException {
//        try {
//            InitialContext ctx = new InitialContext();
//            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/YourDataSource");
//        } catch (NamingException e) {
//            throw new ServletException(e);
//        }
//    }

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if ("logout".equals(action)) {
			handleLogout(request, response);
		} else {
			handleMainPage(request, response);
		}
	}

	private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session != null) {
			session.invalidate();
		}

		response.sendRedirect(request.getContextPath() + "/main");
	}

	private void handleMainPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserVO userVO = null;

        if (session != null && session.getAttribute("sessionUserIdx") != null) {
            int userIdx = (int) session.getAttribute("sessionUserIdx");

            UserDAO userDAO = new UserDAO();
            userVO = userDAO.getUserByIdx(userIdx);

            request.setAttribute("userVO", userVO);
        }

        LocalLogDAO localLogDAO = new LocalLogDAO();
        try {
            int pageSize = 10;
            int totalPages = (int) Math.ceil((double) localLogDAO.getLocalLogCount() / pageSize);
            List<LocalLogVO> localLogs = localLogDAO.getRandomLocalLogs(0, pageSize);

            request.setAttribute("localLogs", localLogs);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("curScrStartNo", localLogDAO.getLocalLogCount());

            String viewPage = "/WEB-INF/main/main.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
            dispatcher.forward(request, response);
        } finally {
            localLogDAO.rsClose(); // 리소스 안전하게 닫기
        }
	}
}
//	private void handleMainPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		HttpSession session = request.getSession(false);
//		UserVO userVO = null;
//
//		if (session != null && session.getAttribute("sessionUserIdx") != null) {
//			int userIdx = (int) session.getAttribute("sessionUserIdx");
//
//			UserDAO userDAO = new UserDAO();
//			userVO = userDAO.getUserByIdx(userIdx);
//
//			request.setAttribute("userVO", userVO);
//		}
//
//		LocalLogDAO localLogDAO = new LocalLogDAO();
//		int pageSize = 10;
//		int totalPages = (int) Math.ceil((double) localLogDAO.getLocalLogCount() / pageSize);
//		List<LocalLogVO> localLogs = localLogDAO.getRandomLocalLogs(0, pageSize);
//        
//		request.setAttribute("localLogs", localLogs);
//		request.setAttribute("totalPages", totalPages);
//		request.setAttribute("curScrStartNo", localLogDAO.getLocalLogCount());
//
//		String viewPage = "/WEB-INF/main/main.jsp";
//		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
//		dispatcher.forward(request, response);
//	}
