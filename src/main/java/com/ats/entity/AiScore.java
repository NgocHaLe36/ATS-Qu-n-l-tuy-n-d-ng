package com.ats.entity;

import java.time.LocalDateTime;

import javax.persistence.*;

@Entity
@Table(name = "ai_scores")
public class AiScore {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @OneToOne
    @JoinColumn(name = "application_id", nullable = false, unique = true)
    private Application application;

    @Column(name = "ai_score")
    private Integer aiScore;

    @Column(name = "skill_score")
    private Integer skillScore;

    @Column(name = "experience_score")
    private Integer experienceScore;

    @Column(name = "education_score")
    private Integer educationScore;

    @Column(name = "language_score")
    private Integer languageScore;

    @Column(name = "total_score")
    private Integer totalScore;

    @Column(name = "recommendation", length = 255)
    private String recommendation;

    @Column(name = "ai_comment", columnDefinition = "NVARCHAR(MAX)")
    private String aiComment;

    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate;

    public AiScore() {
    }

    public AiScore(Integer id, Application application, Integer aiScore, Integer skillScore, Integer experienceScore,
            Integer educationScore, Integer languageScore, Integer totalScore, String recommendation,
            String aiComment, LocalDateTime createdDate) {
        this.id = id;
        this.application = application;
        this.aiScore = aiScore;
        this.skillScore = skillScore;
        this.experienceScore = experienceScore;
        this.educationScore = educationScore;
        this.languageScore = languageScore;
        this.totalScore = totalScore;
        this.recommendation = recommendation;
        this.aiComment = aiComment;
        this.createdDate = createdDate;
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

    public Integer getAiScore() {
        return aiScore;
    }

    public void setAiScore(Integer aiScore) {
        this.aiScore = aiScore;
    }

    public Integer getSkillScore() {
        return skillScore;
    }

    public void setSkillScore(Integer skillScore) {
        this.skillScore = skillScore;
    }

    public Integer getExperienceScore() {
        return experienceScore;
    }

    public void setExperienceScore(Integer experienceScore) {
        this.experienceScore = experienceScore;
    }

    public Integer getEducationScore() {
        return educationScore;
    }

    public void setEducationScore(Integer educationScore) {
        this.educationScore = educationScore;
    }

    public Integer getLanguageScore() {
        return languageScore;
    }

    public void setLanguageScore(Integer languageScore) {
        this.languageScore = languageScore;
    }

    public Integer getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Integer totalScore) {
        this.totalScore = totalScore;
    }

    public String getRecommendation() {
        return recommendation;
    }

    public void setRecommendation(String recommendation) {
        this.recommendation = recommendation;
    }

    public String getAiComment() {
        return aiComment;
    }

    public void setAiComment(String aiComment) {
        this.aiComment = aiComment;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }
}