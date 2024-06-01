package archive.localLog;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import archive.ArchiveInterface;
import record.localLog.LocalLogDAO;

public class DeleteLocalLogCommand implements ArchiveInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int localLogIdx = Integer.parseInt(request.getParameter("localLogIdx"));
        Integer sessionUserIdx = (Integer) request.getSession().getAttribute("sessionUserIdx");

        if (sessionUserIdx == null) {
            response.getWriter().write("failed");
            return;
        }

        LocalLogDAO localLogDAO = new LocalLogDAO();
        boolean result = localLogDAO.deleteLocalLog(localLogIdx, sessionUserIdx);

        if (result) {
            response.getWriter().write("deleted");
        } else {
            response.getWriter().write("failed");
        }
	}
}
