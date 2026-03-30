package com.ats.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.InterviewDAO;
import com.ats.entity.Interview;

public class InterviewDAOImpl extends AbstractDAO<Interview> implements InterviewDAO {

    public InterviewDAOImpl() {
        super(Interview.class);
    }

    @Override
    public List<Interview> findByApplicationId(Integer applicationId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Interview> query = em.createQuery(
                "SELECT i FROM Interview i " +
                "JOIN FETCH i.application a " +
                "WHERE a.id = :applicationId " +
                "ORDER BY i.interviewDate DESC",
                Interview.class
            );
            query.setParameter("applicationId", applicationId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Interview> findByInterviewer(String interviewer) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Interview> query = em.createQuery(
                "SELECT i FROM Interview i " +
                "JOIN FETCH i.application " +
                "WHERE LOWER(COALESCE(i.interviewer, '')) LIKE :interviewer " +
                "ORDER BY i.interviewDate DESC",
                Interview.class
            );
            query.setParameter("interviewer", "%" + interviewer.trim().toLowerCase() + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Interview> findUpcomingInterviews() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Interview> query = em.createQuery(
                "SELECT i FROM Interview i " +
                "JOIN FETCH i.application " +
                "WHERE i.interviewDate >= CURRENT_TIMESTAMP " +
                "ORDER BY i.interviewDate ASC",
                Interview.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Interview findLatestByApplicationId(Integer applicationId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Interview> query = em.createQuery(
                "SELECT i FROM Interview i " +
                "JOIN FETCH i.application a " +
                "WHERE a.id = :applicationId " +
                "ORDER BY i.interviewDate DESC",
                Interview.class
            );
            query.setParameter("applicationId", applicationId);
            query.setMaxResults(1);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}