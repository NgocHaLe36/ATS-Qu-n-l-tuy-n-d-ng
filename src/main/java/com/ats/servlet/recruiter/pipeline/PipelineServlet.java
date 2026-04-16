package com.ats.servlet.recruiter.pipeline;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.JobDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Job;
import com.ats.entity.User;

@WebServlet("/recruiter/pipeline")
public class PipelineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final JobDAOImpl jobDAO = new JobDAOImpl();
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); 
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        String status = trim(request.getParameter("status"));
        String queryInput = trim(request.getParameter("query")).toLowerCase();
        Integer jobId = parseInteger(request.getParameter("jobId"));

        List<Application> applications = new ArrayList<>();

        // 1. Lấy dữ liệu gốc
        List<Job> jobs = jobDAO.findByRecruiterId(recruiter.getId());
        for (Job job : jobs) {
            List<Application> jobApps = applicationDAO.findByJobId(job.getId());
            if (jobApps != null) {
                for(Application a : jobApps) {
                    if(a.getCandidate() != null && a.getCandidate().getUser() != null) {
                        a.getCandidate().getUser().getFullName(); 
                    }
                }
                applications.addAll(jobApps);
            }
        }

        // 2. Logic lọc cải tiến
        if (!queryInput.isEmpty() || (!status.isEmpty() && !"all".equalsIgnoreCase(status))) {
            final String finalQuery = queryInput.trim();
            final String finalStatus = status;

            applications = applications.stream().filter(app -> {
                boolean matchQuery = true;
                boolean matchStatus = true;

                if (!finalQuery.isEmpty()) {
                    String fullName = "";
                    String email = "";
                    String jobTitle = "";

                    if (app.getCandidate() != null && app.getCandidate().getUser() != null) {
                        fullName = app.getCandidate().getUser().getFullName().toLowerCase();
                        email = app.getCandidate().getUser().getEmail().toLowerCase();
                    }
                    if (app.getJob() != null) {
                        jobTitle = app.getJob().getTitle().toLowerCase();
                    }
                    
                    // SỬA TẠI ĐÂY: Logic lọc thông minh hơn
                    // 1. Khớp nếu tên bắt đầu bằng từ khóa (VD: "a" khớp "An")
                    // 2. Khớp nếu có từ riêng biệt bắt đầu bằng từ khóa (VD: "a" khớp "Van A")
                    matchQuery = fullName.startsWith(finalQuery) 
                              || fullName.contains(" " + finalQuery) 
                              || email.contains(finalQuery)
                              || jobTitle.contains(finalQuery);
                    
                    System.out.println("LOG: Kiem tra [" + fullName + "] - Ket qua: " + matchQuery);
                }

                if (!finalStatus.isEmpty() && !"all".equalsIgnoreCase(finalStatus)) {
                    String appStatus = (app.getStatus() != null) ? app.getStatus() : "";
                    if ("Interviewing".equalsIgnoreCase(finalStatus)) {
                        matchStatus = appStatus.toLowerCase().startsWith("inter");
                    } else {
                        matchStatus = finalStatus.equalsIgnoreCase(appStatus);
                    }
                }

                return matchQuery && matchStatus; 
            }).collect(Collectors.toList());
        }

        request.setAttribute("applications", applications);
        request.setAttribute("status", status);
        request.setAttribute("query", request.getParameter("query"));
        request.setAttribute("jobId", jobId);

        request.getRequestDispatcher("/views/recruiter/pipeline/pipeline.jsp").forward(request, response);
    }

    private Integer parseInteger(String value) {
        try { return Integer.valueOf(value); } catch (Exception e) { return null; }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private User getCurrentRecruiter(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        User user = (User) session.getAttribute("currentUser");
        if (!"recruiter".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return user;
    }
}