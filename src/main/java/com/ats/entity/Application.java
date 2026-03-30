package com.ats.entity;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "applications")
public class Application {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "job_id", nullable = false)
    private Job job;

    @ManyToOne
    @JoinColumn(name = "candidate_id", nullable = false)
    private Candidate candidate;

    @Column(name = "cv_file", length = 255)
    private String cvFile;

    @Column(name = "apply_date", nullable = false)
    private LocalDateTime applyDate;

    @Column(name = "status", nullable = false, length = 30)
    private String status;

    @Column(name = "note", length = 500)
    private String note;

    @Column(name = "updated_date")
    private LocalDateTime updatedDate;

    @OneToMany(mappedBy = "application")
    private List<Interview> interviews;

    @OneToOne(mappedBy = "application", cascade = CascadeType.ALL)
    private Scorecard scorecard;

    @OneToOne(mappedBy = "application", cascade = CascadeType.ALL)
    private AiScore aiScore;

    public Application() {
    }

    public Application(Integer id, Job job, Candidate candidate, String cvFile, LocalDateTime applyDate, String status,
            String note, LocalDateTime updatedDate) {
        this.id = id;
        this.job = job;
        this.candidate = candidate;
        this.cvFile = cvFile;
        this.applyDate = applyDate;
        this.status = status;
        this.note = note;
        this.updatedDate = updatedDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Job getJob() {
        return job;
    }

    public void setJob(Job job) {
        this.job = job;
    }

    public Candidate getCandidate() {
        return candidate;
    }

    public void setCandidate(Candidate candidate) {
        this.candidate = candidate;
    }

    public String getCvFile() {
        return cvFile;
    }

    public void setCvFile(String cvFile) {
        this.cvFile = cvFile;
    }

    public LocalDateTime getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(LocalDateTime applyDate) {
        this.applyDate = applyDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public List<Interview> getInterviews() {
        return interviews;
    }

    public void setInterviews(List<Interview> interviews) {
        this.interviews = interviews;
    }

    public Scorecard getScorecard() {
        return scorecard;
    }

    public void setScorecard(Scorecard scorecard) {
        this.scorecard = scorecard;
    }

    public AiScore getAiScore() {
        return aiScore;
    }

    public void setAiScore(AiScore aiScore) {
        this.aiScore = aiScore;
    }
}