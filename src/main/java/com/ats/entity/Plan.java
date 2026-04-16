package com.ats.entity;

import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "plans")
public class Plan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "price", nullable = false)
    private Integer price;

    @Column(name = "duration_days", nullable = false)
    private Integer durationDays;

    @Column(name = "job_limit", nullable = false)
    private Integer jobLimit;

    @Column(name = "description", length = 500)
    private String description;

    @OneToMany(mappedBy = "plan")
    private List<Subscription> subscriptions;

    public Plan() {
    }

    public Plan(Integer id, String name, Integer price, Integer durationDays, Integer jobLimit, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.durationDays = durationDays;
        this.jobLimit = jobLimit;
        this.description = description;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(Integer durationDays) {
        this.durationDays = durationDays;
    }

    public Integer getJobLimit() {
        return jobLimit;
    }

    public void setJobLimit(Integer jobLimit) {
        this.jobLimit = jobLimit;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Subscription> getSubscriptions() {
        return subscriptions;
    }

    public void setSubscriptions(List<Subscription> subscriptions) {
        this.subscriptions = subscriptions;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}