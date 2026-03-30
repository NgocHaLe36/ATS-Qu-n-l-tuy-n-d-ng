package com.ats.servlet.recruiter.payment;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.PaymentDAOImpl;
import com.ats.entity.Payment;
import com.ats.entity.User;

@WebServlet("/recruiter/payment/history")
public class PaymentHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        List<Payment> payments = paymentDAO.findByUserId(recruiter.getId());

        request.setAttribute("payments", payments);
        request.getRequestDispatcher("/views/recruiter/payment/payment-history.jsp").forward(request, response);
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