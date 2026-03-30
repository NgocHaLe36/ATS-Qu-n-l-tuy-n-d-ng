package com.ats.servlet.recruiter.jobs;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/recruiter/jobs/create")
public class RecruiterCreateJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Subscription activeSubscription = subscriptionDAO.findActiveByUserId(recruiter.getId());
        request.setAttribute("activeSubscription", activeSubscription);
        request.getRequestDispatcher("/views/recruiter/jobs/create-job.jsp").forward(request, response);
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