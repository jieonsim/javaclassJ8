package search;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import localLog.LocalLogDAO;
import localLog.LocalLogVO;

public class SearchResultCommand2 implements SearchInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String query = request.getParameter("query");
		List<LocalLogVO> searchResults = null;

		if (query != null && !query.trim().isEmpty()) {
			LocalLogDAO localLogDAO = new LocalLogDAO();
			//searchResults = localLogDAO.searchLocalLogs(query);
		}

		request.setAttribute("searchResults", searchResults);
        
		String viewPage = "/WEB-INF/search/searchResult.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
