package com.ats.servlet.admin.recruitmentresults;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.User;

@WebServlet("/admin/recruitment-results/offer-approval")
public class OfferApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        Integer applicationId = parseInteger(request.getParameter("applicationId"));
        String action = trim(request.getParameter("action"));

        Application application = applicationId == null ? null : applicationDAO.findById(applicationId);
        if (application != null) {
            if ("approve".equalsIgnoreCase(action)) {
                applicationDAO.updateStatus(applicationId, "ACCEPTED", "Offer approved by admin");
            } else if ("reject".equalsIgnoreCase(action)) {
                applicationDAO.updateStatus(applicationId, "REJECTED", "Offer rejected by admin");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/recruitment-results");
    }

    private Integer parseInteger(String value) {
        try { return Integer.valueOf(value); } catch (Exception e) { return null; }
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