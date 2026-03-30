package com.ats.servlet.recruiter.vip;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.PlanDAOImpl;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.entity.Plan;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/recruiter/vip/register")
public class RegisterVipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PlanDAOImpl planDAO = new PlanDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Integer planId = parseInteger(request.getParameter("planId"));
        Plan plan = planId == null ? null : planDAO.findById(planId);

        if (plan == null) {
            response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans");
            return;
        }

        Subscription activeSubscription = subscriptionDAO.findActiveByUserId(recruiter.getId());
        if (activeSubscription != null) {
            request.getSession().setAttribute("warningMessage", "Bạn đang có gói VIP còn hiệu lực.");
            response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans");
            return;
        }

        Subscription subscription = new Subscription();
        subscription.setUser(recruiter);
        subscription.setPlan(plan);
        subscription.setStartDate(LocalDateTime.now());
        subscription.setEndDate(LocalDateTime.now().plusDays(plan.getDurationDays()));
        subscription.setStatus("pending");

        subscription = subscriptionDAO.save(subscription);
        response.sendRedirect(request.getContextPath() + "/recruiter/payment?subscriptionId=" + subscription.getId());
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