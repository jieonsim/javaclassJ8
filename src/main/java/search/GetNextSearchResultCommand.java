package search;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import localLog.LocalLogDAO;
import localLog.LocalLogVO;

public class GetNextSearchResultCommand implements SearchInterface {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String viewPage = "/WEB-INF/search/getNextSearchResult.jsp";
    	
         String query = request.getParameter("query");
         String categoryIdxParam = request.getParameter("categoryIdx");
         String[] selectedCategories = categoryIdxParam != null ? categoryIdxParam.split(",") : null;

         if (query == null || query.trim().isEmpty()) {
             return;
         }

         LocalLogDAO localLogDAO = new LocalLogDAO();

         int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
         int pageSize = 9; // 테스트를 위해 페이지 크기를 3으로 설정
         int startIndexNo = (pag - 1) * pageSize;

         List<LocalLogVO> searchResults = localLogDAO.searchLocalLogs(query, startIndexNo, pageSize, selectedCategories);
         int totalPages = (int) Math.ceil((double) localLogDAO.getLocalLogCountByQuery(query, selectedCategories) / pageSize);

         request.setAttribute("searchResults", searchResults);
         request.setAttribute("totalPages", totalPages);

        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
    }
}