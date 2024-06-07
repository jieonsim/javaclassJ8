package user.findUserInfo;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class FindIdCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/user/findUserInfo/";

		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");

		UserDAO dao = new UserDAO();
		UserVO userVO = dao.findUserIdByNameAndEmail(name, email);

		if (userVO != null) {
			String id = userVO.getId();
			String maskedId = maskId(id);
			String createdAt = userVO.getCreatedAt().toString().substring(0, 10).replace("-", ".");

			request.setAttribute("id", maskedId);
			request.setAttribute("createdAt", createdAt);
			
			viewPage += "foundIdDisplay.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);

		} else {
			request.setAttribute("message", "가입 시 입력하신 회원 정보가 맞는지 다시 한번 확인해 주세요.");
			
			viewPage += "findId.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
	}

	private String maskId(String id) {
		if (id == null || id.length() <= 3) {
			throw new IllegalArgumentException("아이디 마스킹 처리를 위해 아이디는 반드시 세자리 이상이어야 합니다.");
		}
		return id.substring(0, id.length() - 3) + "***";
	}
}
