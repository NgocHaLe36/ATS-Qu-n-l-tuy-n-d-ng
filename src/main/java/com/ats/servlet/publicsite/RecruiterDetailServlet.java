package com.ats.servlet.publicsite;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ats.dao.JobDAO;
import com.ats.dao.UserDAO;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/recruiter-detail")
public class RecruiterDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String PUBLIC_JOB_STATUS = "OPEN";

    private final UserDAO userDAO = new UserDAOImpl();
    private final JobDAO jobDAO = new JobDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer recruiterId = parseInteger(request.getParameter("id"));
        if (recruiterId == null) {
            response.sendRedirect(request.getContextPath() + "/recruiters");
            return;
        }

        User recruiter = findActiveRecruiterById(recruiterId);
        if (recruiter == null) {
            response.sendRedirect(request.getContextPath() + "/recruiters");
            return;
        }

        List<Job> recruiterJobs = jobDAO.findByRecruiterId(recruiterId);
        List<Job> publicJobs = filterPublicJobs(recruiterJobs);

        request.setAttribute("recruiter", recruiter);
        request.setAttribute("recruiterJobs", publicJobs);
        request.setAttribute("jobCount", publicJobs.size());

        request.getRequestDispatcher("/views/public/recruiter-detail.jsp").forward(request, response);
    }

    private User findActiveRecruiterById(Integer recruiterId) {
        List<User> recruiters = userDAO.findByRole("recruiter");
        if (recruiters == null) return null;

        for (User user : recruiters) {
            if (user != null
                    && recruiterId.equals(user.getId())
                    && Boolean.TRUE.equals(user.getStatus())) {
                return user;
            }
        }
        return null;
    }

    private List<Job> filterPublicJobs(List<Job> jobs) {
        List<Job> result = new ArrayList<>();
        if (jobs == null) return result;

        for (Job job : jobs) {
            if (job != null && PUBLIC_JOB_STATUS.equalsIgnoreCase(job.getStatus())) {
                result.add(job);
            }
        }
        return result;
    }

    private Integer parseInteger(String value) {
        try {
            return Integer.valueOf(value);
        } catch (Exception e) {
            return null;
        }
    }
}