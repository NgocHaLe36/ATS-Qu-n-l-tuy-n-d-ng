package com.ats.servlet.auth;

import java.io.IOException;

import com.ats.dao.UserDAO;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/auth/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("currentUser");
        User user = userDAO.findById(sessionUser.getId());

        String oldPassword = trim(request.getParameter("oldPassword"));
        String newPassword = trim(request.getParameter("newPassword"));
        String confirmPassword = trim(request.getParameter("confirmPassword"));

        if (oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        if (user == null) {
            request.setAttribute("error", "Tài khoản không tồn tại.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        if (!oldPassword.equals(user.getPassword())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        if (oldPassword.equals(newPassword)) {
            request.setAttribute("error", "Mật khẩu mới không được trùng mật khẩu cũ.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        user.setPassword(newPassword);
        user = userDAO.update(user);

        session.setAttribute("currentUser", user);
        request.setAttribute("success", "Đổi mật khẩu thành công.");
        request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}