package com.ats.servlet.recruiter.vip;

import java.io.IOException;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/recruiter/vip/renew")
public class RenewVipServlet extends HttpServlet {
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String subIdStr = request.getParameter("subscriptionId");
        
        if (subIdStr != null) {
            Integer subId = Integer.parseInt(subIdStr);
            Subscription oldSub = subscriptionDAO.findById(subId);
            
            if (oldSub != null) {
                Subscription renewSub = new Subscription();
                renewSub.setUser(oldSub.getUser());
                renewSub.setPlan(oldSub.getPlan());
                // Ngày bắt đầu gói mới là ngày kết thúc gói cũ
                renewSub.setStartDate(oldSub.getEndDate());
                renewSub.setEndDate(oldSub.getEndDate().plusDays(oldSub.getPlan().getDurationDays()));
                renewSub.setStatus("pending");
                
                renewSub = subscriptionDAO.save(renewSub);
                response.sendRedirect(request.getContextPath() + "/recruiter/payment?subscriptionId=" + renewSub.getId());
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans");
    }
}