package com.ats.servlet.recruiter.vip;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.PlanDAOImpl;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.entity.Plan;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/recruiter/vip/plans")
public class VipPlansServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PlanDAOImpl planDAO = new PlanDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        List<Plan> plans = planDAO.findAllOrderByPriceAsc();
        Subscription activeSubscription = subscriptionDAO.findActiveByUserId(recruiter.getId());

        request.setAttribute("plans", plans);
        request.setAttribute("activeSubscription", activeSubscription);
        request.getRequestDispatcher("/views/recruiter/vip/vip-plans.jsp").forward(request, response);
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