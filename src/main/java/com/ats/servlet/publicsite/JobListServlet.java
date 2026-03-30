package com.ats.servlet.publicsite;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ats.dao.JobDAO;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Job;

@WebServlet("/jobs")
public class JobListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 6;

    private final JobDAO jobDAO = new JobDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = trim(request.getParameter("keyword"));
        String location = trim(request.getParameter("location"));
        Boolean isVip = parseVip(request.getParameter("vip"));
        int currentPage = parsePage(request.getParameter("page"));

        List<Job> jobs = jobDAO.searchPublicJobs(
                emptyToNull(keyword),
                emptyToNull(location),
                isVip,
                null,
                currentPage,
                PAGE_SIZE
        );

        long totalItems = jobDAO.countPublicJobs(
                emptyToNull(keyword),
                emptyToNull(location),
                isVip,
                null
        );

        int totalPages = (int) Math.ceil(totalItems * 1.0 / PAGE_SIZE);
        if (totalPages <= 0) {
            totalPages = 1;
        }

        request.setAttribute("jobs", jobs);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);

        request.setAttribute("keyword", keyword);
        request.setAttribute("location", location);
        request.setAttribute("vip", request.getParameter("vip"));

        request.getRequestDispatcher("/views/public/job-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private int parsePage(String page) {
        try {
            int value = Integer.parseInt(page);
            return value > 0 ? value : 1;
        } catch (Exception e) {
            return 1;
        }
    }

    private Boolean parseVip(String vip) {
        if ("true".equalsIgnoreCase(vip)) return true;
        if ("false".equalsIgnoreCase(vip)) return false;
        return null;
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private String emptyToNull(String value) {
        return (value == null || value.trim().isEmpty()) ? null : value.trim();
    }
}