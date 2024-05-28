package record.guestBook;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import place.PlaceDAO;
import place.PlaceVO;

public class SubmitGuestBookCommand2 implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/record/record-guestBook.jsp";

		// 게스트북 정보를 처리하고 저장
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
		PlaceVO placeVO = (PlaceVO) request.getSession().getAttribute("temporaryPlace");

		if (placeVO != null) {
			PlaceDAO placeDAO = new PlaceDAO();
			
			// 장소 정보를 데이터베이스에 저장
			int placeIdx = placeDAO.savePlace(placeVO);

			// 저장 후 세션에서 임시 장소 정보 제거
			request.getSession().removeAttribute("temporaryPlace");

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
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
//		try {
//			// userIdx 파라미터 검증
//			String userIdxStr = request.getParameter("sessionUserIdx");
//			if (userIdxStr == null || userIdxStr.isEmpty()) {
//				request.setAttribute("message", "유효하지 않은 사용자입니다.");
//				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
//				dispatcher.forward(request, response);
//				return;
//			}
//			int userIdx = Integer.parseInt(userIdxStr);
//
//			String placeName = request.getParameter("placeName");
//			String visitDate = request.getParameter("visitDate");
//			String content = request.getParameter("content");
//			String companions = request.getParameter("companions");
//			String visibility = request.getParameter("visibility");
//			String hostIp = request.getParameter("hostIp");
//
//			// 디버깅용 로그
//			System.out.println("userIdx: " + userIdx);
//			System.out.println("placeName: " + placeName);
//			System.out.println("visitDate: " + visitDate);
//			System.out.println("content: " + content);
//			System.out.println("companions: " + companions);
//			System.out.println("visibility: " + visibility); // visibility 값 확인
//			System.out.println("hostIp: " + hostIp);
//
//			if (placeName.isEmpty()) {
//				request.setAttribute("message", "공간을 추가해주세요.");
//				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
//				dispatcher.forward(request, response);
//				return;
//			}
//			if (visitDate.isEmpty()) {
//				request.setAttribute("message", "방문한 날짜를 선택해주세요.");
//				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
//				dispatcher.forward(request, response);
//				return;
//			}
//
//			// 임시로 세션에 저장된 장소 정보 가져오기
//			PlaceVO placeVO = (PlaceVO) request.getSession().getAttribute("temporaryPlace");
//
//			if (placeVO != null) {
//				PlaceDAO placeDAO = new PlaceDAO();
//				// 장소 정보를 데이터베이스에 저장
//				placeVO.setCreatedBy(userIdx); // createdBy를 설정
//				int placeIdx = placeDAO.savePlace(placeVO);
//
//				// 저장 후 세션에서 임시 장소 정보 제거
//				request.getSession().removeAttribute("temporaryPlace");
//
//				// 게스트북 정보 저장
//				GuestBookVO guestBookVO = new GuestBookVO();
//				guestBookVO.setUserIdx(userIdx);
//				guestBookVO.setPlaceIdx(placeIdx);
//				guestBookVO.setVisitDate(visitDate);
//				guestBookVO.setContent(content);
//				guestBookVO.setCompanions(companions);
//				guestBookVO.setVisibility(visibility);
//				guestBookVO.setHostIp(hostIp);
//
//				GuestBookDAO guestBookDAO = new GuestBookDAO();
//				guestBookDAO.saveGuestBook(guestBookVO);
//
//				// 게스트북 작성 완료 후 메시지 설정
//				request.setAttribute("message", "방명록 작성완료! 아카이브에서 내가 남긴 방명록을 한눈에 확인할 수 있어요.");
//			} else {
//				// 장소 정보가 세션에 없을 경우 에러 메시지 설정
//				request.setAttribute("message", "장소 정보가 유효하지 않습니다. 다시 시도해 주세요.");
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			// 예외 발생 시 에러 메시지 설정
//			request.setAttribute("message", "방명록 작성 중 오류가 발생했습니다. 다시 시도해 주세요.");
//		}
//
//		// 결과 페이지로 이동
//		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
//		dispatcher.forward(request, response);
	}
}
