package com.ats.servlet.admin.recruitmentresults;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.InterviewDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Interview;
import com.ats.entity.User;

@WebServlet("/admin/recruitment-results/interview")
public class InterviewResultServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();
    private final InterviewDAOImpl interviewDAO = new InterviewDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        Integer applicationId = parseInteger(request.getParameter("applicationId"));
        Application application = applicationId == null ? null : applicationDAO.findById(applicationId);
        Interview latestInterview = applicationId == null ? null : interviewDAO.findLatestByApplicationId(applicationId);

        if (application == null) {
            response.sendRedirect(request.getContextPath() + "/admin/recruitment-results");
            return;
        }

        request.setAttribute("application", application);
        request.setAttribute("latestInterview", latestInterview);
        request.getRequestDispatcher("/views/admin/recruitment-results/recruitment-result-list.jsp").forward(request, response);
    }

    private Integer parseInteger(String value) {
        try { return Integer.valueOf(value); } catch (Exception e) { return null; }
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