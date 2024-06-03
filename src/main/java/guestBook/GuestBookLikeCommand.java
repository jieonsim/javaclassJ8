package guestBook;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserVO;

public class GuestBookLikeCommand implements GuestBookInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer sessionUserIdx = (Integer) session.getAttribute("sessionUserIdx");

		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");

		System.out.println("GuestBookLikeCommand 호출됨");

		if (sessionUserIdx == null) {
			out.print("로그인 후 이용하실 수 있습니다.");
			System.out.println("사용자 세션 없음");
			return;
		}

		String guestBookIdxStr = request.getParameter("guestBookIdx");

		if (guestBookIdxStr == null || guestBookIdxStr.isEmpty()) {
			out.print("invalid_request");
			System.out.println("잘못된 요청: guestBookIdx 없음");
			return;
		}

		System.out.println("guestBookIdxStr : " + guestBookIdxStr);

		int guestBookIdx;
		try {
			guestBookIdx = Integer.parseInt(guestBookIdxStr);
			System.out.println("guestBookIdx 파싱 성공: " + guestBookIdx);
		} catch (NumberFormatException e) {
			out.print("invalid_number_format");
			System.out.println("숫자 형식 오류: " + e.getMessage());
			return;
		}

		System.out.println("guestBookIdx : " + guestBookIdx);

		UserDAO userDAO = new UserDAO();
		UserVO user = userDAO.getUserByIdx(sessionUserIdx);

		if (user == null) {
			out.print("user_not_found");
			System.out.println("사용자 찾을 수 없음");
			return;
		}

		GuestBookDAO guestBookDAO = new GuestBookDAO();
		boolean isLiked = guestBookDAO.checkIfLiked(sessionUserIdx, guestBookIdx);

		if (isLiked) {
			guestBookDAO.removeLike(sessionUserIdx, guestBookIdx);
			int likeCount = guestBookDAO.getLikeCount(guestBookIdx);
			out.print("unliked " + likeCount);
			System.out.println("좋아요 취소: " + likeCount);
		} else {
			guestBookDAO.addLike(sessionUserIdx, guestBookIdx);
			int likeCount = guestBookDAO.getLikeCount(guestBookIdx);
			out.print("liked " + likeCount);
			System.out.println("좋아요 추가: " + likeCount);
		}
	}
}