package com.ats.servlet.auth;

import java.io.IOException;
import java.time.LocalDateTime;

import com.ats.dao.CandidateDAO;
import com.ats.dao.UserDAO;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.Candidate;
import com.ats.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/auth/register-candidate")
public class RegisterCandidateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();
    private final CandidateDAO candidateDAO = new CandidateDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/register-candidate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = trim(request.getParameter("fullName"));
        String email = trim(request.getParameter("email"));
        String phone = trim(request.getParameter("phone"));
        String password = trim(request.getParameter("password"));
        String confirmPassword = trim(request.getParameter("confirmPassword"));
        String skills = trim(request.getParameter("skills"));
        String education = trim(request.getParameter("education"));
        Integer experienceYear = parseInteger(request.getParameter("experienceYear"));

        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("skills", skills);
        request.setAttribute("education", education);
        request.setAttribute("experienceYear", request.getParameter("experienceYear"));

        if (fullName.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ các trường bắt buộc.");
            request.getRequestDispatcher("/views/auth/register-candidate.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/views/auth/register-candidate.jsp").forward(request, response);
            return;
        }

        if (userDAO.existsByEmail(email)) {
            request.setAttribute("error", "Email đã tồn tại trong hệ thống.");
            request.getRequestDispatcher("/views/auth/register-candidate.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setRole("candidate");
        user.setAvatar(null);
        user.setStatus(true);
        user.setCreatedDate(LocalDateTime.now());

        try {
            user = userDAO.save(user);

            Candidate candidate = new Candidate();
            candidate.setUser(user);
            candidate.setAvatar(null);
            candidate.setCvFile(null);
            candidate.setExperienceYear(experienceYear);
            candidate.setSkills(skills.isEmpty() ? null : skills);
            candidate.setEducation(education.isEmpty() ? null : education);
            candidate.setCreatedDate(LocalDateTime.now());

            candidate = candidateDAO.save(candidate);

            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setAttribute("currentCandidate", candidate);

            response.sendRedirect(request.getContextPath() + "/candidate/dashboard");
        } catch (Exception e) {
            try {
                if (user.getId() != null) {
                    userDAO.deleteById(user.getId());
                }
            } catch (Exception ignored) {
            }

            request.setAttribute("error", "Đăng ký ứng viên thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/auth/register-candidate.jsp").forward(request, response);
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private Integer parseInteger(String value) {
        try {
            if (value == null || value.trim().isEmpty()) return null;
            return Integer.valueOf(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
}