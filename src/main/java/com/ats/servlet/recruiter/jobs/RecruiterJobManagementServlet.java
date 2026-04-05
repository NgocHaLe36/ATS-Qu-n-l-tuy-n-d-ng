package com.ats.servlet.recruiter.jobs;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/recruiter/jobs")
public class RecruiterJobManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final JobDAOImpl jobDAO = new JobDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        String keyword = trim(request.getParameter("keyword"));
        String status = trim(request.getParameter("status"));
        String vip = trim(request.getParameter("vip"));

        List<Job> jobs = jobDAO.findByRecruiterId(recruiter.getId());

        // Lọc từ khóa
        if (!keyword.isEmpty()) {
            String kw = keyword.toLowerCase();
            jobs = jobs.stream()
                    .filter(j -> contains(j.getTitle(), kw) || contains(j.getDescription(), kw))
                    .collect(Collectors.toList());
        }

        // Lọc trạng thái (Dùng equalsIgnoreCase để tránh lệch hoa thường)
        if (!status.isEmpty() && !"all".equalsIgnoreCase(status)) {
            jobs = jobs.stream()
                    .filter(j -> j.getStatus() != null && j.getStatus().equalsIgnoreCase(status))
                    .collect(Collectors.toList());
        }

        // Lọc VIP
        if (!vip.isEmpty() && !"all".equalsIgnoreCase(vip)) {
            boolean isVipSearch = "true".equalsIgnoreCase(vip);
            jobs = jobs.stream()
                    .filter(j -> (j.getIsVip() != null && j.getIsVip()) == isVipSearch)
                    .collect(Collectors.toList());
        }

        request.setAttribute("jobs", jobs);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("vip", vip);
        
        request.getRequestDispatcher("/views/recruiter/jobs/job-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                Integer jobId = Integer.valueOf(idParam);
                // Gọi hàm delete đã thêm ở bước trên
                jobDAO.delete(jobId); 
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // Chuyển hướng về trang danh sách để cập nhật lại bảng
        response.sendRedirect(request.getContextPath() + "/recruiter/jobs");
    }

    private boolean contains(String text, String kw) {
        return text != null && text.toLowerCase().contains(kw);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private User getCurrentRecruiter(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"recruiter".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}