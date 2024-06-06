package archive.localLog;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import archive.ArchiveInterface;
import localLog.LocalLogDAO;

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
        List<String> photoFilenames = localLogDAO.getLocalLogPhotos(localLogIdx, sessionUserIdx);

        if (photoFilenames != null) {
            String realPath = request.getServletContext().getRealPath("/images/localLog/");

            for (String filename : photoFilenames) {
                File photoFile = new File(realPath, filename);
                if (photoFile.exists()) {
                    photoFile.delete();
                }
            }

            boolean result = localLogDAO.deleteLocalLog(localLogIdx, sessionUserIdx);

            if (result) {
                response.getWriter().write("deleted");
            } else {
                response.getWriter().write("failed");
            }
        } else {
            response.getWriter().write("failed");
        }
    }
}