package com.ats.servlet.admin.recruiters;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.JobDAOImpl;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.Job;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/admin/recruiters/detail")
public class AdminRecruiterDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAOImpl userDAO = new UserDAOImpl();
    private final JobDAOImpl jobDAO = new JobDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        Integer id = parseInteger(request.getParameter("id"));
        User recruiter = id == null ? null : userDAO.findById(id);

        if (recruiter == null || !"recruiter".equalsIgnoreCase(recruiter.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/recruiters");
            return;
        }

        List<Job> jobs = jobDAO.findByRecruiterId(recruiter.getId());
        Subscription activeSubscription = subscriptionDAO.findActiveByUserId(recruiter.getId());

        request.setAttribute("recruiter", recruiter);
        request.setAttribute("jobs", jobs);
        request.setAttribute("activeSubscription", activeSubscription);
        request.getRequestDispatcher("/views/admin/recruiters/recruiter-detail.jsp").forward(request, response);
    }

    private Integer parseInteger(String value) {
        try { return Integer.valueOf(value); } catch (Exception e) { return null; }
    }

    private User getCurrentAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}