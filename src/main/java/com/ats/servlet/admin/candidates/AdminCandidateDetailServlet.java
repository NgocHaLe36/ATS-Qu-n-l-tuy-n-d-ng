package com.ats.servlet.admin.candidates;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Candidate;
import com.ats.entity.User;

@WebServlet("/admin/candidates/detail")
public class AdminCandidateDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CandidateDAOImpl candidateDAO = new CandidateDAOImpl();
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        Integer id = parseInteger(request.getParameter("id"));
        Candidate candidate = id == null ? null : candidateDAO.findById(id);

        if (candidate == null) {
            response.sendRedirect(request.getContextPath() + "/admin/candidates");
            return;
        }

        List<Application> applications = applicationDAO.findByCandidateId(candidate.getId());

        request.setAttribute("candidate", candidate);
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/views/admin/candidates/candidate-detail.jsp").forward(request, response);
    }

    private Integer parseInteger(String value) {
        try { return Integer.valueOf(value); } catch (Exception e) { return null; }
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