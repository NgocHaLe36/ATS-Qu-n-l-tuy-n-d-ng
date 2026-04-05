package com.ats.dao;

import java.util.List;

import com.ats.entity.Application;

public interface ApplicationDAO extends BaseDAO<Application, Integer> {

    List<Application> findByCandidateId(Integer candidateId);

    List<Application> findByJobId(Integer jobId);

    List<Application> findByStatus(String status);

    Application findByJobAndCandidate(Integer jobId, Integer candidateId);

    boolean existsByJobAndCandidate(Integer jobId, Integer candidateId);

    Application updateStatus(Integer applicationId, String status, String note);
    
    Application findByIdAndCandidateId(Integer applicationId, Integer candidateId);

    Application findByIdAndRecruiterId(Integer applicationId, Integer recruiterId);

    Long countByRecruiterId(Integer recruiterId);
    
    Long countByStatusAndRecruiterId(Integer recruiterId, String status);
    
    long countPendingInterviews(Integer recruiterId);
    
    long countAcceptedCandidates(Integer recruiterId);
    
}