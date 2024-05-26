package archive;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.a")
public class ArchiveController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArchiveInterface command = null;
		String viewPage = "/WEB-INF/archive/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

		if (com.equals("archive-localLog")) {
			command = new LocalLogCommand();
			command.execute(request, response);
			viewPage += "archive-localLog.jsp";
		} else if (com.equals("archive-guestBook")) {
			command = new GuestBookCommand();
			command.execute(request, response);
			viewPage += "archive-guestBook.jsp";
		} else if (com.equals("archive-curation")) {
			command = new CurationCommand();
			command.execute(request, response);
			viewPage += "archive-curation.jsp";
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
