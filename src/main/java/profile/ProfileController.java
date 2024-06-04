package profile;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.p")
public class ProfileController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProfileInterface command = null;
		String viewPage = "/WEB-INF/profile/";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

		if (com.equals("profileLocalLog")) {
			command = new ProfileLocalLogCommand();
			command.execute(request, response);
			return;
		} else if(com.equals("getNextLocalLog")) {
			command = new GetNextLocalLogCommand();
			command.execute(request, response);
			return;
		} else if(com.equals("profileGuestbook")) {
			command = new ProfileGuestbookCommand();
			command.execute(request, response);
			return;
		} else if(com.equals("getNextGuestBook")) {
			command = new GetNextGuestBookCommand();
			command.execute(request, response);
			return;
		} else if(com.equals("anotherUserLocalLogDetail")) {
			command = new AnotherUserLocalLogDetailCommand();
			command.execute(request, response);
			return;
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
