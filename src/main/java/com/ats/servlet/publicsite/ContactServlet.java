package com.ats.servlet.publicsite;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/public/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = trim(request.getParameter("fullName"));
        String email = trim(request.getParameter("email"));
        String subject = trim(request.getParameter("subject"));
        String message = trim(request.getParameter("message"));

        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("subject", subject);
        request.setAttribute("message", message);

        if (fullName.isEmpty() || email.isEmpty() || subject.isEmpty() || message.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin liên hệ.");
            request.getRequestDispatcher("/views/public/contact.jsp").forward(request, response);
            return;
        }

        request.setAttribute("success", "Cảm ơn bạn đã liên hệ. Hệ thống đã ghi nhận thông tin của bạn.");
        request.getRequestDispatcher("/views/public/contact.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}