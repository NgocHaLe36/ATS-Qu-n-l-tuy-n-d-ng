package com.ats.servlet.recruiter.interview;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ats.dao.impl.ApplicationDAOImpl;
import com.ats.dao.impl.InterviewDAOImpl;
import com.ats.entity.Application;
import com.ats.entity.Interview;
import com.ats.entity.User;

@WebServlet("/recruiter/interviews/save")
public class SaveInterviewScheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ApplicationDAOImpl applicationDAO = new ApplicationDAOImpl();
    private final InterviewDAOImpl interviewDAO = new InterviewDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User recruiter = getCurrentRecruiter(request, response);
        if (recruiter == null) return;

        Integer applicationId = parseInteger(request.getParameter("applicationId"));
        Integer interviewId = parseInteger(request.getParameter("interviewId"));
        Application application = applicationId == null ? null : applicationDAO.findById(applicationId);

        if (!isOwnedApplication(recruiter, application)) {
            response.sendRedirect(request.getContextPath() + "/recruiter/pipeline");
            return;
        }

        String interviewDateStr = trim(request.getParameter("interviewDate"));
        String interviewType = trim(request.getParameter("interviewType"));
        String location = trim(request.getParameter("location"));
        String interviewer = trim(request.getParameter("interviewer"));
        String note = trim(request.getParameter("note"));

        LocalDateTime interviewDate = parseDateTime(interviewDateStr);
        if (interviewDate == null || interviewType.isEmpty() || interviewer.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin lịch phỏng vấn.");
            request.setAttribute("application", application);
            request.getRequestDispatcher("/views/recruiter/interview/schedule-interview.jsp").forward(request, response);
            return;
        }

        Interview interview;
        if (interviewId != null) {
            interview = interviewDAO.findById(interviewId);
            if (interview == null) {
                interview = new Interview();
                interview.setApplication(application);
            }
        } else {
            interview = new Interview();
            interview.setApplication(application);
        }

        interview.setInterviewDate(interviewDate);
        interview.setInterviewType(interviewType);
        interview.setLocation(location.isEmpty() ? null : location);
        interview.setInterviewer(interviewer);
        interview.setNote(note.isEmpty() ? null : note);

        if (interview.getId() == null) {
            interviewDAO.save(interview);
        } else {
            interviewDAO.update(interview);
        }

        applicationDAO.updateStatus(application.getId(), "INTERVIEW", "Đã lên lịch phỏng vấn");
        response.sendRedirect(request.getContextPath() + "/recruiter/pipeline");
    }

    private LocalDateTime parseDateTime(String value) {
        try {
            if (value == null || value.trim().isEmpty()) return null;
            return LocalDateTime.parse(value);
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