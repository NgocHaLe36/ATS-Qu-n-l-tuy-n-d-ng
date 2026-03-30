package com.ats.dao;

import java.util.List;

import com.ats.entity.AiScore;

public interface AiScoreDAO extends BaseDAO<AiScore, Integer> {

    AiScore findByApplicationId(Integer applicationId);

    List<AiScore> findByRecommendation(String recommendation);

    List<AiScore> findTopAiScores();
}