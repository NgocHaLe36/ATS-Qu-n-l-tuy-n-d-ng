package com.ats.dao;

import java.util.List;

import com.ats.entity.Scorecard;

public interface ScorecardDAO extends BaseDAO<Scorecard, Integer> {

    Scorecard findByApplicationId(Integer applicationId);

    List<Scorecard> findByResult(String result);

    List<Scorecard> findTopScorecards();
}