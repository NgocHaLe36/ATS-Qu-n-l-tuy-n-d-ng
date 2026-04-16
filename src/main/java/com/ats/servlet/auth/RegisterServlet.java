package com.ats.servlet.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/auth/register", "/register"})
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getParameter("role");

        if ("candidate".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/auth/register-candidate");
            return;
        }

        if ("recruiter".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/auth/register-recruiter");
            return;
        }

        request.setAttribute("error", "Vui lòng chọn loại tài khoản cần đăng ký.");
        request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
    }
}