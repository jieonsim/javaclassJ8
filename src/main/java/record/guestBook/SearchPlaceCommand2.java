package record.guestBook;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import place.PlaceDAO;
import place.PlaceVO;

public class SearchPlaceCommand2 implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String placeName = request.getParameter("placeName");
		
		PlaceDAO placeDAO = new PlaceDAO();
		List<PlaceVO> places = placeDAO.searchPlacesByName(placeName);

		request.setAttribute("places", places);
		
		String viewPage = "/WEB-INF/record/searchAPlaceModal.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
