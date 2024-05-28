package record.guestBook;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import place.PlaceDAO;
import place.PlaceVO;

public class SubmitGuestBookCommand3 implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/record/record-guestBook.jsp";

		try {
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

			// 임시로 세션에 저장된 장소 정보 가져오기
			HttpSession session = request.getSession();
			PlaceVO placeVO = (PlaceVO) session.getAttribute("temporaryPlace");

			if (placeVO != null) {
				PlaceDAO placeDAO = new PlaceDAO();
				// 장소 정보를 데이터베이스에 저장
				int placeIdx = placeDAO.savePlace(placeVO);

				// 저장 후 세션에서 임시 장소 정보 제거
				session.removeAttribute("temporaryPlace");

				// 게스트북 정보 저장
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
			}

			request.setAttribute("message", "방명록 작성완료! 아카이브에서 내가 남긴 방명록을 한눈에 확인할 수 있어요.");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "방명록 작성 중 오류가 발생했습니다. 다시 시도해 주세요.");
		}

		// 페이지를 새로고침하여 중복된 요청을 방지
		//response.sendRedirect("record-guestBook.g");
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
