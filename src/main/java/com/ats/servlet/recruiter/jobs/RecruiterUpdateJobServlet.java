package com.ats.servlet.recruiter.jobs;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

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

        String idStr = request.getParameter("id");
        try {
            // 2. Lấy ID và tìm tin tuyển dụng
            Integer jobId = Integer.parseInt(idStr);
            Job job = jobDAO.findById(jobId);

            if (job != null && job.getRecruiter().getId().equals(recruiter.getId())) {
                
                // 3. Cập nhật các thông tin cơ bản
                job.setTitle(request.getParameter("title"));
                job.setDescription(request.getParameter("description"));
                job.setRequirement(request.getParameter("requirement"));
                job.setLocation(request.getParameter("location"));
                
                // 4. Cập nhật trạng thái tin
                String status = request.getParameter("status");
                if (status != null && !status.isEmpty()) {
                    job.setStatus(status.toUpperCase());
                }

                // 5. CHỈNH SỬA: Cập nhật lương (Chuyển BigDecimal sang Integer an toàn)
                String salaryStr = request.getParameter("salary");
                if (salaryStr != null && !salaryStr.isEmpty()) {
                    try {
                        BigDecimal salaryDec = new BigDecimal(salaryStr);
                        job.setSalary(salaryDec.intValue()); // Chuyển về Integer để khớp với entity Job
                    } catch (NumberFormatException e) {
                        // Xử lý nếu format lương nhập vào không đúng
                    }
                }

                // 6. CHỈNH SỬA: Cập nhật Deadline (Chuyển LocalDateTime sang LocalDate)
                String deadlineStr = request.getParameter("deadline");
                if (deadlineStr != null && !deadlineStr.isEmpty()) {
                    try {
                        // Nếu input là datetime-local (yyyy-MM-ddTHH:mm), parse sang LocalDateTime rồi lấy LocalDate
                        if (deadlineStr.contains("T")) {
                            job.setDeadline(LocalDateTime.parse(deadlineStr).toLocalDate());
                        } else {
                            // Nếu input chỉ là date (yyyy-MM-dd)
                            job.setDeadline(LocalDate.parse(deadlineStr));
                        }
                    } catch (DateTimeParseException e) {
                        e.printStackTrace();
                    }
                }

                // 7. Cập nhật Tin VIP
                String isVip = request.getParameter("isVip");
                job.setIsVip("true".equals(isVip));

                job.setUpdatedDate(LocalDateTime.now());

                // 8. Lưu xuống Database
                jobDAO.update(job);

                // Thành công
                response.sendRedirect(request.getContextPath() + "/recruiter/jobs/detail?id=" + jobId + "&success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/recruiter/jobs?error=access_denied");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/recruiter/jobs/edit?id=" + idStr + "&error=true");
        }
    }
}