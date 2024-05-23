package user.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserInterface;
import user.UserVO;

public class Welcome2 implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
        if (session == null || session.getAttribute("sessionId") == null) {
			request.setAttribute("message", "세션이 만료되었습니다. 로그인 후 이용해주세요.");
			request.setAttribute("url", "login.l");
            return;
        }

        String id = (String) session.getAttribute("sessionId");

        UserDAO userDAO = new UserDAO();
        UserVO userVO = userDAO.validateUser(id);
        
        if (userVO == null) { // 사용자 검증 실패
        	request.setAttribute("message", "로그인 후 이용해주세요.");
        	request.setAttribute("url", "login.l");
            return;
        }

        request.setAttribute("userVO", userVO);
    }
}
