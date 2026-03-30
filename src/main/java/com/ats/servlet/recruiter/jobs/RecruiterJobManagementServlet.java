package com.ats.servlet.recruiter.jobs;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/recruiter/jobs")
public class RecruiterJobManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAOImpl jobDAO = new JobDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        String keyword = trim(request.getParameter("keyword"));
        String status = trim(request.getParameter("status"));
        String vip = trim(request.getParameter("vip"));

        List<Job> jobs = jobDAO.findByRecruiterId(recruiter.getId());

        if (!keyword.isEmpty()) {
            String kw = keyword.toLowerCase();
            jobs = jobs.stream()
                    .filter(j -> contains(j.getTitle(), kw)
                            || contains(j.getDescription(), kw)
                            || contains(j.getRequirement(), kw))
                    .collect(Collectors.toList());
        }

        if (!status.isEmpty()) {
            jobs = jobs.stream()
                    .filter(j -> status.equalsIgnoreCase(j.getStatus()))
                    .collect(Collectors.toList());
        }

        if (!vip.isEmpty()) {
            boolean vipValue = Boolean.parseBoolean(vip);
            jobs = jobs.stream()
                    .filter(j -> Boolean.TRUE.equals(j.getIsVip()) == vipValue)
                    .collect(Collectors.toList());
        }

        request.setAttribute("jobs", jobs);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("vip", vip);
        request.getRequestDispatcher("/views/recruiter/jobs/job-management.jsp").forward(request, response);
    }

    private boolean contains(String text, String kw) {
        return text != null && text.toLowerCase().contains(kw);
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