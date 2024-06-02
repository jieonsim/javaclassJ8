package archive.localLog;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
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

@SuppressWarnings("serial")
@WebServlet("/submitUpdateLocalLog.a")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
		maxFileSize = 5 * 1024 * 1024, // 5MB
		maxRequestSize = 50 * 1024 * 1024 // 50MB
)
public class SubmitUpdateLocalLogCommand extends HttpServlet {

	private static final int IMG_WIDTH = 1080;
	private static final int IMG_HEIGHT = 1440;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/archive/localLog/updateLocalLog.jsp";
		//StringBuilder photos = new StringBuilder();

		try {
			String realPath = request.getServletContext().getRealPath("/images/localLog/");
			File uploadDir = new File(realPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			String localLogIdxStr = request.getParameter("localLogIdx");
			String existingPhotosStr = request.getParameter("existingPhotos");
			String removedPhotosStr = request.getParameter("removedPhotos");
			List<String> photoNames = new ArrayList<>();

			if (existingPhotosStr != null && !existingPhotosStr.isEmpty()) {
				for (String photo : existingPhotosStr.split("/")) {
					if (removedPhotosStr == null || !removedPhotosStr.contains(photo)) {
						photoNames.add(photo);
					}
				}
			}

			Collection<Part> fileParts = request.getParts();
			for (Part filePart : fileParts) {
				if (!filePart.getName().equals("photos") || filePart.getSize() == 0) {
					continue;
				}

				String fileName = filePart.getSubmittedFileName();
				InputStream fis = filePart.getInputStream();

				String uid = UUID.randomUUID().toString().substring(0, 4);
				fileName = fileName.substring(0, fileName.lastIndexOf(".")) + "_" + uid + fileName.substring(fileName.lastIndexOf("."));

				File outputFile = new File(uploadDir, fileName);
				cropAndResizeImage(fis, outputFile, IMG_WIDTH, IMG_HEIGHT);

				photoNames.add(fileName);
			}

			String placeIdxStr = request.getParameter("placeIdx");
			String placeName = request.getParameter("placeName");
			String visitDateString = request.getParameter("visitDate");
			String content = request.getParameter("content");
			String community = request.getParameter("community");
			String visibility = request.getParameter("visibility");
			String hostIp = request.getParameter("hostIp");

			if (placeIdxStr == null || placeIdxStr.isEmpty() || placeName == null || placeName.isEmpty()) {
	            request.setAttribute("message", "공간을 추가해주세요.");
	            response.sendRedirect("updateLocalLog.a?localLogIdx=" + localLogIdxStr);
	            return;
	        }

			if (visitDateString == null || visitDateString.isEmpty()) {
				request.setAttribute("message", "방문한 날짜를 선택해주세요.");
				response.sendRedirect("updateLocalLog.a?localLogIdx=" + localLogIdxStr);
				return;
			}

			if (photoNames.isEmpty()) {
				request.setAttribute("message", "사진을 추가해주세요.");
				response.sendRedirect("updateLocalLog.a?localLogIdx=" + localLogIdxStr);
				return;
			}

			int userIdx = Integer.parseInt(request.getParameter("sessionUserIdx"));
			int placeIdx = Integer.parseInt(placeIdxStr);

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date visitDate = new Date(sdf.parse(visitDateString).getTime());

			if (!"public".equals(visibility) && !"private".equals(visibility)) {
				visibility = "public";
			}

			LocalLogVO localLog = new LocalLogVO();
			localLog.setLocalLogIdx(Integer.parseInt(localLogIdxStr));
			localLog.setUserIdx(userIdx);
			localLog.setPlaceIdx(placeIdx);
			localLog.setVisitDate(visitDate);
			localLog.setContent(content);
			localLog.setPhotos(String.join("/", photoNames));
			localLog.setCommunity(community);
			localLog.setVisibility(visibility);
			localLog.setHostIp(hostIp);

			LocalLogDAO localLogDAO = new LocalLogDAO();
			localLogDAO.updateLocalLog(localLog);

			response.sendRedirect("localLogDetail.a?localLogIdx=" + localLogIdxStr);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "로컬로그 수정 중 오류가 발생했습니다. 다시 시도해 주세요.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
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