package com.ats.servlet.recruiter.payment;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.dao.impl.PaymentDAOImpl;
import com.ats.entity.Payment;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/recruiter/payment/process")
public class ProcessPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SubscriptionDAOImpl subDAO = new SubscriptionDAOImpl();
    private final PaymentDAOImpl payDAO = new PaymentDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User recruiter = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        // 1. Lấy thông tin phương thức và gói
        String subIdStr = request.getParameter("subscriptionId");
        String method = request.getParameter("paymentMethod"); // MOMO, VNPAY, hoặc BANK
        String selectedBank = request.getParameter("selectedBank"); // Tên ngân hàng (VCB, MB,...)

        if (subIdStr != null && recruiter != null) {
            try {
                Integer subId = Integer.parseInt(subIdStr);
                Subscription sub = subDAO.findById(subId);

                if (sub != null) {
                    // Cập nhật trạng thái gói
                    sub.setStatus("active");
                    subDAO.update(sub);

                    // 2. Tạo bản ghi Payment
                    Payment p = new Payment();
                    p.setUser(recruiter);
                    p.setSubscription(sub);
                    p.setAmount(sub.getPlan().getPrice());
                    p.setPaymentDate(LocalDateTime.now());
                    
                    // Tạo mã giao dịch chuyên nghiệp
                    String datePart = DateTimeFormatter.ofPattern("yyyyMMdd").format(LocalDateTime.now());
                    String txCode = "ATS" + datePart + (System.currentTimeMillis() % 10000);
                    p.setTransactionCode(txCode);
                    
                    // --- LOGIC XỬ LÝ PHƯƠNG THỨC ĐỘNG ---
                    String finalMethod = (method != null) ? method : "CASH";
                    
                    // Nếu là VNPAY hoặc BANK và có chọn ngân hàng cụ thể, hãy ghép tên vào
                    if (("VNPAY".equals(method) || "BANK".equals(method)) 
                        && selectedBank != null && !selectedBank.isEmpty()) {
                        finalMethod = method + " (" + selectedBank + ")"; 
                        // Ví dụ kết quả lưu vào DB: "VNPAY (MBBank)" hoặc "BANK (Vietcombank)"
                    }
                    
                    p.setPaymentMethod(finalMethod.toUpperCase()); 
                    p.setStatus("success");
                    
                    payDAO.save(p);
                    
                    // 3. Chuyển hướng về trang lịch sử
                    response.sendRedirect(request.getContextPath() + "/recruiter/payment/history");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/recruiter/vip/plans?error=1");
    }
}