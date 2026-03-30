package com.ats.servlet.recruiter.candidates;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.AiScoreDAOImpl;
import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.InterviewDAOImpl;
import com.ats.dao.impl.ScorecardDAOImpl;
import com.ats.entity.AiScore;
import com.ats.entity.Application;
import com.ats.entity.Interview;
import com.ats.entity.Scorecard;
import com.ats.entity.User;

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
        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Integer applicationId = parseInteger(request.getParameter("applicationId"));
        Application application = applicationId == null ? null : applicationDAO.findById(applicationId);

        if (!isOwnedApplication(recruiter, application)) {
            response.sendRedirect(request.getContextPath() + "/recruiter/candidates");
            return;
        }

        Interview latestInterview = interviewDAO.findLatestByApplicationId(applicationId);
        Scorecard scorecard = scorecardDAO.findByApplicationId(applicationId);
        AiScore aiScore = aiScoreDAO.findByApplicationId(applicationId);

        request.setAttribute("application", application);
        request.setAttribute("candidate", application.getCandidate());
        request.setAttribute("job", application.getJob());
        request.setAttribute("latestInterview", latestInterview);
        request.setAttribute("scorecard", scorecard);
        request.setAttribute("aiScore", aiScore);

        request.getRequestDispatcher("/views/recruiter/candidates/candidate-detail.jsp").forward(request, response);
    }

    private boolean isOwnedApplication(User recruiter, Application application) {
        return application != null
                && application.getJob() != null
                && application.getJob().getRecruiter() != null
                && recruiter.getId().equals(application.getJob().getRecruiter().getId());
    }

    private Integer parseInteger(String value) {
        try {
            return Integer.valueOf(value);
        } catch (Exception e) {
            return null;
        }
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