package search;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import localLog.LocalLogDAO;
import localLog.LocalLogVO;

public class SearchResultCommand implements SearchInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/search/searchResult.jsp";
        String query = request.getParameter("query");

        if (query == null || query.trim().isEmpty()) {
            request.setAttribute("message", "검색어를 입력해주세요.");
            RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
            dispatcher.forward(request, response);
            return;
        }

        LocalLogDAO localLogDAO = new LocalLogDAO();

        int pag = 1; // 처음 접속시 첫 페이지는 1로 설정
        int pageSize = 9; // 페이지당 표시할 레코드 수
        int totRecCnt = localLogDAO.getLocalLogCountByQuery(query);
        int totalPages = (int) Math.ceil((double) totRecCnt / pageSize);
        int startIndexNo = (pag - 1) * pageSize;
        int curScrStartNo = totRecCnt - startIndexNo;

        System.out.println("Search query: " + query);
        System.out.println("Total record count: " + totRecCnt);
        System.out.println("Total pages: " + totalPages);
        System.out.println("Start index number: " + startIndexNo);
        System.out.println("Current screen start number: " + curScrStartNo);
        
        List<LocalLogVO> searchResults = localLogDAO.searchLocalLogs(query, startIndexNo, pageSize);

        request.setAttribute("searchResults", searchResults);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("curScrStartNo", curScrStartNo);
        request.setAttribute("query", query);

        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
	}
}