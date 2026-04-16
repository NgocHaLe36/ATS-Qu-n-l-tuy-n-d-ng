package com.ats.servlet.candidate;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.UserDAO;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

@WebServlet("/candidate/change-password")
public class CandidateChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request, response);
        if (currentUser == null) return;

        request.getRequestDispatcher("/views/candidate/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User sessionUser = getCurrentUser(request, response);
        if (sessionUser == null) return;

        User user = userDAO.findById(sessionUser.getId());

        String oldPassword = trim(request.getParameter("oldPassword"));
        String newPassword = trim(request.getParameter("newPassword"));
        String confirmPassword = trim(request.getParameter("confirmPassword"));

        if (oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher("/views/candidate/change-password.jsp").forward(request, response);
            return;
        }

        if (!oldPassword.equals(user.getPassword())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/views/candidate/change-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/views/candidate/change-password.jsp").forward(request, response);
            return;
        }

        if (oldPassword.equals(newPassword)) {
            request.setAttribute("error", "Mật khẩu mới không được trùng mật khẩu cũ.");
            request.getRequestDispatcher("/views/candidate/change-password.jsp").forward(request, response);
            return;
        }

        user.setPassword(newPassword);
        user = userDAO.update(user);

        request.getSession().setAttribute("currentUser", user);
        request.setAttribute("success", "Đổi mật khẩu thành công.");
        request.getRequestDispatcher("/views/candidate/change-password.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private User getCurrentUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }

        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"candidate".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}