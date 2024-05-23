package user.signup;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserInterface;

@SuppressWarnings("serial")
@WebServlet("*.s")
public class SignupController extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserInterface command = null;
        String viewPage = "/WEB-INF/user/signup/";

        String com = request.getRequestURI();
        com = com.substring(com.lastIndexOf("/") + 1, com.lastIndexOf("."));

        if (com.equals("signup")) {
            viewPage += "signup.jsp";
        }
        else if (com.equals("tryToSignup")) {
            command = new Signup();
            command.execute(request, response);
            viewPage += "signupComplete.jsp";
        }
        else if (com.equals("checkIdDuplicated")) {
            command = new CheckIdDuplicated();
            command.execute(request, response);
            return; 
        }
        else if (com.equals("checkNicknameDuplicated")) {
        	command = new CheckNicknameDuplicated();
        	command.execute(request, response);
        	return; 
        }
        else if (com.equals("checkEmailDuplicated")) {
        	command = new CheckEmailDuplicated();
        	command.execute(request, response);
        	return; 
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
    }
}
