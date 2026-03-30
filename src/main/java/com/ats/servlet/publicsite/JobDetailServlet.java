package com.ats.servlet.publicsite;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ats.dao.JobDAO;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Job;

@WebServlet("/job-detail")
public class JobDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAO jobDAO = new JobDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer jobId = parseInteger(request.getParameter("id"));
        if (jobId == null) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        Job job = jobDAO.findPublicJobById(jobId);
        if (job == null) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        List<Job> relatedJobs = jobDAO.findRelatedPublicJobs(job.getId(), job.getLocation(), 4);

        request.setAttribute("job", job);
        request.setAttribute("relatedJobs", relatedJobs);

        request.getRequestDispatcher("/views/public/job-detail.jsp").forward(request, response);
    }

    private Integer parseInteger(String value) {
        try {
            return Integer.valueOf(value);
        } catch (Exception e) {
            return null;
        }
    }
}