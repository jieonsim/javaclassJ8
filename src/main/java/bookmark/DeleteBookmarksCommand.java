package bookmark;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteBookmarksCommand implements BookmarkInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] localLogIdxs = request.getParameterValues("localLogIdxs");

		if (localLogIdxs == null || localLogIdxs.length == 0) {
			response.getWriter().write("error");
			return;
		}

		BookmarkDAO bookmarkDAO = new BookmarkDAO();
		boolean success = bookmarkDAO.deleteBookmarks(localLogIdxs);

		if (success) {
			response.getWriter().write("success");
		} else {
			response.getWriter().write("error");
		}
	}
}
