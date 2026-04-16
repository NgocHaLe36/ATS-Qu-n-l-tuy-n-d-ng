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
import com.ats.dao.impl.ApplicationDAOImpl; 
import com.ats.entity.Job;
import com.ats.entity.Subscription;
import com.ats.entity.User;

@WebServlet("/recruiter/dashboard")
public class RecruiterDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final JobDAOImpl jobDAO = new JobDAOImpl();
    private final SubscriptionDAOImpl subscriptionDAO = new SubscriptionDAOImpl();
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Kiểm tra quyền truy cập (Session)
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (currentUser == null || !"recruiter".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // 2. Lấy ID Nhà tuyển dụng
        Integer recruiterId = currentUser.getId();

        try {
            // 3. Lấy dữ liệu danh sách
            List<Job> jobs = jobDAO.findByRecruiterId(recruiterId);
            Subscription activeSubscription = subscriptionDAO.findActiveByUserId(recruiterId);

            // 4. LẤY CON SỐ THỐNG KÊ THỰC TẾ
            Long totalJobs = (long) (jobs != null ? jobs.size() : 0);
            Long totalAppsCount = applicationDAO.countByRecruiterId(recruiterId);
            
            // Gọi các hàm đếm trạng thái cụ thể từ DAO đã sửa lỗi @Override
            Long pendingInterviewsCount = applicationDAO.countPendingInterviews(recruiterId);
            Long hiredCountVal = applicationDAO.countAcceptedCandidates(recruiterId);

            // 5. Đẩy dữ liệu sang JSP
            request.setAttribute("jobs", jobs);
            request.setAttribute("activeSubscription", activeSubscription);
            
            // --- SỬA TÊN BIẾN CHO KHỚP VỚI JSP CỦA BẠN ---
            // Gửi cả 2 tên biến để đảm bảo JSP tìm thấy dữ liệu
            request.setAttribute("totalJobs", totalJobs);
            
            // JSP của bạn đang gọi ${totalApplications}, mình set đúng tên đó:
            request.setAttribute("totalApps", totalAppsCount); 
            request.setAttribute("totalApplications", totalAppsCount); 
            
            request.setAttribute("pendingInterviews", pendingInterviewsCount);
            request.setAttribute("hiredCount", hiredCountVal);

        } catch (Exception e) {
            e.printStackTrace();
            // Gán mặc định bằng 0 nếu có lỗi DB
            request.setAttribute("totalJobs", 0);
            request.setAttribute("totalApplications", 0);
            request.setAttribute("pendingInterviews", 0);
            request.setAttribute("hiredCount", 0);
        }

        // 6. Chuyển hướng đến giao diện
        request.getRequestDispatcher("/views/recruiter/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}	