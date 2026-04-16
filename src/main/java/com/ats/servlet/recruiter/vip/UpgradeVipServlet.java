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

@WebServlet("/recruiter/vip/upgrade")
public class UpgradeVipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PlanDAOImpl planDAO = new PlanDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User recruiter = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (recruiter == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Kiểm tra ID gói mới truyền lên
        String newPlanIdStr = request.getParameter("newPlanId");
        Integer newPlanId = parseInteger(newPlanIdStr);
        
        System.out.println("DEBUG: Dang nang cap cho User ID: " + recruiter.getId());
        System.out.println("DEBUG: ID goi moi nhan duoc: " + newPlanIdStr);

        Plan newPlan = (newPlanId != null) ? planDAO.findById(newPlanId) : null;
        Subscription activeSub = subscriptionDAO.findActiveByUserId(recruiter.getId());
        
        if (newPlan != null && activeSub != null) {
            Subscription upgradedSub = new Subscription();
            upgradedSub.setUser(recruiter);
            upgradedSub.setPlan(newPlan);
            upgradedSub.setStartDate(LocalDateTime.now());
            upgradedSub.setEndDate(LocalDateTime.now().plusDays(newPlan.getDurationDays()));
            upgradedSub.setStatus("pending");
            
            // LƯU Ý: Phải gán kết quả trả về từ hàm save để lấy ID mới sinh ra
            upgradedSub = subscriptionDAO.save(upgradedSub);
            
            System.out.println("DEBUG: Da tao Sub moi ID: " + upgradedSub.getId());

            // Chuyển sang trang thanh toán
            response.sendRedirect(request.getContextPath() + "/recruiter/payment?subscriptionId=" + upgradedSub.getId());
        } else {
            System.out.println("DEBUG: Khong tim thay goi moi hoac goi hien tai!");
            response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans");
        }
    }

    private Integer parseInteger(String value) {
        try {
            return (value != null && !value.trim().isEmpty()) ? Integer.valueOf(value) : null;
        } catch (Exception e) {
            return null;
        }
    }
}