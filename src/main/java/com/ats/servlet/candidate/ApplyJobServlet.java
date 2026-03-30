package com.ats.servlet.candidate;

import java.io.IOException;
import java.time.LocalDateTime;

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

@WebServlet("/candidate/apply")
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAO jobDAO = new JobDAOImpl();
    private final CandidateDAO candidateDAO = new CandidateDAOImpl();
    private final ApplicationDAO applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request, response);
        if (currentUser == null) return;

        Integer jobId = parseInteger(request.getParameter("jobId"));
        if (jobId == null) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        Job job = jobDAO.findById(jobId);
        Candidate candidate = candidateDAO.findByUserId(currentUser.getId());

        if (job == null || candidate == null) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        if (!"OPEN".equalsIgnoreCase(job.getStatus())) {
            request.getSession().setAttribute("warningMessage", "Công việc này hiện không mở để ứng tuyển.");
            response.sendRedirect(request.getContextPath() + "/job-detail?id=" + jobId);
            return;
        }

        if (job.getDeadline() != null && job.getDeadline().isBefore(LocalDateTime.now())) {
            request.getSession().setAttribute("warningMessage", "Công việc này đã hết hạn ứng tuyển.");
            response.sendRedirect(request.getContextPath() + "/job-detail?id=" + jobId);
            return;
        }

        Application existingApplication = applicationDAO.findByJobAndCandidate(jobId, candidate.getId());
        if (existingApplication != null) {
            request.getSession().setAttribute("warningMessage", "Bạn đã ứng tuyển công việc này rồi.");
            response.sendRedirect(request.getContextPath()
                    + "/candidate/application-detail?id=" + existingApplication.getId());
            return;
        }

        request.setAttribute("job", job);
        request.setAttribute("candidate", candidate);
        request.setAttribute("candidateCvFile", candidate.getCvFile());
        request.getRequestDispatcher("/views/candidate/apply-job.jsp").forward(request, response);
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