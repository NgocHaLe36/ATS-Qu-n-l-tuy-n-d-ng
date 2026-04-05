package com.ats.dao;

import java.util.List;

import com.ats.entity.Job;

public interface JobDAO extends BaseDAO<Job, Integer> {

    List<Job> findByRecruiterId(Integer recruiterId);

    List<Job> findByStatus(String status);

    List<Job> findVipJobs();

    List<Job> searchJobs(String keyword, String location, String status, Boolean isVip);
    
    void delete(Integer id);

    long countByRecruiterId(Integer recruiterId);

    // ===== PUBLIC SITE =====
    List<Job> findLatestPublicJobs(int limit);

    List<Job> findVipPublicJobs(int limit);

    List<Job> searchPublicJobs(String keyword, String location, Boolean isVip,
                               Integer recruiterId, int page, int pageSize);

    long countPublicJobs(String keyword, String location, Boolean isVip, Integer recruiterId);

    Job findPublicJobById(Integer jobId);

    List<Job> findRelatedPublicJobs(Integer currentJobId, String location, int limit);

    List<Job> findPublicJobsByRecruiterId(Integer recruiterId, int page, int pageSize);

    long countPublicJobsByRecruiterId(Integer recruiterId);
}