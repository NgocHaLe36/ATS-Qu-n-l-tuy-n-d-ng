package com.ats.servlet.admin.reports;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.PaymentDAOImpl;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Payment;
import com.ats.entity.User;

@WebServlet("/admin/reports/analytics")
public class AnalyticsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAOImpl userDAO = new UserDAOImpl();
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();
    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        List<User> recruiters = userDAO.findByRole("recruiter");
        List<User> candidates = userDAO.findByRole("candidate");
        List<Application> applications = applicationDAO.findAll();
        List<Payment> payments = paymentDAO.findAll();

        request.setAttribute("totalRecruiters", recruiters.size());
        request.setAttribute("totalCandidates", candidates.size());
        request.setAttribute("totalApplications", applications.size());
        request.setAttribute("totalPayments", payments.size());

        request.getRequestDispatcher("/views/admin/reports/analytics.jsp").forward(request, response);
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