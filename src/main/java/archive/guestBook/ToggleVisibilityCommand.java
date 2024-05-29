package archive.guestBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import archive.ArchiveInterface;
import record.guestBook.GuestBookDAO;

public class ToggleVisibilityCommand implements ArchiveInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int guestBookIdx = Integer.parseInt(request.getParameter("guestBookIdx"));
        String visibility = request.getParameter("visibility");

        GuestBookDAO dao = new GuestBookDAO();
        boolean success = dao.toggleVisibility(guestBookIdx, visibility);

        try {
            response.getWriter().write(success ? "success" : "failed");
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
}
