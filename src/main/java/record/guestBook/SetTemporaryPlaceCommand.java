package record.guestBook;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import place.PlaceVO;

public class SetTemporaryPlaceCommand implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String placeName = request.getParameter("placeName");
		int placeIdx = Integer.parseInt(request.getParameter("placeIdx"));

		// PlaceVO 객체 생성 및 설정
		PlaceVO placeVO = new PlaceVO();
		placeVO.setPlaceName(placeName);
		placeVO.setPlaceIdx(placeIdx);

		// 세션에 temporaryPlace 설정
		HttpSession session = request.getSession();
		session.setAttribute("temporaryPlace", placeVO);

		response.setStatus(HttpServletResponse.SC_OK);
	}
}
