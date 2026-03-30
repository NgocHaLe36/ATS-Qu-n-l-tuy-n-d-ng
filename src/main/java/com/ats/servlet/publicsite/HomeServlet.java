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

@WebServlet(urlPatterns = {"/", "/home"})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAO jobDAO = new JobDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Job> latestJobs = jobDAO.findLatestPublicJobs(8);
        List<Job> vipJobs = jobDAO.findVipPublicJobs(6);
        List<User> recruiters = userDAO.findFeaturedRecruiters(8);

        request.setAttribute("latestJobs", latestJobs);
        request.setAttribute("vipJobs", vipJobs);
        request.setAttribute("recruiters", recruiters);

        request.setAttribute("totalJobs", jobDAO.countPublicJobs(null, null, null, null));
        request.setAttribute("totalVipJobs", jobDAO.countPublicJobs(null, null, true, null));
        request.setAttribute("totalRecruiters", userDAO.countPublicRecruiters(null));

        request.getRequestDispatcher("/views/public/home.jsp").forward(request, response);
    }
}