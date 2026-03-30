package com.ats.servlet.candidate;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.ApplicationDAO;
import com.ats.dao.CandidateDAO;
import com.ats.dao.JobDAO;
import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Candidate;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/candidate/dashboard")
public class CandidateDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CandidateDAO candidateDAO = new CandidateDAOImpl();
    private final ApplicationDAO applicationDAO = new ApplicationDAOImpl();
    private final JobDAO jobDAO = new JobDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request, response);
        if (currentUser == null) return;

        Candidate candidate = candidateDAO.findByUserId(currentUser.getId());
        if (candidate == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        List<Application> applications = applicationDAO.findByCandidateId(candidate.getId());
        List<Job> openJobs = jobDAO.searchJobs(null, null, "OPEN", null);

        long totalApplications = applications.size();
        long appliedCount = countByStatus(applications, "APPLIED");
        long reviewingCount = countByStatus(applications, "REVIEWING");
        long interviewedCount = countByStatus(applications, "INTERVIEW");
        long acceptedCount = countByStatus(applications, "ACCEPTED");

        request.getSession().setAttribute("currentCandidate", candidate);

        request.setAttribute("candidate", candidate);
        request.setAttribute("applications", applications);
        request.setAttribute("latestApplications", applications.size() > 5 ? applications.subList(0, 5) : applications);
        request.setAttribute("featuredJobs", openJobs.size() > 6 ? openJobs.subList(0, 6) : openJobs);

        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("appliedCount", appliedCount);
        request.setAttribute("reviewingCount", reviewingCount);
        request.setAttribute("interviewedCount", interviewedCount);
        request.setAttribute("acceptedCount", acceptedCount);

        request.getRequestDispatcher("/views/candidate/dashboard.jsp").forward(request, response);
    }

    private long countByStatus(List<Application> applications, String status) {
        return applications.stream()
                .filter(a -> a != null && status.equalsIgnoreCase(a.getStatus()))
                .count();
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