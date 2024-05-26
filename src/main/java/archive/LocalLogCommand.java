package archive;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserVO;

public class LocalLogCommand implements ArchiveInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		if (sessionUserIdx == null) {
			request.setAttribute("message", "세션이 만료되었습니다. 로그인 후 이용해주세요.");
			request.setAttribute("url", "login.l");
			return;
		}
		
		UserDAO userDAO = new UserDAO();
		UserVO userVO = userDAO.getUserByIdx(sessionUserIdx);
		
		if (userVO == null) {
			request.setAttribute("message", "사용자 정보를 가져오지 못했습니다.");
			request.setAttribute("url", "archive-localLog.a");
			return;
		}

		request.setAttribute("userVO", userVO);
		request.setAttribute("url", "archive-localLog.a");
	}
}
