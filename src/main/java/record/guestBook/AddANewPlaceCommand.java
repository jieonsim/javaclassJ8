package record.guestBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import place.PlaceVO;

public class AddANewPlaceCommand implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 유효성 검사 수행
		String createdByStr = request.getParameter("createdBy");
		if (createdByStr == null || createdByStr.isEmpty()) {
			request.setAttribute("message", "유효하지 않은 유저입니다.");
			request.getRequestDispatcher("/WEB-INF/record/record-guestBook.jsp").forward(request, response);
			return;
		}

		int createdBy = Integer.parseInt(createdByStr);
		String placeName = request.getParameter("placeName");
		String region1DepthName = request.getParameter("region1DepthName");
		String region2DepthName = request.getParameter("region2DepthName");
		String categoryIdxStr = request.getParameter("categoryIdx");

		if (placeName == null || placeName.isEmpty() || region1DepthName == null || region1DepthName.isEmpty() || region2DepthName == null || region2DepthName.isEmpty() || categoryIdxStr == null || categoryIdxStr.isEmpty()) {
			request.setAttribute("message", "모든 필드를 입력 및 선택해주세요.");
			request.getRequestDispatcher("/WEB-INF/record/record-guestBook.jsp").forward(request, response);
			return;
		}
		int categoryIdx = Integer.parseInt(categoryIdxStr);

		// PlaceVO 객체 생성
		PlaceVO placeVO = new PlaceVO(createdBy, placeName, region1DepthName, region2DepthName, categoryIdx);

		// PlaceVO 객체를 세션에 저장
		request.getSession().setAttribute("temporaryPlace", placeVO);
		
		// 카테고리 데이터를 로드하여 JSP에 전달
        LoadCategoriesHelper.loadCategories(request);

		//request.setAttribute("message", "공간이 추가되었습니다. 방명록을 작성해주세요.");
		request.getRequestDispatcher("/WEB-INF/record/record-guestBook.jsp").forward(request, response);
	}
}
