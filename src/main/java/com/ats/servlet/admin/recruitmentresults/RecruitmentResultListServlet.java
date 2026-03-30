package com.ats.servlet.admin.recruitmentresults;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.User;

@WebServlet("/admin/recruitment-results")
public class RecruitmentResultListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        String status = trim(request.getParameter("status"));
        List<Application> applications = applicationDAO.findAll();

        if (!status.isEmpty()) {
            applications = applications.stream()
                    .filter(a -> status.equalsIgnoreCase(a.getStatus()))
                    .collect(Collectors.toList());
        }

        request.setAttribute("applications", applications);
        request.setAttribute("status", status);
        request.getRequestDispatcher("/views/admin/recruitment-results/recruitment-result-list.jsp").forward(request, response);
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