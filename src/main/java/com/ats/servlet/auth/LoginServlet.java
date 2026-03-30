package com.ats.servlet.auth;

import java.io.IOException;

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

@WebServlet(urlPatterns = {"/auth/login", "/login"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();
    private final CandidateDAO candidateDAO = new CandidateDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            User currentUser = (User) session.getAttribute("currentUser");
            response.sendRedirect(request.getContextPath() + getDashboardByRole(currentUser.getRole()));
            return;
        }

        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = trim(request.getParameter("email"));
        String password = trim(request.getParameter("password"));

        request.setAttribute("email", email);

        if (email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ email và mật khẩu.");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.findByEmailAndPassword(email, password);

        if (user == null) {
            User existingUser = userDAO.findByEmail(email);
            if (existingUser != null && Boolean.FALSE.equals(existingUser.getStatus())) {
                request.setAttribute("error", "Tài khoản của bạn đang bị khóa.");
            } else {
                request.setAttribute("error", "Email hoặc mật khẩu không đúng.");
            }
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);

        if ("candidate".equalsIgnoreCase(user.getRole())) {
            Candidate candidate = candidateDAO.findByUserId(user.getId());
            if (candidate != null) {
                session.setAttribute("currentCandidate", candidate);
            }
        }

        response.sendRedirect(request.getContextPath() + getDashboardByRole(user.getRole()));
    }

    private String getDashboardByRole(String role) {
        if (role == null) return "/";
        switch (role.toLowerCase().trim()) {
            case "admin":
                return "/admin/dashboard";
            case "recruiter":
                return "/recruiter/dashboard";
            case "candidate":
                return "/candidate/dashboard";
            default:
                return "/";
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}