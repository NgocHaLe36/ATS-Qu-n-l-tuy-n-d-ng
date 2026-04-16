package com.ats.servlet.publicsite;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ats.dao.UserDAO;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

@WebServlet("/recruiters")
public class RecruiterListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 6;

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = trim(request.getParameter("keyword"));
        int currentPage = parsePage(request.getParameter("page"));

        List<User> recruiters = userDAO.searchPublicRecruiters(
                emptyToNull(keyword),
                currentPage,
                PAGE_SIZE
        );

        long totalItems = userDAO.countPublicRecruiters(emptyToNull(keyword));

        int totalPages = (int) Math.ceil(totalItems * 1.0 / PAGE_SIZE);
        if (totalPages <= 0) {
            totalPages = 1;
        }

        request.setAttribute("recruiters", recruiters);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);

        request.getRequestDispatcher("/views/public/recruiter-list.jsp").forward(request, response);
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

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private String emptyToNull(String value) {
        return (value == null || value.trim().isEmpty()) ? null : value.trim();
    }
}