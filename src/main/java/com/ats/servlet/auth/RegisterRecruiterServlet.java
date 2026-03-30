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

@WebServlet("/auth/register-recruiter")
public class RegisterRecruiterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/register-recruiter.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = trim(request.getParameter("fullName"));
        String email = trim(request.getParameter("email"));
        String phone = trim(request.getParameter("phone"));
        String password = trim(request.getParameter("password"));
        String confirmPassword = trim(request.getParameter("confirmPassword"));

        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);

        if (fullName.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ các trường bắt buộc.");
            request.getRequestDispatcher("/views/auth/register-recruiter.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/views/auth/register-recruiter.jsp").forward(request, response);
            return;
        }

        if (userDAO.existsByEmail(email)) {
            request.setAttribute("error", "Email đã tồn tại trong hệ thống.");
            request.getRequestDispatcher("/views/auth/register-recruiter.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setRole("recruiter");
        user.setAvatar(null);
        user.setStatus(true);
        user.setCreatedDate(LocalDateTime.now());

        try {
            user = userDAO.save(user);

            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            response.sendRedirect(request.getContextPath() + "/recruiter/dashboard");
        } catch (Exception e) {
            request.setAttribute("error", "Đăng ký nhà tuyển dụng thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/auth/register-recruiter.jsp").forward(request, response);
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}