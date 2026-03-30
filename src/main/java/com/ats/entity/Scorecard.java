package com.ats.entity;

import java.math.BigDecimal;

import javax.persistence.*;

@Entity
@Table(name = "scorecards")
public class Scorecard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @OneToOne
    @JoinColumn(name = "application_id", nullable = false, unique = true)
    private Application application;

    @Column(name = "technical_score")
    private Integer technicalScore;

    @Column(name = "communication_score")
    private Integer communicationScore;

    @Column(name = "attitude_score")
    private Integer attitudeScore;

    @Column(name = "language_score")
    private Integer languageScore;

    @Column(name = "average_score", precision = 5, scale = 2)
    private BigDecimal averageScore;

    @Column(name = "result", length = 20)
    private String result;

    @Column(name = "comment", length = 1000)
    private String comment;

    public Scorecard() {
    }

    public Scorecard(Integer id, Application application, Integer technicalScore, Integer communicationScore,
            Integer attitudeScore, Integer languageScore, BigDecimal averageScore, String result, String comment) {
        this.id = id;
        this.application = application;
        this.technicalScore = technicalScore;
        this.communicationScore = communicationScore;
        this.attitudeScore = attitudeScore;
        this.languageScore = languageScore;
        this.averageScore = averageScore;
        this.result = result;
        this.comment = comment;
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

    public Integer getTechnicalScore() {
        return technicalScore;
    }

    public void setTechnicalScore(Integer technicalScore) {
        this.technicalScore = technicalScore;
    }

    public Integer getCommunicationScore() {
        return communicationScore;
    }

    public void setCommunicationScore(Integer communicationScore) {
        this.communicationScore = communicationScore;
    }

    public Integer getAttitudeScore() {
        return attitudeScore;
    }

    public void setAttitudeScore(Integer attitudeScore) {
        this.attitudeScore = attitudeScore;
    }

    public Integer getLanguageScore() {
        return languageScore;
    }

    public void setLanguageScore(Integer languageScore) {
        this.languageScore = languageScore;
    }

    public BigDecimal getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(BigDecimal averageScore) {
        this.averageScore = averageScore;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}