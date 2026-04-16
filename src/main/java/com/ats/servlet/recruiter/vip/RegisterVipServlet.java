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
    private final PlanDAOImpl planDAO = new PlanDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User recruiter = (User) session.getAttribute("currentUser");
        
        String planIdStr = request.getParameter("planId");
        System.out.println("DEBUG: Dang dang ky voi Plan ID = " + planIdStr);

        if (planIdStr == null || planIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans");
            return;
        }

        Integer planId = Integer.parseInt(planIdStr);
        Plan plan = planDAO.findById(planId);

        if (plan != null) {
            Subscription subscription = new Subscription();
            subscription.setUser(recruiter);
            subscription.setPlan(plan);
            subscription.setStartDate(LocalDateTime.now());
            subscription.setEndDate(LocalDateTime.now().plusDays(plan.getDurationDays()));
            subscription.setStatus("pending");

            // LƯU Ý: Gán lại để lấy ID
            subscription = subscriptionDAO.save(subscription);
            
            if (subscription != null && subscription.getId() != null) {
                System.out.println("DEBUG: Luu thanh cong Sub ID = " + subscription.getId());
                response.sendRedirect(request.getContextPath() + "/recruiter/payment?subscriptionId=" + subscription.getId());
            } else {
                System.out.println("DEBUG: Loi khong luu duoc vao Database!");
                response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans?error=db");
            }
        }
    }
}