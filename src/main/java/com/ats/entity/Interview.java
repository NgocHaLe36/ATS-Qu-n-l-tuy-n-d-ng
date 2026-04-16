package com.ats.entity;

import java.time.LocalDateTime;

import javax.persistence.*;

@Entity
@Table(name = "interviews")
public class Interview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "application_id", nullable = false)
    private Application application;

    @Column(name = "interview_date", nullable = false)
    private LocalDateTime interviewDate;

    @Column(name = "interview_type", nullable = false, length = 20)
    private String interviewType;

    @Column(name = "location", length = 200)
    private String location;

    @Column(name = "interviewer", length = 100)
    private String interviewer;

    @Column(name = "note", length = 500)
    private String note;

    public Interview() {
    }

    public Interview(Integer id, Application application, LocalDateTime interviewDate, String interviewType,
            String location, String interviewer, String note) {
        this.id = id;
        this.application = application;
        this.interviewDate = interviewDate;
        this.interviewType = interviewType;
        this.location = location;
        this.interviewer = interviewer;
        this.note = note;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Application getApplication() {
        return application;
    }

    public void setApplication(Application application) {
        this.application = application;
    }

    public LocalDateTime getInterviewDate() {
        return interviewDate;
    }

    public void setInterviewDate(LocalDateTime interviewDate) {
        this.interviewDate = interviewDate;
    }

    public String getInterviewType() {
        return interviewType;
    }

    public void setInterviewType(String interviewType) {
        this.interviewType = interviewType;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getInterviewer() {
        return interviewer;
    }

    public void setInterviewer(String interviewer) {
        this.interviewer = interviewer;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}