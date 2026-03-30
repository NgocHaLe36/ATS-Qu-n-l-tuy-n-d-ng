package com.ats.servlet.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.dao.impl.PaymentDAOImpl;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Job;
import com.ats.entity.Payment;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAOImpl userDAO = new UserDAOImpl();
    private final JobDAOImpl jobDAO = new JobDAOImpl();
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();
    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User admin = getCurrentAdmin(request, response);
        if (admin == null) return;

        List<User> recruiters = userDAO.findByRole("recruiter");
        List<User> candidates = userDAO.findByRole("candidate");
        List<Job> jobs = jobDAO.findAll();
        List<Application> applications = applicationDAO.findAll();
        List<Payment> payments = paymentDAO.findAll();
        List<Subscription> subscriptions = subscriptionDAO.findAll();

        request.setAttribute("admin", admin);
        request.setAttribute("totalRecruiters", recruiters.size());
        request.setAttribute("totalCandidates", candidates.size());
        request.setAttribute("totalJobs", jobs.size());
        request.setAttribute("totalApplications", applications.size());
        request.setAttribute("totalPayments", payments.size());
        request.setAttribute("totalSubscriptions", subscriptions.size());

        request.setAttribute("latestRecruiters", recruiters.size() > 5 ? recruiters.subList(0, 5) : recruiters);
        request.setAttribute("latestCandidates", candidates.size() > 5 ? candidates.subList(0, 5) : candidates);
        request.setAttribute("latestJobs", jobs.size() > 5 ? jobs.subList(0, 5) : jobs);
        request.setAttribute("latestApplications", applications.size() > 8 ? applications.subList(0, 8) : applications);
        request.setAttribute("latestPayments", payments.size() > 8 ? payments.subList(0, 8) : payments);

        request.getRequestDispatcher("/views/admin/dashbroad.jsp").forward(request, response);
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