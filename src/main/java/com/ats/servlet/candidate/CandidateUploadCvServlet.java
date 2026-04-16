package com.ats.servlet.candidate;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/candidate/upload-cv")
public class CandidateUploadCvServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isCandidateLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        request.getRequestDispatcher("/views/candidate/upload-cv.jsp").forward(request, response);
    }

    private boolean isCandidateLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        Object obj = session.getAttribute("currentUser");
        if (!(obj instanceof com.ats.entity.User)) return false;

        com.ats.entity.User user = (com.ats.entity.User) obj;
        return "candidate".equalsIgnoreCase(user.getRole());
    }
}