package user.updateProfile;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class UpdateProfileCommand2 implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/user/updateProfile/updateProfile.jsp";

		String realPath = request.getServletContext().getRealPath("/images/profileImage/");
		int maxSize = 1024 * 1024 * 2;
		String encoding = "UTF-8";

		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String id = multipartRequest.getParameter("id");
		String newPassword = multipartRequest.getParameter("newPassword");
		String nickname = multipartRequest.getParameter("nickname");
		String name = multipartRequest.getParameter("name");
		String email = multipartRequest.getParameter("email");
		String introduction = multipartRequest.getParameter("introduction");
		String profileImage = multipartRequest.getFilesystemName("photo-upload");

		UserDAO userDAO = new UserDAO();
		UserVO userVO = new UserVO();

		userVO.setId(id);
		userVO.setPassword(newPassword);
		userVO.setNickname(nickname);
		userVO.setName(name);
		userVO.setEmail(email);
		userVO.setIntroduction(introduction);
		userVO.setProfileImage(profileImage);

		int result = userDAO.updateProfile(userVO);

		if (result != 0) {
			request.setAttribute("message", "프로필 수정이 완료되었습니다.");
			response.sendRedirect("updateProfile.u");
		} else {
			request.setAttribute("message", "프로필 수정이 정상적으로 완료되지 않았습니다. 다시 시도해주세요.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
	}
}
