package record.guestBook;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import place.PlaceDAO;
import place.PlaceVO;

public class GetPlaceDetailsCommand implements GuestBookInterface {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int placeIdx = Integer.parseInt(request.getParameter("placeIdx"));
            PlaceDAO placeDAO = new PlaceDAO();
            PlaceVO placeVO = placeDAO.getPlaceByIdx(placeIdx);

            if (placeVO != null) {
                request.setAttribute("place", placeVO);
                request.getRequestDispatcher("/WEB-INF/record/searchPlaceResults.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Place not found");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid place index");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving place details");
        }
    }
}