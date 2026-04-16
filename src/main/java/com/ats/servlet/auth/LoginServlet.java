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
            // Nếu đã đăng nhập, đẩy về dashboard tương ứng với Role
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

        // Tìm User trong Database
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

        // 1. Đăng nhập thành công -> Thiết lập Session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);

        // 2. Chuẩn hóa Role để xử lý logic
        String userRole = (user.getRole() != null) ? user.getRole().toLowerCase().trim() : "";
        
        // 3. Xử lý logic riêng cho Candidate (Giữ nguyên yêu cầu của bạn)
        if ("candidate".equals(userRole)) {
            Candidate candidate = candidateDAO.findByUserId(user.getId());
            if (candidate != null) {
                session.setAttribute("currentCandidate", candidate);
            }
        }

        // 4. Lấy URL điều hướng dựa trên Role
        String redirectUrl = getDashboardByRole(userRole);
        
        // Log Debug trên Console để kiểm tra đường dẫn thực tế
        System.out.println("DEBUG: User [" + user.getEmail() + "] Role [" + userRole + "] -> Redirecting to: " + redirectUrl);
        
        // Chuyển hướng người dùng
        response.sendRedirect(request.getContextPath() + redirectUrl);
    }

    /**
     * Hàm điều hướng chính xác cho từng loại tài khoản
     */
    private String getDashboardByRole(String role) {
        if (role == null) return "/home";
        
        String cleanRole = role.toLowerCase().trim();
        
        switch (cleanRole) {
            case "admin":
                // Đảm bảo AdminDashboardServlet map đúng @WebServlet("/admin/dashboard")
                return "/admin/dashboard";
            case "recruiter":
                return "/recruiter/dashboard";
            case "candidate":
                // Nếu muốn Candidate vào dashboard riêng thì dùng /candidate/dashboard
                // Nếu muốn Candidate ra trang chủ tìm việc ngay thì dùng /home
                return "/candidate/dashboard";
            default:
                return "/home";
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}