package com.ats.servlet.admin.vip;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.PlanDAOImpl;
import com.ats.entity.Plan;
import com.ats.entity.User;

@WebServlet("/admin/vip/plans/create")
public class CreateVipPlanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PlanDAOImpl planDAO = new PlanDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if (getCurrentAdmin(request, response) == null) return;

        String name = trim(request.getParameter("name"));
        // ĐÃ SỬA: Dùng parseInteger thay vì parseDecimal
        Integer price = parseInteger(request.getParameter("price")); 
        Integer durationDays = parseInteger(request.getParameter("durationDays"));
        Integer jobLimit = parseInteger(request.getParameter("jobLimit"));
        String description = trim(request.getParameter("description"));

        if (name.isEmpty() || price == null || durationDays == null || jobLimit == null) {
            response.sendRedirect(request.getContextPath() + "/admin/vip/plans");
            return;
        }

        Plan plan = new Plan();
        plan.setName(name);
        plan.setPrice(price);
        plan.setDurationDays(durationDays);
        plan.setJobLimit(jobLimit);
        plan.setDescription(description.isEmpty() ? null : description);

        planDAO.save(plan);
        response.sendRedirect(request.getContextPath() + "/admin/vip/plans");
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