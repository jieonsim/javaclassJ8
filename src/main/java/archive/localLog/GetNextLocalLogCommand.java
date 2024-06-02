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

public class GetNextLocalLogCommand implements ArchiveInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/archive/localLog/getNextLocalLog.jsp";

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

		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = 6;
		int totRecCnt = localLogDAO.getLocalLogCountByUserIdx(sessionUserIdx);
		int totalPages = (int) Math.ceil((double) totRecCnt / pageSize);
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		List<LocalLogVO> localLogs = localLogDAO.getLocalLogsByUserIdx(sessionUserIdx, startIndexNo, pageSize);

		request.setAttribute("localLogs", localLogs);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("totalPages", totalPages); // 총 페이지 수를 설정

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}