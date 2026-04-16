package com.ats.servlet.recruiter.candidates;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.ats.dao.impl.*;
import com.ats.entity.*;

@WebServlet("/recruiter/candidates/detail")
public class RecruiterCandidateDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();
    private final InterviewDAOImpl interviewDAO = new InterviewDAOImpl();
    private final ScorecardDAOImpl scorecardDAO = new ScorecardDAOImpl();
    private final AiScoreDAOImpl aiScoreDAO = new AiScoreDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra đăng nhập
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        // 2. Lấy applicationId từ request (tên này phải khớp với link trong JSP)
        String idParam = request.getParameter("applicationId");
        Integer applicationId = parseInteger(idParam);
        
        Application application = (applicationId != null) ? applicationDAO.findById(applicationId) : null;

        // 3. Kiểm tra bảo mật: Nếu ko tìm thấy hoặc ko phải tin của mình thì đẩy về list
        if (application == null || !isOwnedApplication(recruiter, application)) {
            // Chỗ này Hà có thể sửa đường dẫn về /recruiter/pipeline nếu muốn
            response.sendRedirect(request.getContextPath() + "/recruiter/pipeline");
            return;
        }

        // 4. Lấy các dữ liệu liên quan khác
        Interview latestInterview = interviewDAO.findLatestByApplicationId(applicationId);
        Scorecard scorecard = scorecardDAO.findByApplicationId(applicationId);
        AiScore aiScore = aiScoreDAO.findByApplicationId(applicationId);

        // 5. Đẩy dữ liệu ra trang chi tiết
        request.setAttribute("application", application);
        request.setAttribute("candidate", application.getCandidate());
        request.setAttribute("job", application.getJob());
        request.setAttribute("latestInterview", latestInterview);
        request.setAttribute("scorecard", scorecard);
        request.setAttribute("aiScore", aiScore);

        request.getRequestDispatcher("/views/recruiter/candidates/candidate-detail.jsp").forward(request, response);
    }

    private boolean isOwnedApplication(User recruiter, Application application) {
        return application != null && application.getJob() != null 
               && application.getJob().getRecruiter() != null 
               && recruiter.getId().equals(application.getJob().getRecruiter().getId());
    }

    private Integer parseInteger(String value) {
        try { return Integer.valueOf(value); } catch (Exception e) { return null; }
    }

    private User getCurrentRecruiter(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return null;
        }
        return (User) session.getAttribute("currentUser");
    }
}