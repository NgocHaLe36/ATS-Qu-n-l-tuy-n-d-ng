package com.ats.servlet.candidate;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.AiScoreDAO;
import com.ats.dao.ApplicationDAO;
import com.ats.dao.CandidateDAO;
import com.ats.dao.InterviewDAO;
import com.ats.dao.ScorecardDAO;
import com.ats.dao.impl.AiScoreDAOImpl;
import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.CandidateDAOImpl;
import com.ats.dao.impl.InterviewDAOImpl;
import com.ats.dao.impl.ScorecardDAOImpl;
import com.ats.entity.AiScore;
import com.ats.entity.Application;
import com.ats.entity.Candidate;
import com.ats.entity.Interview;
import com.ats.entity.Scorecard;
import com.ats.entity.User;

@WebServlet("/candidate/application-detail")
public class ApplicationDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CandidateDAO candidateDAO = new CandidateDAOImpl();
    private final ApplicationDAO applicationDAO = new ApplicationDAOImpl();
    private final InterviewDAO interviewDAO = new InterviewDAOImpl();
    private final ScorecardDAO scorecardDAO = new ScorecardDAOImpl();
    private final AiScoreDAO aiScoreDAO = new AiScoreDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User currentUser = getCurrentUser(request, response);
        if (currentUser == null) return;

        Candidate candidate = candidateDAO.findByUserId(currentUser.getId());
        Integer applicationId = parseInteger(request.getParameter("id"));

        if (candidate == null || applicationId == null) {
            response.sendRedirect(request.getContextPath() + "/candidate/applied-jobs");
            return;
        }

        Application application = findOwnedApplication(candidate.getId(), applicationId);
        if (application == null) {
            response.sendRedirect(request.getContextPath() + "/candidate/applied-jobs");
            return;
        }

        List<Interview> interviews = interviewDAO.findByApplicationId(applicationId);
        Interview latestInterview = interviewDAO.findLatestByApplicationId(applicationId);
        Scorecard scorecard = scorecardDAO.findByApplicationId(applicationId);
        AiScore aiScore = aiScoreDAO.findByApplicationId(applicationId);

        request.setAttribute("application", application);
        request.setAttribute("interviews", interviews);
        request.setAttribute("latestInterview", latestInterview);
        request.setAttribute("scorecard", scorecard);
        request.setAttribute("aiScore", aiScore);

        request.getRequestDispatcher("/views/candidate/application-detail.jsp").forward(request, response);
    }

    private Application findOwnedApplication(Integer candidateId, Integer applicationId) {
        List<Application> applications = applicationDAO.findByCandidateId(candidateId);
        for (Application app : applications) {
            if (app != null && applicationId.equals(app.getId())) {
                return app;
            }
        }
        return null;
    }

    private Integer parseInteger(String value) {
        try {
            return Integer.valueOf(value);
        } catch (Exception e) {
            return null;
        }
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