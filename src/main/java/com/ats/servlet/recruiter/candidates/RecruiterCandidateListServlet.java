package com.ats.servlet.recruiter.candidates;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/recruiter/candidates")
public class RecruiterCandidateListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAOImpl jobDAO = new JobDAOImpl();
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Integer jobId = parseInteger(request.getParameter("jobId"));
        String keyword = trim(request.getParameter("keyword"));
        String status = trim(request.getParameter("status"));

        List<Application> applications = new ArrayList<>();

        if (jobId != null) {
            Job job = jobDAO.findById(jobId);
            if (job != null && job.getRecruiter() != null && recruiter.getId().equals(job.getRecruiter().getId())) {
                applications.addAll(applicationDAO.findByJobId(jobId));
            }
        } else {
            List<Job> jobs = jobDAO.findByRecruiterId(recruiter.getId());
            for (Job job : jobs) {
                applications.addAll(applicationDAO.findByJobId(job.getId()));
            }
        }

        if (!keyword.isEmpty()) {
            String kw = keyword.toLowerCase();
            applications = applications.stream()
                    .filter(a -> a.getCandidate() != null
                            && a.getCandidate().getUser() != null
                            && (contains(a.getCandidate().getUser().getFullName(), kw)
                            || contains(a.getCandidate().getUser().getEmail(), kw)
                            || contains(a.getCandidate().getSkills(), kw)
                            || contains(a.getCandidate().getEducation(), kw)))
                    .collect(Collectors.toList());
        }

        if (!status.isEmpty()) {
            applications = applications.stream()
                    .filter(a -> status.equalsIgnoreCase(a.getStatus()))
                    .collect(Collectors.toList());
        }

        request.setAttribute("applications", applications);
        request.setAttribute("jobId", jobId);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.getRequestDispatcher("/views/recruiter/candidates/candidate-list.jsp").forward(request, response);
    }

    private boolean contains(String text, String kw) {
        return text != null && text.toLowerCase().contains(kw);
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