package com.ats.servlet.auth;

import java.io.IOException;
import java.time.LocalDateTime;

import com.ats.dao.UserDAO;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/auth/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = trim(request.getParameter("token"));

        if (!isValidToken(request.getSession(false), token)) {
            request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        request.setAttribute("token", token);
        request.getRequestDispatcher("/views/auth/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String token = trim(request.getParameter("token"));
        String newPassword = trim(request.getParameter("newPassword"));
        String confirmPassword = trim(request.getParameter("confirmPassword"));

        if (newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ mật khẩu mới.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/views/auth/reset-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/views/auth/reset-password.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        if (!isValidToken(session, token)) {
            request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        Integer userId = (Integer) session.getAttribute(ForgotPasswordServlet.RESET_USER_ID_KEY);
        User user = userDAO.findById(userId);

        if (user == null) {
            request.setAttribute("error", "Không tìm thấy tài khoản cần đổi mật khẩu.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        user.setPassword(newPassword);
        userDAO.update(user);

        session.removeAttribute(ForgotPasswordServlet.RESET_TOKEN_KEY);
        session.removeAttribute(ForgotPasswordServlet.RESET_USER_ID_KEY);
        session.removeAttribute(ForgotPasswordServlet.RESET_EXPIRE_AT_KEY);

        request.setAttribute("success", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập lại.");
        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }

    private boolean isValidToken(HttpSession session, String token) {
        if (session == null || token == null || token.isEmpty()) {
            return false;
        }

        String sessionToken = (String) session.getAttribute(ForgotPasswordServlet.RESET_TOKEN_KEY);
        LocalDateTime expireAt = (LocalDateTime) session.getAttribute(ForgotPasswordServlet.RESET_EXPIRE_AT_KEY);

        return sessionToken != null
                && sessionToken.equals(token)
                && expireAt != null
                && LocalDateTime.now().isBefore(expireAt);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}