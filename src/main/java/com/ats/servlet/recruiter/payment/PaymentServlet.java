package com.ats.servlet.recruiter.payment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/recruiter/payment")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (user == null || !"recruiter".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // 2. Lấy ID đơn đăng ký từ link
        String subIdStr = request.getParameter("subscriptionId");
        if (subIdStr == null || subIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans");
            return;
        }

        try {
            Integer subId = Integer.parseInt(subIdStr);
            Subscription sub = subscriptionDAO.findById(subId);

            if (sub != null && sub.getUser().getId().equals(user.getId())) {
                // Đưa dữ liệu gói sang trang JSP để hiển thị giá tiền
                request.setAttribute("subscription", sub);
                // CHÚ Ý: Đường dẫn này phải khớp với file JSP thanh toán bạn sẽ tạo ở bước 2
                request.getRequestDispatcher("/views/recruiter/payment/payment.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans");
        }
    }
}