package com.ats.servlet.recruiter.candidates;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.ats.dao.impl.ApplicationDAOImpl;

@WebServlet("/recruiter/candidates/update-status")
public class UpdateApplicationStatusServlet extends HttpServlet {
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String appIdStr = request.getParameter("id");
        String newStatus = request.getParameter("status");

        if (appIdStr != null && !appIdStr.trim().isEmpty() && newStatus != null) {
            try {
                Integer appId = Integer.parseInt(appIdStr);
                // Cập nhật trạng thái ứng viên
                applicationDAO.updateStatus(appId, newStatus, "Cập nhật bởi nhà tuyển dụng");
                
                // Quay lại trang chi tiết ứng viên vừa xem
                response.sendRedirect(request.getContextPath() + "/recruiter/candidates/detail?applicationId=" + appIdStr);
                return; 
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/recruiter/candidates");
    }
}