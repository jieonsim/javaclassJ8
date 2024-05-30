package record.localLog;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import place.PlaceDAO;
import place.PlaceVO;
import record.common.LoadCategoriesHelper;
import record.guestBook.GuestBookInterface;

public class SubmitLocalLogCommand3 implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/record/localLog/record-localLog.jsp";

		try {
			String realPath = request.getServletContext().getRealPath("/images/record/localLog");
			int maxTotalSize = 50 * 1024 * 1024; // 50MB
			String encoding = "UTF-8";

			MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxTotalSize, encoding, new DefaultFileRenamePolicy());

			Enumeration<?> fileNames = multipartRequest.getFileNames();

			StringBuilder originalFileName = new StringBuilder();
			StringBuilder fileSystemName = new StringBuilder();
			long totalFileSize = 0;
			String coverPhoto = multipartRequest.getParameter("coverPhoto");

			while (fileNames.hasMoreElements()) {
				String file = (String) fileNames.nextElement();
				if (multipartRequest.getFilesystemName(file) != null) {
					if (originalFileName.length() > 0) {
						originalFileName.append("/");
						fileSystemName.append("/");
					}
					originalFileName.append(multipartRequest.getOriginalFileName(file));
					fileSystemName.append(multipartRequest.getFilesystemName(file));

					totalFileSize += multipartRequest.getFile(file).length();

					if (coverPhoto == null || coverPhoto.isEmpty()) {
						coverPhoto = multipartRequest.getFilesystemName(file);
					}
				}
			}

			String placeName = multipartRequest.getParameter("placeName");
			String visitDateString = multipartRequest.getParameter("visitDate");
			String content = multipartRequest.getParameter("content");
			String community = multipartRequest.getParameter("community");
			String visibility = multipartRequest.getParameter("visibility");
			String hostIp = multipartRequest.getParameter("hostIp");

			if (placeName == null || placeName.isEmpty()) {
				request.setAttribute("message", "공간을 추가해주세요.");
				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
				dispatcher.forward(request, response);
				return;
			}

			if (visitDateString == null || visitDateString.isEmpty()) {
				request.setAttribute("message", "방문한 날짜를 선택해주세요.");
				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
				dispatcher.forward(request, response);
				return;
			}

			if (originalFileName.length() == 0) {
				request.setAttribute("message", "사진을 추가해주세요.");
				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
				dispatcher.forward(request, response);
				return;
			}

			int userIdx = Integer.parseInt(multipartRequest.getParameter("sessionUserIdx"));

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.sql.Date visitDate = new java.sql.Date(sdf.parse(visitDateString).getTime());

			PlaceVO placeVO = (PlaceVO) request.getSession().getAttribute("temporaryPlace");

			int placeIdx;
			if (placeVO != null) {
				PlaceDAO placeDAO = new PlaceDAO();
				placeIdx = placeDAO.savePlace(placeVO);
				request.getSession().removeAttribute("temporaryPlace");
			} else {
				PlaceDAO placeDAO = new PlaceDAO();
				PlaceVO existingPlace = placeDAO.getPlaceByName(placeName);
				if (existingPlace == null) {
					throw new Exception("Selected place information not found.");
				}
				placeIdx = existingPlace.getPlaceIdx();
			}

			LocalLogVO localLogVO = new LocalLogVO();
			localLogVO.setUserIdx(userIdx);
			localLogVO.setPlaceIdx(placeIdx);
			localLogVO.setVisitDate(visitDate);
			localLogVO.setContent(content);
			localLogVO.setCommunity(community);
			localLogVO.setVisibility(visibility);
			localLogVO.setHostIp(hostIp);
			localLogVO.setFileName(originalFileName.toString());
			localLogVO.setFileSystemName(fileSystemName.toString());
			localLogVO.setCoverPhoto(coverPhoto);
			localLogVO.setFileSize(totalFileSize);

			LocalLogDAO localLogDAO = new LocalLogDAO();
			localLogDAO.saveLocalLog(localLogVO);

			request.setAttribute("message", "로컬로그 업로드 완료!");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "로컬로그 업로드 중 오류가 발생했습니다. 다시 시도해 주세요.");
		}

		LoadCategoriesHelper.loadCategories(request);

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
