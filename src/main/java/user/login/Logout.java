package user.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserInterface;

public class Logout implements UserInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); 
        // 세션이 없는 경우 새 세션 만들기 금지
        
        if (session != null) {
            session.invalidate();
        }		
		
        request.setAttribute("url", "/main");
	}
}
