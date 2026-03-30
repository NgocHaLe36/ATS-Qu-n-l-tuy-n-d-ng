package com.ats.servlet.admin.vip;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.PlanDAOImpl;
import com.ats.entity.Plan;
import com.ats.entity.User;

@WebServlet("/admin/vip/plans")
public class VipPlanManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PlanDAOImpl planDAO = new PlanDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        List<Plan> plans = planDAO.findAllOrderByPriceAsc();
        request.setAttribute("plans", plans);
        request.getRequestDispatcher("/views/admin/vip/vip-plan-management.jsp").forward(request, response);
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