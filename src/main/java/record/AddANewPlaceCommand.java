package record;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import place.PlaceVO;

public class AddANewPlaceCommand implements RecordInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int createdBy = Integer.parseInt(request.getParameter("createdBy"));
		String placeName = request.getParameter("placeName");
		String region1DepthName = request.getParameter("region1DepthName");
		String region2DepthName = request.getParameter("region2DepthName");
		String categoryName = request.getParameter("categoryName");

		// PlaceVO 객체 생성
		PlaceVO placeVO = new PlaceVO(createdBy, placeName, region1DepthName, region2DepthName, categoryName);

		// PlaceVO 객체를 세션에 저장
		request.getSession().setAttribute("temporaryPlace", placeVO);

		response.getWriter().write("true");
	}
}
