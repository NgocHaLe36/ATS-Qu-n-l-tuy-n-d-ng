package com.ats.servlet.recruiter.jobs;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/recruiter/jobs/update")
public class RecruiterUpdateJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final JobDAOImpl jobDAO = new JobDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. Kiểm tra login
        HttpSession session = request.getSession(false);
        User recruiter = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (recruiter == null || !"recruiter".equalsIgnoreCase(recruiter.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            // 2. Lấy ID và tìm tin tuyển dụng
            Integer jobId = Integer.parseInt(request.getParameter("id"));
            Job job = jobDAO.findById(jobId);

            if (job != null && job.getRecruiter().getId().equals(recruiter.getId())) {
                
                // 3. Cập nhật các thông tin cơ bản
                job.setTitle(request.getParameter("title"));
                job.setDescription(request.getParameter("description"));
                job.setRequirement(request.getParameter("requirement"));
                job.setLocation(request.getParameter("location"));
                
                // 4. BỔ SUNG: Cập nhật trạng thái tin (Nút này nãy Hà bị thiếu)
                String status = request.getParameter("status");
                if (status != null && !status.isEmpty()) {
                    job.setStatus(status.toUpperCase()); // Đảm bảo lưu OPEN, HIDDEN hoặc CLOSED
                }

                // 5. Cập nhật lương
                String salaryStr = request.getParameter("salary");
                if (salaryStr != null && !salaryStr.isEmpty()) {
                    job.setSalary(new java.math.BigDecimal(salaryStr).intValue());
                }

                // 6. Cập nhật Deadline (Dùng LocalDateTime an toàn hơn)
                String deadlineStr = request.getParameter("deadline");
                if (deadlineStr != null && !deadlineStr.isEmpty()) {
                    // Cắt bớt nếu chuỗi có định dạng không chuẩn hoặc parse trực tiếp
                    job.setDeadline(java.time.LocalDateTime.parse(deadlineStr).toLocalDate());
                }

                // 7. Cập nhật Tin VIP
                String isVip = request.getParameter("isVip");
                job.setIsVip("true".equals(isVip));

                job.setUpdatedDate(java.time.LocalDateTime.now());

                // 8. Lưu xuống Database
                jobDAO.update(job);

                // Thành công thì về trang chi tiết công việc
                response.sendRedirect(request.getContextPath() + "/recruiter/jobs/detail?id=" + jobId + "&success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/recruiter/jobs?error=access_denied");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi (ví dụ sai định dạng ngày), quay lại trang edit và báo lỗi
            response.sendRedirect(request.getContextPath() + "/recruiter/jobs/edit?id=" + request.getParameter("id") + "&error=true");
        }
    }
}