package com.ats.servlet.publicsite;

import java.io.IOException;
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

@WebServlet("/company")
public class CompanyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAO jobDAO = new JobDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Job> featuredJobs = jobDAO.findLatestPublicJobs(6);
        List<User> featuredRecruiters = userDAO.findFeaturedRecruiters(6);

        request.setAttribute("featuredJobs", featuredJobs);
        request.setAttribute("featuredRecruiters", featuredRecruiters);
        request.setAttribute("totalJobs", jobDAO.countPublicJobs(null, null, null, null));
        request.setAttribute("totalRecruiters", userDAO.countPublicRecruiters(null));

        request.getRequestDispatcher("/views/public/company.jsp").forward(request, response);
    }
}