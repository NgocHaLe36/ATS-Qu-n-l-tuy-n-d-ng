package com.ats.servlet.recruiter.ai;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.AiScoreDAOImpl;
import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.entity.AiScore;
import com.ats.entity.Application;
import com.ats.entity.User;

// SỬA TẠI ĐÂY: Đổi từ /score thành /analyze để khớp với nút bấm trên giao diện
@WebServlet("/recruiter/ai/analyze")
public class AiScoreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();
    private final AiScoreDAOImpl aiScoreDAO = new AiScoreDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra quyền đăng nhập
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        // 2. Lấy applicationId từ URL (?applicationId=...)
        String appIdStr = request.getParameter("applicationId");
        Integer applicationId = parseInteger(appIdStr);
        
        // 3. Tìm thông tin đơn ứng tuyển
        Application application = (applicationId != null) ? applicationDAO.findById(applicationId) : null;

        // 4. Kiểm tra bảo mật: Nếu không tìm thấy hoặc không phải hồ sơ của mình thì đẩy về Pipeline
        if (application == null || !isOwnedApplication(recruiter, application)) {
            response.sendRedirect(request.getContextPath() + "/recruiter/pipeline");
            return;
        }

        // 5. Lấy dữ liệu điểm AI từ Database
        AiScore aiScore = aiScoreDAO.findByApplicationId(applicationId);

        // 6. Đẩy dữ liệu ra trang JSP
        request.setAttribute("application", application);
        request.setAttribute("aiScore", aiScore);
        
        // 7. Chuyển hướng tới file JSP giao diện (Hà hãy chắc chắn file ai-score.jsp nằm đúng thư mục này)
        request.getRequestDispatcher("/views/recruiter/ai/ai-score.jsp").forward(request, response);
    }

    private boolean isOwnedApplication(User recruiter, Application application) {
        return application != null
                && application.getJob() != null
                && application.getJob().getRecruiter() != null
                && recruiter.getId().equals(application.getJob().getRecruiter().getId());
    }

    private Integer parseInteger(String value) {
        try {
            return (value != null) ? Integer.valueOf(value) : null;
        } catch (Exception e) {
            return null;
        }
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