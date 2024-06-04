package user.findUserInfo;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserInterface;

public class FindPasswordCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/user/findUserInfo/";

		String id = request.getParameter("id") == null ? "" : request.getParameter("id");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");

		UserDAO dao = new UserDAO();
		boolean userExists = dao.checkUserByIdAndEmail(id, email);

		if (userExists) {
			request.setAttribute("id", id);
			viewPage += "resetPassword.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		} else {
			request.setAttribute("message", "가입 시 입력하신 회원 정보가 맞는지 다시 한번 확인해 주세요.");
			viewPage += "findPassword.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
	}
}
