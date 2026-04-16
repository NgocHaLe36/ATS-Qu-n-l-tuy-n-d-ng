package com.ats.servlet.recruiter.vip;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.entity.Subscription;

@WebServlet("/recruiter/vip/cancel")
public class CancelVipServlet extends HttpServlet {
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer subId = Integer.parseInt(request.getParameter("subscriptionId"));
        Subscription sub = subscriptionDAO.findById(subId);

        if (sub != null) {
            sub.setStatus("cancelled"); // Hoặc xóa hẳn tùy yêu cầu bài tập
            subscriptionDAO.update(sub);
            request.getSession().setAttribute("warningMessage", "Đã hủy yêu cầu sử dụng gói VIP.");
        }
        response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans");
    }
}