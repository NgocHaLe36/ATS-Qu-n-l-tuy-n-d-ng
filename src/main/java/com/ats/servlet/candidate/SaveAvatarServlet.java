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
import com.ats.dao.UserDAO;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.dao.impl.UserDAOImpl;
import com.ats.entity.Candidate;
import com.ats.entity.User;

@WebServlet("/candidate/save-avatar")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class SaveAvatarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CandidateDAO candidateDAO = new CandidateDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();

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

        Part filePart = request.getPart("avatarFile");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "Vui lòng chọn ảnh đại diện.");
            request.getRequestDispatcher("/views/candidate/upload-avatar.jsp").forward(request, response);
            return;
        }

        String submittedFileName = filePart.getSubmittedFileName();
        String extension = getExtension(submittedFileName);

        if (!isImageExtension(extension)) {
            request.setAttribute("error", "Chỉ chấp nhận file ảnh: jpg, jpeg, png, gif, webp.");
            request.getRequestDispatcher("/views/candidate/upload-avatar.jsp").forward(request, response);
            return;
        }

        String uploadDirPath = request.getServletContext().getRealPath("/uploads/avatars");
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName = "avatar_" + currentUser.getId() + "_" + UUID.randomUUID() + extension;
        File savedFile = new File(uploadDir, fileName);

        Files.copy(filePart.getInputStream(), savedFile.toPath(), StandardCopyOption.REPLACE_EXISTING);

        String relativePath = request.getContextPath() + "/uploads/avatars/" + fileName;

        currentUser.setAvatar(relativePath);
        currentUser = userDAO.update(currentUser);

        candidate.setAvatar(relativePath);
        candidate = candidateDAO.update(candidate);

        HttpSession session = request.getSession();
        session.setAttribute("currentUser", currentUser);
        session.setAttribute("currentCandidate", candidate);

        response.sendRedirect(request.getContextPath() + "/candidate/profile");
    }

    private boolean isImageExtension(String ext) {
        String e = ext.toLowerCase();
        return ".jpg".equals(e) || ".jpeg".equals(e) || ".png".equals(e) || ".gif".equals(e) || ".webp".equals(e);
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