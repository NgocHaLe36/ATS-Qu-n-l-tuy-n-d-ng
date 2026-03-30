package com.ats.servlet.recruiter.jobs;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.JobDAOImpl;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.entity.Job;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/recruiter/jobs/store")
public class RecruiterStoreJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAOImpl jobDAO = new JobDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        String title = trim(request.getParameter("title"));
        String description = trim(request.getParameter("description"));
        String requirement = trim(request.getParameter("requirement"));
        String location = trim(request.getParameter("location"));
        String status = trim(request.getParameter("status"));
        String deadlineStr = trim(request.getParameter("deadline"));
        BigDecimal salary = parseDecimal(request.getParameter("salary"));
        boolean isVip = "true".equalsIgnoreCase(request.getParameter("isVip"));

        if (title.isEmpty() || description.isEmpty() || requirement.isEmpty() || location.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin công việc.");
            request.getRequestDispatcher("/views/recruiter/jobs/create-job.jsp").forward(request, response);
            return;
        }

        Subscription activeSubscription = subscriptionDAO.findActiveByUserId(recruiter.getId());
        if (isVip && activeSubscription == null) {
            request.setAttribute("error", "Bạn cần gói VIP đang hoạt động để đăng tin VIP.");
            request.getRequestDispatcher("/views/recruiter/jobs/create-job.jsp").forward(request, response);
            return;
        }

        Job job = new Job();
        job.setRecruiter(recruiter);
        job.setTitle(title);
        job.setDescription(description);
        job.setRequirement(requirement);
        job.setLocation(location);
        job.setSalary(salary);
        job.setIsVip(isVip);
        job.setStatus(status.isEmpty() ? "DRAFT" : status);
        job.setDeadline(parseDateTime(deadlineStr));
        job.setCreatedDate(LocalDateTime.now());
        job.setUpdatedDate(LocalDateTime.now());

        jobDAO.save(job);
        response.sendRedirect(request.getContextPath() + "/recruiter/jobs");
    }

    private LocalDateTime parseDateTime(String value) {
        try {
            if (value == null || value.trim().isEmpty()) return null;
            return LocalDateTime.parse(value);
        } catch (Exception e) {
            return null;
        }
    }

    private BigDecimal parseDecimal(String value) {
        try {
            if (value == null || value.trim().isEmpty()) return null;
            return new BigDecimal(value.trim());
        } catch (Exception e) {
            return null;
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
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