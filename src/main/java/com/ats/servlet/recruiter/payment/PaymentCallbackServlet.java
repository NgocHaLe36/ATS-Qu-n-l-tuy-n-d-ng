package com.ats.servlet.recruiter.payment;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.PaymentDAOImpl;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.entity.Payment;
import com.ats.entity.Subscription;

@WebServlet("/recruiter/payment/callback")
public class PaymentCallbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleCallback(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleCallback(request, response);
    }

    private void handleCallback(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Integer subscriptionId = parseInteger(request.getParameter("subscriptionId"));
        String transactionCode = trim(request.getParameter("transactionCode"));
        String paymentMethod = trim(request.getParameter("paymentMethod"));
        String status = trim(request.getParameter("status"));

        if (subscriptionId == null || transactionCode.isEmpty() || status.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/recruiter/payment/history");
            return;
        }

        Subscription subscription = subscriptionDAO.findById(subscriptionId);
        if (subscription == null) {
            response.sendRedirect(request.getContextPath() + "/recruiter/payment/history");
            return;
        }

        Payment payment = paymentDAO.findByTransactionCode(transactionCode);
        if (payment == null) {
            payment = new Payment();
            payment.setUser(subscription.getUser());
            payment.setSubscription(subscription);
            payment.setAmount(subscription.getPlan() != null ? subscription.getPlan().getPrice() : BigDecimal.ZERO);
            payment.setPaymentMethod(paymentMethod.isEmpty() ? "manual" : paymentMethod);
            payment.setTransactionCode(transactionCode);
            payment.setStatus(status);
            payment.setPaymentDate(LocalDateTime.now());
            paymentDAO.save(payment);
        } else {
            payment.setStatus(status);
            payment.setPaymentMethod(paymentMethod.isEmpty() ? payment.getPaymentMethod() : paymentMethod);
            payment.setPaymentDate(LocalDateTime.now());
            paymentDAO.update(payment);
        }

        if ("success".equalsIgnoreCase(status) || "paid".equalsIgnoreCase(status)) {
            subscription.setStatus("active");
            if (subscription.getStartDate() == null) {
                subscription.setStartDate(LocalDateTime.now());
            }
            if (subscription.getPlan() != null) {
                subscription.setEndDate(subscription.getStartDate().plusDays(subscription.getPlan().getDurationDays()));
            }
            subscriptionDAO.update(subscription);
        } else {
            subscription.setStatus("failed");
            subscriptionDAO.update(subscription);
        }

        response.sendRedirect(request.getContextPath() + "/recruiter/payment/history");
    }

    private Integer parseInteger(String value) {
        try {
            return Integer.valueOf(value);
        } catch (Exception e) {
            return null;
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}