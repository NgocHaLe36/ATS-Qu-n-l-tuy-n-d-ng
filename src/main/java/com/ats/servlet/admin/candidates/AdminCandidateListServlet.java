package com.ats.servlet.admin.candidates;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.entity.Candidate;
import com.ats.entity.User;

@WebServlet("/admin/candidates")
public class AdminCandidateListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CandidateDAOImpl candidateDAO = new CandidateDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        String keyword = trim(request.getParameter("keyword"));
        List<Candidate> candidates = candidateDAO.findAll();

        if (!keyword.isEmpty()) {
            String kw = keyword.toLowerCase();
            candidates = candidates.stream()
                    .filter(c -> c.getUser() != null
                            && (contains(c.getUser().getFullName(), kw)
                            || contains(c.getUser().getEmail(), kw)
                            || contains(c.getSkills(), kw)
                            || contains(c.getEducation(), kw)))
                    .collect(Collectors.toList());
        }

        request.setAttribute("candidates", candidates);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/views/admin/candidates/candidate-list.jsp").forward(request, response);
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