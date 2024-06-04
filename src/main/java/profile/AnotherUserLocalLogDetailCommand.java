package profile;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import localLog.LocalLogDAO;
import localLog.LocalLogVO;

public class AnotherUserLocalLogDetailCommand implements ProfileInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/profile/anotherUserLocalLogDetail.jsp";
		
		int localLogIdx = Integer.parseInt(request.getParameter("localLogIdx"));
        LocalLogDAO localLogDAO = new LocalLogDAO();
        LocalLogVO localLog = localLogDAO.getLocalLogByIdx(localLogIdx);

        if (localLog == null) {
            request.setAttribute("message", "로컬로그 정보를 가져오지 못했습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
            dispatcher.forward(request, response);
            return;
        }
        
        request.setAttribute("localLog", localLog);
        
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
	}
}
