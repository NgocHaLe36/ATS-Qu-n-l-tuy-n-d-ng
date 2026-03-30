package com.ats.servlet.recruiter.pipeline;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.User;

@WebServlet("/recruiter/pipeline/update-status")
public class UpdatePipelineStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Integer applicationId = parseInteger(request.getParameter("applicationId"));
        String status = trim(request.getParameter("status"));
        String note = trim(request.getParameter("note"));

        Application application = applicationId == null ? null : applicationDAO.findById(applicationId);

        if (application != null
                && application.getJob() != null
                && application.getJob().getRecruiter() != null
                && recruiter.getId().equals(application.getJob().getRecruiter().getId())
                && !status.isEmpty()) {
            applicationDAO.updateStatus(applicationId, status, note.isEmpty() ? application.getNote() : note);
        }

        response.sendRedirect(request.getContextPath() + "/recruiter/pipeline");
    }

    private Integer parseInteger(String value) {
        try {
            return Integer.valueOf(value);
        } catch (Exception e) {
            return null;
        }
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