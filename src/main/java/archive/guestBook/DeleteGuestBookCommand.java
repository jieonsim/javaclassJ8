package archive.guestBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import archive.ArchiveInterface;
import guestBook.GuestBookDAO;

public class DeleteGuestBookCommand implements ArchiveInterface {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String guestBookIdxStr = request.getParameter("guestBookIdx");
		if (guestBookIdxStr == null || guestBookIdxStr.isEmpty()) {
			response.getWriter().write("failed");
			return;
		}

		int guestBookIdx;
		try {
			guestBookIdx = Integer.parseInt(guestBookIdxStr);
		} catch (NumberFormatException e) {
			response.getWriter().write("failed");
			return;
		}

		Integer sessionUserIdx = (Integer) request.getSession().getAttribute("sessionUserIdx");

		if (sessionUserIdx == null) {
			response.getWriter().write("failed");
			return;
		}

		GuestBookDAO guestBookDAO = new GuestBookDAO();
		boolean result = guestBookDAO.deleteGuestBook(guestBookIdx, sessionUserIdx);

		if (result) {
			response.getWriter().write("deleted");
		} else {
			response.getWriter().write("failed");
		}
//        int guestBookIdx = Integer.parseInt(request.getParameter("guestBookIdx"));
//        Integer sessionUserIdx = (Integer) request.getSession().getAttribute("sessionUserIdx");
//
//        if (sessionUserIdx == null) {
//            response.getWriter().write("failed");
//            return;
//        }
//
//        GuestBookDAO guestBookDAO = new GuestBookDAO();
//        boolean result = guestBookDAO.deleteGuestBook(guestBookIdx, sessionUserIdx);
//
//        if (result) {
//            response.getWriter().write("deleted");
//        } else {
//            response.getWriter().write("failed");
//        }
	}
}
