package record.guestBook;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import place.PlaceDAO;
import place.PlaceVO;
import record.common.LoadCategoriesHelper;

public class SubmitGuestBookCommand implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/record/guestBook/record-guestBook.jsp";

		try {
			int userIdx = Integer.parseInt(request.getParameter("sessionUserIdx"));
			String placeName = request.getParameter("placeName");
			String visitDateString = request.getParameter("visitDate");
			String content = request.getParameter("content");
			String[] companionsArray = request.getParameterValues("companions");
			String visibility = request.getParameter("visibility");
			String hostIp = request.getParameter("hostIp");
			
			// String을 java.sql.Date로 변환
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.sql.Date visitDate = new java.sql.Date(sdf.parse(visitDateString).getTime());

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
			if (companionsArray == null || companionsArray.length == 0) {
				request.setAttribute("message", "동반인을 선택해주세요.");
				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
				dispatcher.forward(request, response);
				return;
			}

			// companions 콤마로 구분된 문자열로 변환
			String companions = String.join(",", companionsArray);

			PlaceVO placeVO = (PlaceVO) request.getSession().getAttribute("temporaryPlace");

			int placeIdx;
			if (placeVO != null) {
				PlaceDAO placeDAO = new PlaceDAO();
				placeIdx = placeDAO.savePlace(placeVO);
				request.getSession().removeAttribute("temporaryPlace");
			} else {
				// 기존 장소를 검색해서 선택한 경우
				PlaceDAO placeDAO = new PlaceDAO();
				PlaceVO existingPlace = placeDAO.getPlaceByName(placeName);
				if (existingPlace == null) {
					throw new Exception("선택된 공간 정보를 찾을 수 없습니다.");
				}
				placeIdx = existingPlace.getPlaceIdx();
			}

			GuestBookVO guestBookVO = new GuestBookVO();
			guestBookVO.setUserIdx(userIdx);
			guestBookVO.setPlaceIdx(placeIdx);
			guestBookVO.setVisitDate(visitDate);
			guestBookVO.setContent(content);
			guestBookVO.setCompanions(companions);
			guestBookVO.setVisibility(visibility);
			guestBookVO.setHostIp(hostIp);

			GuestBookDAO guestBookDAO = new GuestBookDAO();
			guestBookDAO.saveGuestBook(guestBookVO);

			request.setAttribute("message", "방명록 작성 완료!");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "방명록 작성 중 오류가 발생했습니다. 다시 시도해 주세요.");
		}

		// 카테고리 데이터를 로드하여 JSP에 전달
		LoadCategoriesHelper.loadCategories(request);

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
