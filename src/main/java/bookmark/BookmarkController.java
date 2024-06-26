package bookmark;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.b")
public class BookmarkController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BookmarkInterface command = null;

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

		if (com.equals("bookmarkCheck")) {
			command = new BookmarkCheckCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("bookmark")) {
			command = new BookmarkCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("getNextBookmarks")) {
			command = new GetNextBookmarksCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("deleteBookmarks")) {
			command = new DeleteBookmarksCommand();
			command.execute(request, response);
			return;
		}
	}
}
