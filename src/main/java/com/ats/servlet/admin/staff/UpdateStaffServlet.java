package com.ats.servlet.admin.staff;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

@WebServlet("/admin/staff/update")
public class UpdateStaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if (getCurrentAdmin(request, response) == null) return;

        Integer id = parseInteger(request.getParameter("id"));
        User staff = id == null ? null : userDAO.findById(id);

        if (staff == null || !"admin".equalsIgnoreCase(staff.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/staff");
            return;
        }

        String fullName = trim(request.getParameter("fullName"));
        String phone = trim(request.getParameter("phone"));

        if (fullName.isEmpty()) {
            request.setAttribute("error", "Họ tên không được để trống.");
            request.setAttribute("staff", staff);
            request.getRequestDispatcher("/views/admin/staff/create-staff.jsp").forward(request, response);
            return;
        }

        staff.setFullName(fullName);
        staff.setPhone(phone.isEmpty() ? null : phone);

        userDAO.update(staff);
        response.sendRedirect(request.getContextPath() + "/admin/staff");
    }

    private Integer parseInteger(String value) {
        try { return Integer.valueOf(value); } catch (Exception e) { return null; }
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