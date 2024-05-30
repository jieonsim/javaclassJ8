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

public class SubmitLocalLogCommand2 implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/record/guestBook/record-localLog.jsp";

		try {

			String realPath = request.getServletContext().getRealPath("/images/record/localLog");
			int maxTotalSize = 50 * 1024 * 1024;
			String encoding = "UTF-8";

			MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxTotalSize, encoding, new DefaultFileRenamePolicy());

			Enumeration<?> fileNames = multipartRequest.getFileNames();

			String originalFileName = "";
            String fileSystemName = "";

			while (fileNames.hasMoreElements()) {
				String file = (String) fileNames.nextElement();
				if (multipartRequest.getFilesystemName(file) != null) {
					if (!originalFileName.isEmpty()) {
						originalFileName += "/";
						fileSystemName += "/";
					}
					originalFileName += multipartRequest.getOriginalFileName(file);
					fileSystemName += multipartRequest.getFilesystemName(file);
				}
			}

			int userIdx = Integer.parseInt(multipartRequest.getParameter("sessionUserIdx"));
			String placeName = multipartRequest.getParameter("placeName");
			String visitDateString = multipartRequest.getParameter("visitDate");
			String content = multipartRequest.getParameter("content");
			String community = multipartRequest.getParameter("community");
			String visibility = multipartRequest.getParameter("visibility");
			String hostIp = multipartRequest.getParameter("hostIp");
			String coverPhoto = multipartRequest.getParameter("coverPhoto");

			// Validate required parameters
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
            
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.sql.Date visitDate = new java.sql.Date(sdf.parse(visitDateString).getTime());

			PlaceVO placeVO = (PlaceVO) request.getSession().getAttribute("temporaryPlace");

			int placeIdx;
			if (placeVO != null) {
				PlaceDAO placeDAO = new PlaceDAO();
				placeIdx = placeDAO.savePlace(placeVO);
				request.getSession().removeAttribute("temporaryPlace");
			} else {
				// 기존 장소를 검색해서 선택한 경우
				PlaceDAO placeDAO = new PlaceDAO();
				PlaceVO existingPlace = placeDAO.getPlaceByName(placeName);
				if (existingPlace == null) {
					throw new Exception("선택된 공간 정보를 찾을 수 없습니다.");
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
			localLogVO.setCoverPhoto(coverPhoto);

			LocalLogDAO localLogDAO = new LocalLogDAO();
			localLogDAO.saveLocalLog(localLogVO);

			request.setAttribute("meesage", "로컬로그 업로드 완료!");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "로컬로그 업로드 중 오류가 발생했습니다. 다시 시도해 주세요.");
		}

		// 카테고리 데이터를 로드하여 JSP에 전달
		LoadCategoriesHelper.loadCategories(request);

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);

	}
}
