package archive.localLog;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import archive.ArchiveInterface;
import localLog.LocalLogDAO;
import localLog.LocalLogVO;
import place.PlaceDAO;
import place.PlaceVO;
import user.UserDAO;
import user.UserVO;

@WebServlet("/updateLocalLog")
public class UpdateLocalLogCommand extends HttpServlet {

	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/archive/localLog/updateLocalLog.jsp";

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
		UserVO users = userDAO.getUserByIdx(sessionUserIdx);

		if (users == null) {
			request.setAttribute("message", "사용자 정보를 가져오지 못했습니다.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		
		String localLogIdxStr = request.getParameter("localLogIdx");
		if (localLogIdxStr != null) {
			int localLogIdx = Integer.parseInt(localLogIdxStr);
			LocalLogDAO localLogDAO = new LocalLogDAO();
			LocalLogVO localLog = localLogDAO.getLocalLogByIdx(localLogIdx);

			if (localLog != null) {
				request.setAttribute("localLog", localLog);

				PlaceDAO placeDAO = new PlaceDAO();
				PlaceVO place = placeDAO.getPlaceByIdx(localLog.getPlaceIdx());
				if (place != null) {
					request.setAttribute("place", place);
				} else {
					request.setAttribute("message", "공간 정보를 가져올 수 없습니다.");
					viewPage = "archive/localLog/archive-localLog.jsp";
				}
			} else {
				request.setAttribute("message", "로컬로그를 찾을 수 없습니다.");
				viewPage = "/WEB-INF/archive/localLog/archive-localLog.jsp";
			}
		} else {
			request.setAttribute("message", "잘못된 접근입니다.");
			viewPage = "/WEB-INF/archive/localLog/archive-localLog.jsp";
		}
		request.setAttribute("users", users);

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}