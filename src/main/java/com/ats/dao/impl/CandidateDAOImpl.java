package com.ats.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.CandidateDAO;
import com.ats.entity.Candidate;

public class CandidateDAOImpl extends AbstractDAO<Candidate> implements CandidateDAO {

    public CandidateDAOImpl() {
        super(Candidate.class);
    }

    @Override
    public Candidate findByUserId(Integer userId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Candidate> query = em.createQuery(
                "SELECT c FROM Candidate c JOIN FETCH c.user u WHERE u.id = :userId",
                Candidate.class
            );
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Candidate> searchByKeyword(String keyword) {
        EntityManager em = getEntityManager();
        try {
            String kw = "%" + (keyword == null ? "" : keyword.trim().toLowerCase()) + "%";

            TypedQuery<Candidate> query = em.createQuery(
                "SELECT c FROM Candidate c JOIN FETCH c.user u " +
                "WHERE LOWER(u.fullName) LIKE :kw " +
                "   OR LOWER(u.email) LIKE :kw " +
                "   OR LOWER(COALESCE(c.skills, '')) LIKE :kw " +
                "   OR LOWER(COALESCE(c.education, '')) LIKE :kw " +
                "ORDER BY c.createdDate DESC",
                Candidate.class
            );
            query.setParameter("kw", kw);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Candidate> findLatestCandidates() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Candidate> query = em.createQuery(
                "SELECT c FROM Candidate c JOIN FETCH c.user ORDER BY c.createdDate DESC",
                Candidate.class
            );
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}