package com.ats.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.AiScoreDAO;
import com.ats.entity.AiScore;

public class AiScoreDAOImpl extends AbstractDAO<AiScore> implements AiScoreDAO {

    public AiScoreDAOImpl() {
        super(AiScore.class);
    }

    @Override
    public AiScore findByApplicationId(Integer applicationId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<AiScore> query = em.createQuery(
                "SELECT a FROM AiScore a " +
                "JOIN FETCH a.application app " +
                "WHERE app.id = :applicationId",
                AiScore.class
            );
            query.setParameter("applicationId", applicationId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<AiScore> findByRecommendation(String recommendation) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<AiScore> query = em.createQuery(
                "SELECT a FROM AiScore a " +
                "JOIN FETCH a.application " +
                "WHERE LOWER(COALESCE(a.recommendation, '')) = :recommendation " +
                "ORDER BY a.totalScore DESC, a.createdDate DESC",
                AiScore.class
            );
            query.setParameter("recommendation", recommendation.trim().toLowerCase());
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<AiScore> findTopAiScores() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<AiScore> query = em.createQuery(
                "SELECT a FROM AiScore a " +
                "JOIN FETCH a.application " +
                "ORDER BY a.totalScore DESC, a.createdDate DESC",
                AiScore.class
            );
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}