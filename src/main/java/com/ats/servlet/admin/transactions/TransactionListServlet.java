package com.ats.servlet.admin.transactions;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.PaymentDAOImpl;
import com.ats.entity.Payment;
import com.ats.entity.User;

@WebServlet("/admin/transactions")
public class TransactionListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        String status = trim(request.getParameter("status"));
        List<Payment> payments = paymentDAO.findAll();

        if (!status.isEmpty()) {
            payments = payments.stream()
                    .filter(p -> status.equalsIgnoreCase(p.getStatus()))
                    .collect(Collectors.toList());
        }

        request.setAttribute("payments", payments);
        request.setAttribute("status", status);
        request.getRequestDispatcher("/views/admin/transactions/transaction-list.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private User getCurrentAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}