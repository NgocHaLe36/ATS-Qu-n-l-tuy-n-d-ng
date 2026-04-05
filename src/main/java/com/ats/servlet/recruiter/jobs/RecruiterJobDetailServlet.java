package com.ats.servlet.recruiter.jobs;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/recruiter/jobs/detail")
public class RecruiterJobDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAOImpl jobDAO = new JobDAOImpl();
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Integer jobId = parseInteger(request.getParameter("id"));
        Job job = jobId == null ? null : jobDAO.findById(jobId);

        if (job == null || job.getRecruiter() == null || !recruiter.getId().equals(job.getRecruiter().getId())) {
            response.sendRedirect(request.getContextPath() + "/raecruiter/jobs");
            return;
        }

        List<Application> applications = applicationDAO.findByJobId(job.getId());

        request.setAttribute("job", job);
        request.setAttribute("applications", applications);
        request.setAttribute("applicationCount", applications.size());
        request.getRequestDispatcher("/views/recruiter/jobs/job-detail.jsp").forward(request, response);
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