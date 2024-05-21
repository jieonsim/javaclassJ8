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
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        if (id == null || id.isEmpty() || 
            password == null || password.isEmpty() || 
            nickname == null || nickname.isEmpty() || 
            name == null || name.isEmpty() || 
            email == null || email.isEmpty()) {
            request.setAttribute("message", "모든 정보를 입력해주세요.");
            request.setAttribute("url", "signup.s");
            request.getRequestDispatcher("/WEB-INF/user/signup/signup.jsp").forward(request, response);
            return;
        }

        // 비밀번호 암호화
        String salt = UUID.randomUUID().toString().substring(0, 8);
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

        if (result != 0) {
            response.sendRedirect("signupComplete.s");
        } else {
            request.setAttribute("message", "회원 가입이 정상적으로 완료되지 않았습니다. 다시 시도해주세요.");
            request.setAttribute("url", "signup.s");
            request.getRequestDispatcher("/WEB-INF/user/signup/signup.jsp").forward(request, response);
        }
    }
}
