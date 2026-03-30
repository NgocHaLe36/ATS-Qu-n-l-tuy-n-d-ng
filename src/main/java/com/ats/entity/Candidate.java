package com.ats.entity;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "candidates")
public class Candidate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    @Column(name = "avatar", length = 255)
    private String avatar;

    @Column(name = "cv_file", length = 255)
    private String cvFile;

    @Column(name = "experience_year")
    private Integer experienceYear;

    @Column(name = "skills", length = 1000)
    private String skills;

    @Column(name = "education", length = 255)
    private String education;

    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate;

    @OneToMany(mappedBy = "candidate")
    private List<Application> applications;

    public Candidate() {
    }

    public Candidate(Integer id, User user, String avatar, String cvFile, Integer experienceYear, String skills,
            String education, LocalDateTime createdDate) {
        this.id = id;
        this.user = user;
        this.avatar = avatar;
        this.cvFile = cvFile;
        this.experienceYear = experienceYear;
        this.skills = skills;
        this.education = education;
        this.createdDate = createdDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getCvFile() {
        return cvFile;
    }

    public void setCvFile(String cvFile) {
        this.cvFile = cvFile;
    }

    public Integer getExperienceYear() {
        return experienceYear;
    }

    public void setExperienceYear(Integer experienceYear) {
        this.experienceYear = experienceYear;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public List<Application> getApplications() {
        return applications;
    }

    public void setApplications(List<Application> applications) {
        this.applications = applications;
    }
}