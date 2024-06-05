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
    	
    	 System.out.println("GetNextSearchResultCommand executed"); // 디버깅 로그 추가

         String query = request.getParameter("query");
         String categoryIdxParam = request.getParameter("categoryIdx");
         String[] selectedCategories = categoryIdxParam != null ? categoryIdxParam.split(",") : null;

         if (query == null || query.trim().isEmpty()) {
             System.out.println("Query is null or empty"); // 디버깅 로그 추가
             return;
         }

         LocalLogDAO localLogDAO = new LocalLogDAO();

         int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
         int pageSize = 9; // 테스트를 위해 페이지 크기를 3으로 설정
         int startIndexNo = (pag - 1) * pageSize;

         // 디버깅 로그 추가
         System.out.println("Search query: " + query);
         System.out.println("Page number: " + pag);
         System.out.println("Start index number: " + startIndexNo);

         List<LocalLogVO> searchResults = localLogDAO.searchLocalLogs(query, startIndexNo, pageSize, selectedCategories);
         int totalPages = (int) Math.ceil((double) localLogDAO.getLocalLogCountByQuery(query, selectedCategories) / pageSize);

         request.setAttribute("searchResults", searchResults);
         request.setAttribute("totalPages", totalPages);

        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
    }
}