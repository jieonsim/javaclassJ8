package record.guestBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import place.PlaceVO;

public class AddANewPlaceCommand implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		String categoryName = request.getParameter("categoryName");

		if (placeName.isEmpty() || region1DepthName.isEmpty() || region2DepthName.isEmpty() || categoryName.isEmpty()) {
			request.setAttribute("message", "모든 필드를 채워주세요.");
			request.getRequestDispatcher("/WEB-INF/record/record-guestBook.jsp").forward(request, response);
			return;
		}

		PlaceVO placeVO = new PlaceVO(createdBy, placeName, region1DepthName, region2DepthName, categoryName);
		request.getSession().setAttribute("temporaryPlace", placeVO);

		request.setAttribute("message", "공간이 추가되었습니다. 방명록을 작성해주세요.");
		request.getRequestDispatcher("/WEB-INF/record/record-guestBook.jsp").forward(request, response);
	}
}
