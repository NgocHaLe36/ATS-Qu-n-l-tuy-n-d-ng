package com.ats.servlet.candidate;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.CandidateDAO;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.entity.Candidate;
import com.ats.entity.User;

@WebServlet("/candidate/save-cv")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 10 * 1024 * 1024,
    maxRequestSize = 20 * 1024 * 1024
)
public class SaveCvServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CandidateDAO candidateDAO = new CandidateDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request, response);
        if (currentUser == null) return;

        Candidate candidate = candidateDAO.findByUserId(currentUser.getId());
        if (candidate == null) {
            response.sendRedirect(request.getContextPath() + "/candidate/profile");
            return;
        }

        Part filePart = request.getPart("cvFile");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "Vui lòng chọn file CV.");
            request.getRequestDispatcher("/views/candidate/upload-cv.jsp").forward(request, response);
            return;
        }

        String submittedFileName = filePart.getSubmittedFileName();
        String extension = getExtension(submittedFileName);

        if (!isCvExtension(extension)) {
            request.setAttribute("error", "Chỉ chấp nhận file CV: pdf, doc, docx.");
            request.getRequestDispatcher("/views/candidate/upload-cv.jsp").forward(request, response);
            return;
        }

        String uploadDirPath = request.getServletContext().getRealPath("/uploads/cv");
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName = "cv_" + currentUser.getId() + "_" + UUID.randomUUID() + extension;
        File savedFile = new File(uploadDir, fileName);

        Files.copy(filePart.getInputStream(), savedFile.toPath(), StandardCopyOption.REPLACE_EXISTING);

        String relativePath = request.getContextPath() + "/uploads/cv/" + fileName;

        candidate.setCvFile(relativePath);
        candidate = candidateDAO.update(candidate);

        request.getSession().setAttribute("currentCandidate", candidate);
        response.sendRedirect(request.getContextPath() + "/candidate/profile");
    }

    private boolean isCvExtension(String ext) {
        String e = ext.toLowerCase();
        return ".pdf".equals(e) || ".doc".equals(e) || ".docx".equals(e);
    }

    private String getExtension(String fileName) {
        if (fileName == null || !fileName.contains(".")) return "";
        return fileName.substring(fileName.lastIndexOf("."));
    }

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