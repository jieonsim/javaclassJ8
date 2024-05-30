package record.localLog;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import place.PlaceDAO;
import place.PlaceVO;
import record.common.LoadCategoriesHelper;
import record.guestBook.GuestBookInterface;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 50 * 1024 * 1024)
public class SubmitLocalLogCommand2 implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/record/localLog/record-localLog.jsp";
		StringBuilder photos = new StringBuilder();

		try {
			// 파일 저장 경로 설정 및 디렉토리 생성 확인
            String realPath = request.getServletContext().getRealPath("/images/record/localLog/");
            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // 디렉토리가 없으면 생성
            }
			Collection<Part> fileParts = request.getParts();

			for (Part filePart : fileParts) {
				if (!filePart.getName().equals("photos"))
					continue;
				if (filePart.getSize() == 0)
					continue;

				String fileName = filePart.getSubmittedFileName();
				InputStream fis = filePart.getInputStream();

				String uid = UUID.randomUUID().toString().substring(0, 4);
				fileName = fileName.substring(0, fileName.lastIndexOf(".")) + "_" + uid + fileName.substring(fileName.lastIndexOf("."));

				FileOutputStream fos = new FileOutputStream(realPath + fileName);

				byte[] buffer = new byte[2048];
				int size = 0;
				while ((size = fis.read(buffer)) != -1) {
					fos.write(buffer, 0, size);
				}
				fos.close();
				fis.close();

				photos.append(fileName).append(",");
			}

			String placeName = request.getParameter("placeName");
			String visitDateString = request.getParameter("visitDate");
			String content = request.getParameter("content");
			String community = request.getParameter("community");
			String visibility = request.getParameter("visibility");
			String hostIp = request.getParameter("hostIp");

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

			if (photos.length() == 0) {
				request.setAttribute("message", "사진을 추가해주세요.");
				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
				dispatcher.forward(request, response);
				return;
			}

			int userIdx = Integer.parseInt(request.getParameter("sessionUserIdx"));

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
			localLogVO.setPhotos(photos.toString());
			localLogVO.setCommunity(community);
			localLogVO.setVisibility(visibility);
			localLogVO.setHostIp(hostIp);

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
