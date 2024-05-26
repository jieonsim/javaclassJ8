package bookmark;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.b")
public class BookmarkController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// BookmarkInterface command = null;
		String viewPage = "/WEB-INF/bookmark/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

		if (com.equals("bookmark")) {
			viewPage += "bookmark.jsp";
		} 

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
