package archive.localLog;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import archive.ArchiveInterface;
import localLog.LocalLogDAO;
import localLog.LocalLogVO;
import user.UserDAO;
import user.UserVO;

public class ArchiveLocalLogCommand implements ArchiveInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/archive/localLog/archive-localLog.jsp";

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

		LocalLogDAO localLogDAO = new LocalLogDAO();

		int pag = 1; // 처음 접속시 첫 페이지는 1로 설정
		int pageSize = 6;
		int totRecCnt = localLogDAO.getLocalLogCountByUserIdx(sessionUserIdx);
		int totalPages = (int) Math.ceil((double) totRecCnt / pageSize);
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		List<LocalLogVO> localLogs = localLogDAO.getLocalLogsByUserIdx(sessionUserIdx, startIndexNo, pageSize);
		int localLogCount = localLogDAO.getLocalLogCountByUserIdx(sessionUserIdx);

		request.setAttribute("users", users);
		request.setAttribute("localLogs", localLogs);
		request.setAttribute("localLogCount", localLogCount);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("totalPages", totalPages);

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}