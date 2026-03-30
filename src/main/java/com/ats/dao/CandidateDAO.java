package com.ats.dao;

import java.util.List;

import com.ats.entity.Candidate;

public interface CandidateDAO extends BaseDAO<Candidate, Integer> {

    Candidate findByUserId(Integer userId);

    List<Candidate> searchByKeyword(String keyword);

    List<Candidate> findLatestCandidates();
}