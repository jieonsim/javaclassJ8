package record;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import place.PlaceVO;

public class AddANewPlaceCommand2 implements RecordInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		int createdBy = Integer.parseInt(request.getParameter("createdBy"));
//		String placeName = request.getParameter("placeName");
//		String region1DepthName = request.getParameter("region1DepthName");
//		String region2DepthName = request.getParameter("region2DepthName");
//		String categoryName = request.getParameter("categoryName");
//
//		// PlaceVO 객체 생성
//		PlaceVO placeVO = new PlaceVO(createdBy, placeName, region1DepthName, region2DepthName, categoryName);
//
//		// PlaceVO 객체를 세션에 저장
//		request.getSession().setAttribute("temporaryPlace", placeVO);
//
//		response.getWriter().write("true");
		try {
			String createdByStr = request.getParameter("createdBy");
			if (createdByStr == null || createdByStr.isEmpty()) {
				response.getWriter().write("false");
				return;
			}
			int createdBy = Integer.parseInt(createdByStr);
			String placeName = request.getParameter("placeName");
			String region1DepthName = request.getParameter("region1DepthName");
			String region2DepthName = request.getParameter("region2DepthName");
			String categoryName = request.getParameter("categoryName");

			// PlaceVO 객체 생성
			PlaceVO placeVO = new PlaceVO(createdBy, placeName, region1DepthName, region2DepthName, categoryName);

			// PlaceVO 객체를 세션에 저장
			request.getSession().setAttribute("temporaryPlace", placeVO);

			response.getWriter().write("true");
		} catch (Exception e) {
			System.out.println("오류 : " + e.getMessage());
			e.printStackTrace();
			response.getWriter().write("false");
		}
	}
}
