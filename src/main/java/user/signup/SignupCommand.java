package user.signup;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;
import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class SignupCommand implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id") == null ? "" : request.getParameter("id");
		String password = request.getParameter("password") == null ? "" : request.getParameter("password");
		String nickname = request.getParameter("nickname") == null ? "" : request.getParameter("nickname");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		
		
		// 비밀번호 암호화
		String salt = UUID.randomUUID().toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		password = security.encryptSHA256(salt + password);
		
		password = salt + password;
		
		// 저장
		UserVO vo = new UserVO();
		
		vo.setId(id);
		vo.setPassword(password);
		vo.setNickname(nickname);
		vo.setName(name);
		vo.setEmail(email);

		UserDAO dao = new UserDAO();
		
		int result = dao.insertUser(vo);
		if(result != 0) {
		} else {
		}
	}
}