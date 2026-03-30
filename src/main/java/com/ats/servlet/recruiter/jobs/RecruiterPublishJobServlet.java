package com.ats.servlet.recruiter.jobs;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/recruiter/jobs/publish")
public class RecruiterPublishJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAOImpl jobDAO = new JobDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Integer jobId = parseInteger(request.getParameter("id"));
        Job job = jobId == null ? null : jobDAO.findById(jobId);

        if (job != null && job.getRecruiter() != null && recruiter.getId().equals(job.getRecruiter().getId())) {
            job.setStatus("OPEN");
            job.setUpdatedDate(LocalDateTime.now());
            jobDAO.update(job);
        }

        response.sendRedirect(request.getContextPath() + "/recruiter/jobs");
    }

    private Integer parseInteger(String value) {
        try {
            return Integer.valueOf(value);
        } catch (Exception e) {
            return null;
        }
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