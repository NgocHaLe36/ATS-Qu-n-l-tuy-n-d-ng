package com.ats.servlet.candidate;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.ApplicationDAO;
import com.ats.dao.CandidateDAO;
import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Candidate;
import com.ats.entity.User;

@WebServlet("/candidate/withdraw-application")
public class WithdrawApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CandidateDAO candidateDAO = new CandidateDAOImpl();
    private final ApplicationDAO applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request, response);
        if (currentUser == null) return;

        Candidate candidate = candidateDAO.findByUserId(currentUser.getId());
        Integer applicationId = parseInteger(request.getParameter("applicationId"));

        if (candidate == null || applicationId == null) {
            response.sendRedirect(request.getContextPath() + "/candidate/applied-jobs");
            return;
        }

        Application application = findOwnedApplication(candidate.getId(), applicationId);
        if (application == null) {
            response.sendRedirect(request.getContextPath() + "/candidate/applied-jobs");
            return;
        }

        if ("WITHDRAWN".equalsIgnoreCase(application.getStatus())) {
            response.sendRedirect(request.getContextPath() + "/candidate/application-detail?id=" + applicationId);
            return;
        }

        applicationDAO.updateStatus(applicationId, "WITHDRAWN", "Ứng viên đã rút hồ sơ.");
        response.sendRedirect(request.getContextPath() + "/candidate/applied-jobs");
    }

    private Application findOwnedApplication(Integer candidateId, Integer applicationId) {
        List<Application> applications = applicationDAO.findByCandidateId(candidateId);
        for (Application app : applications) {
            if (app != null && applicationId.equals(app.getId())) {
                return app;
            }
        }
        return null;
    }

    private Integer parseInteger(String value) {
        try {
            return Integer.valueOf(value);
        } catch (Exception e) {
            return null;
        }
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