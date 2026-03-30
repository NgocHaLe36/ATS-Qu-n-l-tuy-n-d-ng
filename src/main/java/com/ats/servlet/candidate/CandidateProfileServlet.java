package com.ats.servlet.candidate;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.CandidateDAO;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.entity.Candidate;
import com.ats.entity.User;

@WebServlet("/candidate/profile")
public class CandidateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CandidateDAO candidateDAO = new CandidateDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request, response);
        if (currentUser == null) return;

        Candidate candidate = candidateDAO.findByUserId(currentUser.getId());
        request.getSession().setAttribute("currentCandidate", candidate);

        request.setAttribute("candidate", candidate);
        request.setAttribute("user", currentUser);
        request.getRequestDispatcher("/views/candidate/profile.jsp").forward(request, response);
    }

    private User getCurrentUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }

        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"candidate".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}