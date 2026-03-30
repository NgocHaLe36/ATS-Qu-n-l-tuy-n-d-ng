package com.ats.servlet.recruiter.account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

@WebServlet("/recruiter/account/change-password")
public class RecruiterChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        request.getRequestDispatcher("/views/recruiter/account/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User sessionUser = getCurrentRecruiter(request, response);
        if (sessionUser == null) return;

        User recruiter = userDAO.findById(sessionUser.getId());

        String oldPassword = trim(request.getParameter("oldPassword"));
        String newPassword = trim(request.getParameter("newPassword"));
        String confirmPassword = trim(request.getParameter("confirmPassword"));

        if (oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher("/views/recruiter/account/change-password.jsp").forward(request, response);
            return;
        }

        if (!oldPassword.equals(recruiter.getPassword())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/views/recruiter/account/change-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/views/recruiter/account/change-password.jsp").forward(request, response);
            return;
        }

        if (oldPassword.equals(newPassword)) {
            request.setAttribute("error", "Mật khẩu mới không được trùng mật khẩu cũ.");
            request.getRequestDispatcher("/views/recruiter/account/change-password.jsp").forward(request, response);
            return;
        }

        recruiter.setPassword(newPassword);
        recruiter = userDAO.update(recruiter);

        request.getSession().setAttribute("currentUser", recruiter);
        request.setAttribute("success", "Đổi mật khẩu thành công.");
        request.getRequestDispatcher("/views/recruiter/account/change-password.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private User getCurrentRecruiter(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }

        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"recruiter".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}