package com.ats.servlet.recruiter;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ats.dao.impl.JobDAOImpl;
import com.ats.dao.impl.SubscriptionDAOImpl;
import com.ats.entity.Job;
import com.ats.entity.Subscription;
import com.ats.entity.User;

// Lưu ý: Đổi URL thành /recruiter/dashboard để khớp với các link trong JSP
@WebServlet("/recruiter/dashboard")
public class RecruiterDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final JobDAOImpl jobDAO = new JobDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Kiểm tra quyền truy cập (Session)
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser == null || !"recruiter".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // 2. Lấy dữ liệu cho Dashboard
        // Lấy danh sách việc làm của nhà tuyển dụng này
        List<Job> jobs = jobDAO.findByRecruiterId(currentUser.getId());
        
        // Lấy thông tin gói VIP
        Subscription activeSubscription = subscriptionDAO.findActiveByUserId(currentUser.getId());

        // 3. Đưa dữ liệu vào request attribute để JSP sử dụng
        request.setAttribute("jobs", jobs);
        request.setAttribute("activeSubscription", activeSubscription);
        
        // Giả lập một số con số thống kê (Bạn có thể viết thêm DAO để count chính xác)
        request.setAttribute("totalApplications", 0); 
        request.setAttribute("pendingInterviews", 0);
        request.setAttribute("hiredCount", 0);

        // 4. Forward sang file giao diện JSP của bạn
        // Hãy đảm bảo đường dẫn bên dưới đúng với vị trí file JSP của bạn
        request.getRequestDispatcher("/views/recruiter/dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}