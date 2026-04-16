package com.ats.servlet.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.dao.impl.PaymentDAOImpl;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Job;
import com.ats.entity.Payment;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAOImpl userDAO = new UserDAOImpl();
    private final JobDAOImpl jobDAO = new JobDAOImpl();
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();
    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra quyền Admin trước khi cho phép vào Dashboard
        User admin = getCurrentAdmin(request, response);
        if (admin == null) return;

        // 2. Lấy toàn bộ dữ liệu cần thiết cho thống kê
        List<User> recruiters = userDAO.findByRole("recruiter");
        List<User> candidates = userDAO.findByRole("candidate");
        List<Job> jobs = jobDAO.findAll();
        List<Application> applications = applicationDAO.findAll();
        List<Payment> payments = paymentDAO.findAll();
        List<Subscription> subscriptions = subscriptionDAO.findAll();

        // 3. Đưa các con số tổng quát vào Request Attribute
        request.setAttribute("admin", admin);
        request.setAttribute("totalRecruiters", recruiters.size());
        request.setAttribute("totalCandidates", candidates.size());
        request.setAttribute("totalJobs", jobs.size());
        request.setAttribute("totalApplications", applications.size());
        request.setAttribute("totalPayments", payments.size());
        request.setAttribute("totalSubscriptions", subscriptions.size());

        // 4. Lấy danh sách mới nhất (giới hạn số lượng hiển thị trên Dashboard)
        request.setAttribute("latestRecruiters", getSubList(recruiters, 5));
        request.setAttribute("latestCandidates", getSubList(candidates, 5));
        request.setAttribute("latestJobs", getSubList(jobs, 5));
        request.setAttribute("latestApplications", getSubList(applications, 8));
        request.setAttribute("latestPayments", getSubList(payments, 8));

        // 5. Chuyển tiếp sang giao diện Dashboard
        // Lưu ý: Tên file JSP của bạn đang là dashbroad.jsp (đúng theo ảnh cấu trúc thư mục của bạn)
        request.getRequestDispatcher("/views/admin/dashbroad.jsp").forward(request, response);
    }

    /**
     * Hàm bổ trợ để lấy sublist an toàn, tránh lỗi IndexOutOfBounds
     */
    private <T> List<T> getSubList(List<T> list, int limit) {
        if (list == null || list.isEmpty()) return list;
        return list.size() > limit ? list.subList(0, limit) : list;
    }

    /**
     * Kiểm tra phiên làm việc và quyền hạn của Admin
     */
    private User getCurrentAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        
        User user = (User) session.getAttribute("currentUser");
        
        // Dùng equalsIgnoreCase để so sánh role an toàn nhất
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}