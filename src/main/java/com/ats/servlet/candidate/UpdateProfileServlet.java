package com.ats.servlet.candidate;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.CandidateDAO;
import com.ats.dao.UserDAO;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.Candidate;
import com.ats.entity.User;

@WebServlet("/candidate/profile/update")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CandidateDAO candidateDAO = new CandidateDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User currentUser = getCurrentUser(request, response);
        if (currentUser == null) return;

        Candidate candidate = candidateDAO.findByUserId(currentUser.getId());
        if (candidate == null) {
            response.sendRedirect(request.getContextPath() + "/candidate/profile");
            return;
        }

        String fullName = trim(request.getParameter("fullName"));
        String phone = trim(request.getParameter("phone"));
        String skills = trim(request.getParameter("skills"));
        String education = trim(request.getParameter("education"));
        Integer experienceYear = parseInteger(request.getParameter("experienceYear"));

        request.setAttribute("candidate", candidate);
        request.setAttribute("user", currentUser);

        if (fullName.isEmpty()) {
            request.setAttribute("error", "Họ tên không được để trống.");
            request.getRequestDispatcher("/views/candidate/edit-profile.jsp").forward(request, response);
            return;
        }

        currentUser.setFullName(fullName);
        currentUser.setPhone(phone.isEmpty() ? null : phone);
        currentUser = userDAO.update(currentUser);

        candidate.setSkills(skills.isEmpty() ? null : skills);
        candidate.setEducation(education.isEmpty() ? null : education);
        candidate.setExperienceYear(experienceYear);
        candidate = candidateDAO.update(candidate);

        HttpSession session = request.getSession();
        session.setAttribute("currentUser", currentUser);
        session.setAttribute("currentCandidate", candidate);

        response.sendRedirect(request.getContextPath() + "/candidate/profile");
    }

    private Integer parseInteger(String value) {
        try {
            if (value == null || value.trim().isEmpty()) return null;
            return Integer.valueOf(value.trim());
        } catch (Exception e) {
            return null;
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
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