package user.updateProfile;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SecurityUtil;
import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class UpdateProfileCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/user/updateProfile/updateProfile.jsp";

		String realPath = request.getServletContext().getRealPath("/images/profileImage/");
		int maxSize = 1024 * 1024 * 2;
		String encoding = "UTF-8";

		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());

		String userIdxStr = multipartRequest.getParameter("userIdx");
		int userIdx;
		try {
			userIdx = Integer.parseInt(userIdxStr);
		} catch (NumberFormatException e) {
			request.setAttribute("message", "잘못된 userIdx입니다.");
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
			return;
		}

		String newPassword = multipartRequest.getParameter("newPassword");
		String nickname = multipartRequest.getParameter("nickname");
		String name = multipartRequest.getParameter("name");
		String email = multipartRequest.getParameter("email");
		String introduction = multipartRequest.getParameter("introduction");
		String profileImage = multipartRequest.getFilesystemName("photo-upload");

		UserDAO userDAO = new UserDAO();
		UserVO userVO = userDAO.getUserByIdx(userIdx); // 기존 사용자 정보를 가져옴

		// 비밀번호 암호화 및 설정
		if (newPassword != null && !newPassword.trim().isEmpty()) {
			String salt = UUID.randomUUID().toString().substring(0, 8);
			SecurityUtil security = new SecurityUtil();
			String hashedPassword = security.encryptSHA256(salt + newPassword);
			String storedPassword = salt + hashedPassword;
			userVO.setPassword(storedPassword);
		}

		if (nickname != null && !nickname.trim().isEmpty()) {
			userVO.setNickname(nickname);
		}
		if (name != null && !name.trim().isEmpty()) {
			userVO.setName(name);
		}
		if (email != null && !email.trim().isEmpty()) {
			userVO.setEmail(email);
		}
		if (introduction != null && !introduction.trim().isEmpty()) {
			userVO.setIntroduction(introduction);
		}
		if (profileImage != null && !profileImage.trim().isEmpty()) {
			userVO.setProfileImage(profileImage);
		}

		int result = userDAO.updateProfile(userVO);
		request.setAttribute("userVO", userVO);
		
		// 세션 처리
		HttpSession session = request.getSession();
		session.setAttribute("sessionUserIdx", userVO.getUserIdx());
		session.setAttribute("sessionId", userVO.getId());
		session.setAttribute("sessionNickname", userVO.getNickname());
		session.setAttribute("sessionName", userVO.getName());
		session.setAttribute("sessionEmail", userVO.getEmail());
		session.setAttribute("sessionRole", userVO.getRole());
		session.setAttribute("sessionIntroduction", userVO.getIntroduction());
		session.setAttribute("sessionProfileImage", userVO.getProfileImage());
		session.setAttribute("sessionVisibility", userVO.getVisibility());

		if (result != 0) {
			request.setAttribute("message", "프로필 수정이 완료되었습니다.");
		} else {
			request.setAttribute("message", "프로필 수정이 정상적으로 완료되지 않았습니다. 다시 시도해주세요.");
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}