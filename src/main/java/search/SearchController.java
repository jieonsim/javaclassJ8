package search;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.search")
public class SearchController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SearchInterface command = null;
		String viewPage = "/WEB-INF/search/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));
		
		 System.out.println("Requested URI: " + com);

		if (com.equals("searchResult")) {
			command = new SearchResultCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("getNextSearchResult")) {
			command = new GetNextSearchResultCommand();
			command.execute(request, response);
			return;
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
