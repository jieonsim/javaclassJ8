package record.guestBook;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import place.PlaceDAO;
import place.PlaceVO;

public class SubmitGuestBookCommand implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/record/record-guestBook.jsp";

		int userIdx = Integer.parseInt(request.getParameter("sessionUserIdx"));
		String placeName = request.getParameter("placeName");
		String visitDate = request.getParameter("visitDate");
		String content = request.getParameter("content");
		String companions = request.getParameter("companions");
		String visibility = request.getParameter("visibility");
		String hostIp = request.getParameter("hostIp");

		if (placeName.isEmpty()) {
			request.setAttribute("message", "공간을 추가해주세요.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}
		if (visitDate.isEmpty()) {
			request.setAttribute("message", "방문한 날짜를 선택해주세요.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		PlaceVO placeVO = (PlaceVO) request.getSession().getAttribute("temporaryPlace");

		if (placeVO != null) {
			PlaceDAO placeDAO = new PlaceDAO();
			int placeIdx = placeDAO.savePlace(placeVO);
			request.getSession().removeAttribute("temporaryPlace");

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

			request.setAttribute("message", "방명록 작성완료! 아카이브에서 내가 남긴 방명록을 한눈에 확인할 수 있어요.");
		} else {
			request.setAttribute("message", "방명록 작성 중 오류가 발생했습니다. 다시 시도해 주세요.");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
