package com.ats.servlet.candidate;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.ApplicationDAO;
import com.ats.dao.CandidateDAO;
import com.ats.dao.JobDAO;
import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Candidate;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/candidate/submit-application")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 10 * 1024 * 1024,  // 10MB
    maxRequestSize = 20 * 1024 * 1024 // 20MB
)
public class SubmitJobApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final JobDAO jobDAO = new JobDAOImpl();
    private final CandidateDAO candidateDAO = new CandidateDAOImpl();
    private final ApplicationDAO applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User currentUser = getCurrentUser(request, response);
        if (currentUser == null) return;

        Integer jobId = parseInteger(request.getParameter("jobId"));
        String note = trim(request.getParameter("note"));
        
        Job job = jobDAO.findById(jobId);
        Candidate candidate = candidateDAO.findByUserId(currentUser.getId());

        if (job == null || candidate == null) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        // Kiểm tra ứng tuyển trùng
        if (applicationDAO.existsByJobAndCandidate(jobId, candidate.getId())) {
            request.getSession().setAttribute("warningMessage", "Bạn đã ứng tuyển công việc này rồi.");
            response.sendRedirect(request.getContextPath() + "/candidate/applied-jobs");
            return;
        }

        // XỬ LÝ FILE CV (GIỐNG TOPCV)
        String finalCvPath = candidate.getCvFile(); // Mặc định dùng CV cũ
        Part filePart = request.getPart("cvFile"); 
        
        if (filePart != null && filePart.getSize() > 0) {
            // Nếu người dùng upload file mới
            String uploadDirPath = getServletContext().getRealPath("/uploads/cv/applied");
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String fileName = "applied_cv_" + UUID.randomUUID() + getExtension(filePart.getSubmittedFileName());
            filePart.write(uploadDirPath + File.separator + fileName);
            finalCvPath = request.getContextPath() + "/uploads/cv/applied/" + fileName;
        }

        if (finalCvPath == null || finalCvPath.isEmpty()) {
            request.setAttribute("error", "Vui lòng tải lên CV để ứng tuyển.");
            request.getRequestDispatcher("/views/candidate/apply-job.jsp").forward(request, response);
            return;
        }

        // LƯU VÀO DATABASE
        Application application = new Application();
        application.setJob(job);
        application.setCandidate(candidate);
        application.setCvFile(finalCvPath); // Lưu vào cột cv_file của bảng Applications
        application.setApplyDate(LocalDateTime.now());
        application.setUpdatedDate(LocalDateTime.now());
        application.setStatus("APPLIED");
        application.setNote(note.isEmpty() ? null : note);

        application = applicationDAO.save(application);
        response.sendRedirect(request.getContextPath() + "/candidate/application-detail?id=" + application.getId());
    }

    private String getExtension(String fileName) {
        return fileName.substring(fileName.lastIndexOf("."));
    }

    private Integer parseInteger(String value) {
        try { return Integer.valueOf(value); } catch (Exception e) { return null; }
    }

    private String trim(String value) { return value == null ? "" : value.trim(); }

    private User getCurrentUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        User user = (User) session.getAttribute("currentUser");
        if (user == null || !"candidate".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}