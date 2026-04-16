package com.ats.servlet.admin.staff;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

@WebServlet("/admin/staff/store")
public class StoreStaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if (getCurrentAdmin(request, response) == null) return;

        String fullName = trim(request.getParameter("fullName"));
        String email = trim(request.getParameter("email"));
        String phone = trim(request.getParameter("phone"));
        String password = trim(request.getParameter("password"));

        if (fullName.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc.");
            request.getRequestDispatcher("/views/admin/staff/create-staff.jsp").forward(request, response);
            return;
        }

        if (userDAO.existsByEmail(email)) {
            request.setAttribute("error", "Email đã tồn tại.");
            request.getRequestDispatcher("/views/admin/staff/create-staff.jsp").forward(request, response);
            return;
        }

        User staff = new User();
        staff.setFullName(fullName);
        staff.setEmail(email);
        staff.setPhone(phone.isEmpty() ? null : phone);
        staff.setPassword(password);
        staff.setRole("admin");
        staff.setStatus(true);
        staff.setCreatedDate(LocalDateTime.now());

        userDAO.save(staff);
        response.sendRedirect(request.getContextPath() + "/admin/staff");
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