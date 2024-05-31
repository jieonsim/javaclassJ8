package record;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import place.PlaceDAO;
import place.PlaceVO;
import record.guestBook.GuestBookInterface;

public class SearchPlaceCommand implements GuestBookInterface {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String placeName = request.getParameter("placeName");
            if (placeName == null || placeName.trim().isEmpty()) {
                throw new ServletException("Invalid place name parameter.");
            }

            PlaceDAO placeDAO = new PlaceDAO();
            List<PlaceVO> places = placeDAO.searchPlacesByName(placeName);

            request.setAttribute("places", places);
            request.getRequestDispatcher("/WEB-INF/record/searchPlaceResults.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("SearchPlaceCommand error: " + e.getMessage());
        }
    }
}
