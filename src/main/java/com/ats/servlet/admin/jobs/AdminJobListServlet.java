package com.ats.servlet.admin.jobs;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/admin/jobs")
public class AdminJobListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAOImpl jobDAO = new JobDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        String keyword = trim(request.getParameter("keyword"));
        String status = trim(request.getParameter("status"));

        List<Job> jobs = jobDAO.findAll();

        if (!keyword.isEmpty()) {
            String kw = keyword.toLowerCase();
            jobs = jobs.stream()
                    .filter(j -> contains(j.getTitle(), kw)
                            || contains(j.getLocation(), kw)
                            || contains(j.getDescription(), kw))
                    .collect(Collectors.toList());
        }

        if (!status.isEmpty()) {
            jobs = jobs.stream()
                    .filter(j -> status.equalsIgnoreCase(j.getStatus()))
                    .collect(Collectors.toList());
        }

        request.setAttribute("jobs", jobs);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.getRequestDispatcher("/views/admin/jobs/job-list.jsp").forward(request, response);
    }

    private boolean contains(String text, String kw) {
        return text != null && text.toLowerCase().contains(kw);
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