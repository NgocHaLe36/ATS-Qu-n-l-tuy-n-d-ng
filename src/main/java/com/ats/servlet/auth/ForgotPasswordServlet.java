package com.ats.servlet.auth;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

import com.ats.dao.UserDAO;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/auth/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static final String RESET_TOKEN_KEY = "RESET_TOKEN";
    public static final String RESET_USER_ID_KEY = "RESET_USER_ID";
    public static final String RESET_EXPIRE_AT_KEY = "RESET_EXPIRE_AT";

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = trim(request.getParameter("email"));
        request.setAttribute("email", email);

        if (email.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập email.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        User user = userDAO.findByEmail(email);
        if (user == null) {
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        String token = UUID.randomUUID().toString();
        LocalDateTime expireAt = LocalDateTime.now().plusMinutes(15);

        HttpSession session = request.getSession();
        session.setAttribute(RESET_TOKEN_KEY, token);
        session.setAttribute(RESET_USER_ID_KEY, user.getId());
        session.setAttribute(RESET_EXPIRE_AT_KEY, expireAt);

        String resetLink = request.getContextPath() + "/auth/reset-password?token=" + token;

        request.setAttribute("success", "Đã tạo yêu cầu đặt lại mật khẩu. Link reset có hiệu lực 15 phút.");
        request.setAttribute("resetLink", resetLink);
        request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}