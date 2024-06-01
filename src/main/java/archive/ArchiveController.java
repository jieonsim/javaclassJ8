package archive;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import archive.curation.ArchiveCurationCommand;
import archive.guestBook.ArchiveGuestBookCommand;
import archive.guestBook.DeleteGuestBookCommand;
import archive.guestBook.GetNextGuestBookCommand;
import archive.guestBook.ToggleVisibilityCommand;
import archive.localLog.ArchiveLocalLogCommand;
import archive.localLog.DeleteLocalLogCommand;
import archive.localLog.GetNextLocalLogCommand;
import archive.localLog.LocalLogDetailCommand;
import archive.localLog.UpdateLocalLogCommand;

@SuppressWarnings("serial")
@WebServlet("*.a")
public class ArchiveController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArchiveInterface command = null;
		String viewPage = "/WEB-INF/archive/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

		if (com.equals("archive-localLog")) {
			command = new ArchiveLocalLogCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("archive-guestBook")) {
			command = new ArchiveGuestBookCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("archive-curation")) {
			command = new ArchiveCurationCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("deleteGuestBook")) {
			command = new DeleteGuestBookCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("toggleVisibility")) {
			command = new ToggleVisibilityCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("localLogDetail")) {
			command = new LocalLogDetailCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("getNextLocalLog")) {
			command = new GetNextLocalLogCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("getNextGuestBook")) {
			command = new GetNextGuestBookCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("deleteLocalLog")) {
			command = new DeleteLocalLogCommand();
			command.execute(request, response);
			return;
		} else if (com.equals("updateLocalLog")) {
			command = new UpdateLocalLogCommand();
			command.execute(request, response);
			return;
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
