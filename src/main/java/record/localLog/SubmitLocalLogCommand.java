package record.localLog;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import localLog.LocalLogDAO;
import localLog.LocalLogVO;
import place.PlaceDAO;
import place.PlaceVO;
import record.LoadCategoriesHelper;

@SuppressWarnings("serial")
@WebServlet("/submitLocalLog.ll")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
		maxFileSize = 5 * 1024 * 1024, // 5MB
		maxRequestSize = 50 * 1024 * 1024 // 50MB
)
public class SubmitLocalLogCommand extends HttpServlet {

	private static final int IMG_WIDTH = 1080;
	private static final int IMG_HEIGHT = 1440;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/record/localLog/record-localLog.jsp";
		StringBuilder photos = new StringBuilder();

		try {
			// 파일 저장 경로 설정 및 디렉토리 생성 확인
			String realPath = request.getServletContext().getRealPath("/images/localLog/");
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

				File outputFile = new File(uploadDir, fileName);
				cropAndResizeImage(fis, outputFile, IMG_WIDTH, IMG_HEIGHT);

				photos.append(fileName).append("/");
			}

			// 마지막 슬래시 제거
			if (photos.length() > 0 && photos.charAt(photos.length() - 1) == '/') {
				photos.deleteCharAt(photos.length() - 1);
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

			// visibility 값이 올바른지 확인
			if (!"public".equals(visibility) && !"private".equals(visibility)) {
				visibility = "public"; // 기본 값 설정
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

	private void cropAndResizeImage(InputStream inputStream, File outputFile, int width, int height) throws IOException {
		BufferedImage originalImage = ImageIO.read(inputStream);
		int originalWidth = originalImage.getWidth();
		int originalHeight = originalImage.getHeight();

		// Calculate the target aspect ratio (3:4 in this case)
		double targetAspectRatio = 3.0 / 4.0;

		// Calculate the crop area
		int cropWidth = originalWidth;
		int cropHeight = originalHeight;

		if (originalWidth / (double) originalHeight > targetAspectRatio) {
			cropWidth = (int) (originalHeight * targetAspectRatio);
		} else {
			cropHeight = (int) (originalWidth / targetAspectRatio);
		}

		int cropX = (originalWidth - cropWidth) / 2;
		int cropY = (originalHeight - cropHeight) / 2;

		BufferedImage croppedImage = originalImage.getSubimage(cropX, cropY, cropWidth, cropHeight);

		// Resize the cropped image
		BufferedImage resizedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(croppedImage, 0, 0, width, height, null);
		g.dispose();

		ImageIO.write(resizedImage, "jpg", outputFile); // Write the resized image to the output file
	}
}