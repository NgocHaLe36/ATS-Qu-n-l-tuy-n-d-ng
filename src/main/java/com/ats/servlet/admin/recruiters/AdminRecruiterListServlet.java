package com.ats.servlet.admin.recruiters;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.User;

@WebServlet("/admin/recruiters")
public class AdminRecruiterListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getCurrentAdmin(request, response) == null) return;

        String keyword = trim(request.getParameter("keyword"));
        List<User> recruiters = userDAO.findByRole("recruiter");

        if (!keyword.isEmpty()) {
            String kw = keyword.toLowerCase();
            recruiters = recruiters.stream()
                    .filter(u -> contains(u.getFullName(), kw)
                            || contains(u.getEmail(), kw)
                            || contains(u.getPhone(), kw))
                    .collect(Collectors.toList());
        }

        request.setAttribute("recruiters", recruiters);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/views/admin/recruiters/recruiter-list.jsp").forward(request, response);
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