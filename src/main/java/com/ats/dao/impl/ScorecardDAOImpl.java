package com.ats.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.ScorecardDAO;
import com.ats.entity.Scorecard;

public class ScorecardDAOImpl extends AbstractDAO<Scorecard> implements ScorecardDAO {

    public ScorecardDAOImpl() {
        super(Scorecard.class);
    }

    @Override
    public Scorecard findByApplicationId(Integer applicationId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Scorecard> query = em.createQuery(
                "SELECT s FROM Scorecard s " +
                "JOIN FETCH s.application a " +
                "WHERE a.id = :applicationId",
                Scorecard.class
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
    public List<Scorecard> findByResult(String result) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Scorecard> query = em.createQuery(
                "SELECT s FROM Scorecard s " +
                "JOIN FETCH s.application " +
                "WHERE s.result = :result " +
                "ORDER BY s.averageScore DESC",
                Scorecard.class
            );
            query.setParameter("result", result);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Scorecard> findTopScorecards() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Scorecard> query = em.createQuery(
                "SELECT s FROM Scorecard s " +
                "JOIN FETCH s.application " +
                "ORDER BY s.averageScore DESC",
                Scorecard.class
            );
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}