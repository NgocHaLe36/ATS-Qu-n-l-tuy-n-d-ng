package com.ats.servlet.admin.account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

@WebServlet("/admin/account/change-password")
public class AdminChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User admin = getCurrentAdmin(request, response);
        if (admin == null) return;

        request.getRequestDispatcher("/views/admin/account/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User sessionUser = getCurrentAdmin(request, response);
        if (sessionUser == null) return;

        User admin = userDAO.findById(sessionUser.getId());

        String oldPassword = trim(request.getParameter("oldPassword"));
        String newPassword = trim(request.getParameter("newPassword"));
        String confirmPassword = trim(request.getParameter("confirmPassword"));

        if (oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher("/views/admin/account/change-password.jsp").forward(request, response);
            return;
        }

        if (!oldPassword.equals(admin.getPassword())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/views/admin/account/change-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/views/admin/account/change-password.jsp").forward(request, response);
            return;
        }

        admin.setPassword(newPassword);
        admin = userDAO.update(admin);

        request.getSession().setAttribute("currentUser", admin);
        request.setAttribute("success", "Đổi mật khẩu thành công.");
        request.getRequestDispatcher("/views/admin/account/change-password.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private User getCurrentAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}