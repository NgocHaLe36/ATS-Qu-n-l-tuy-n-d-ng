package com.ats.servlet.recruiter.evaluation;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.ScorecardDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Scorecard;
import com.ats.entity.User;

@WebServlet("/recruiter/evaluation/save-scorecard")
public class SaveScorecardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();
    private final ScorecardDAOImpl scorecardDAO = new ScorecardDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Integer applicationId = parseInteger(request.getParameter("applicationId"));
        Application application = applicationId == null ? null : applicationDAO.findById(applicationId);

        if (!isOwnedApplication(recruiter, application)) {
            response.sendRedirect(request.getContextPath() + "/recruiter/pipeline");
            return;
        }

        BigDecimal technical = parseDecimal(request.getParameter("technicalScore"));
        BigDecimal communication = parseDecimal(request.getParameter("communicationScore"));
        BigDecimal attitude = parseDecimal(request.getParameter("attitudeScore"));
        BigDecimal language = parseDecimal(request.getParameter("languageScore"));
        String result = trim(request.getParameter("result"));
        String comment = trim(request.getParameter("comment"));

        if (technical == null || communication == null || attitude == null || language == null) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ điểm đánh giá.");
            request.setAttribute("application", application);
            request.getRequestDispatcher("/views/recruiter/evaluation/scorecard.jsp").forward(request, response);
            return;
        }

        BigDecimal average = technical.add(communication).add(attitude).add(language)
                .divide(new BigDecimal("4"), 2, RoundingMode.HALF_UP);

        if (result.isEmpty()) {
            result = average.compareTo(new BigDecimal("7.00")) >= 0 ? "PASS" : "FAIL";
        }

        Scorecard scorecard = scorecardDAO.findByApplicationId(applicationId);
        if (scorecard == null) {
            scorecard = new Scorecard();
            scorecard.setApplication(application);
        }

        scorecard.setTechnicalScore(technical.intValue());
        scorecard.setCommunicationScore(communication.intValue());
        scorecard.setAttitudeScore(attitude.intValue());
        scorecard.setLanguageScore(language.intValue());
        scorecard.setAverageScore(average);
        scorecard.setResult(result);
        scorecard.setComment(comment.isEmpty() ? null : comment);

        if (scorecard.getId() == null) {
            scorecardDAO.save(scorecard);
        } else {
            scorecardDAO.update(scorecard);
        }

        applicationDAO.updateStatus(applicationId, "EVALUATED", "Đã có scorecard đánh giá");
        response.sendRedirect(request.getContextPath() + "/recruiter/evaluation/scorecard?applicationId=" + applicationId);
    }

    private BigDecimal parseDecimal(String value) {
        try {
            if (value == null || value.trim().isEmpty()) return null;
            return new BigDecimal(value.trim());
        } catch (Exception e) {
            return null;
        }
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

    private String trim(String value) {
        return value == null ? "" : value.trim();
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