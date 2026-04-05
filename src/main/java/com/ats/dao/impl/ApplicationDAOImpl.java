package com.ats.dao.impl;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.ApplicationDAO;
import com.ats.entity.Application;

public class ApplicationDAOImpl extends AbstractDAO<Application> implements ApplicationDAO {
    
    public ApplicationDAOImpl() {
        super(Application.class);
    }

    @Override
    public List<Application> findByCandidateId(Integer candidateId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Application> query = em.createQuery(
                "SELECT a FROM Application a " +
                "JOIN FETCH a.job j " +
                "JOIN FETCH a.candidate c " +
                "JOIN FETCH c.user " +
                "WHERE c.id = :candidateId " +
                "ORDER BY a.applyDate DESC",
                Application.class
            );
            query.setParameter("candidateId", candidateId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Application> findByJobId(Integer jobId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Application> query = em.createQuery(
                "SELECT a FROM Application a " +
                "JOIN FETCH a.job j " +
                "JOIN FETCH a.candidate c " +
                "JOIN FETCH c.user " +
                "WHERE j.id = :jobId " +
                "ORDER BY a.applyDate DESC",
                Application.class
            );
            query.setParameter("jobId", jobId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Application> findByStatus(String status) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Application> query = em.createQuery(
                "SELECT a FROM Application a " +
                "JOIN FETCH a.job " +
                "JOIN FETCH a.candidate c " +
                "JOIN FETCH c.user " +
                "WHERE a.status = :status " +
                "ORDER BY a.updatedDate DESC, a.applyDate DESC",
                Application.class
            );
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Application findByJobAndCandidate(Integer jobId, Integer candidateId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Application> query = em.createQuery(
                "SELECT a FROM Application a " +
                "JOIN FETCH a.job j " +
                "JOIN FETCH a.candidate c " +
                "JOIN FETCH c.user " +
                "WHERE j.id = :jobId AND c.id = :candidateId",
                Application.class
            );
            query.setParameter("jobId", jobId);
            query.setParameter("candidateId", candidateId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByJobAndCandidate(Integer jobId, Integer candidateId) {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(a) FROM Application a " +
                "WHERE a.job.id = :jobId AND a.candidate.id = :candidateId",
                Long.class
            )
            .setParameter("jobId", jobId)
            .setParameter("candidateId", candidateId)
            .getSingleResult();

            return count != null && count > 0;
        } finally {
            em.close();
        }
    }

    @Override
    public Application updateStatus(Integer applicationId, String status, String note) {
        return execute(em -> {
            Application application = em.find(Application.class, applicationId);
            if (application == null) {
                return null;
            }

            application.setStatus(status);
            application.setNote(note);
            application.setUpdatedDate(LocalDateTime.now());

            return em.merge(application);
        });
    }

    @Override
    public Application findByIdAndCandidateId(Integer applicationId, Integer candidateId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Application> query = em.createQuery(
                "SELECT a FROM Application a " +
                "JOIN FETCH a.job j " +
                "JOIN FETCH a.candidate c " +
                "JOIN FETCH c.user " +
                "WHERE a.id = :applicationId " +
                "AND c.id = :candidateId",
                Application.class
            );
            query.setParameter("applicationId", applicationId);
            query.setParameter("candidateId", candidateId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public Application findByIdAndRecruiterId(Integer applicationId, Integer recruiterId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Application> query = em.createQuery(
                "SELECT a FROM Application a " +
                "JOIN FETCH a.job j " +
                "JOIN FETCH j.recruiter r " +
                "JOIN FETCH a.candidate c " +
                "JOIN FETCH c.user " +
                "WHERE a.id = :applicationId " +
                "AND r.id = :recruiterId",
                Application.class
            );
            query.setParameter("applicationId", applicationId);
            query.setParameter("recruiterId", recruiterId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
    
    @Override
    public Long countByRecruiterId(Integer recruiterId) {
        EntityManager em = getEntityManager();
        try {
            String hql = "SELECT COUNT(a) FROM Application a " +
                         "JOIN a.job j " +
                         "WHERE j.recruiter.id = :recruiterId";
            
            Long result = em.createQuery(hql, Long.class)
                            .setParameter("recruiterId", recruiterId)
                            .getSingleResult();
            
            return (result != null) ? result : 0L;
        } catch (Exception e) {
            return 0L;
        } finally {
            em.close();
        }
    }

    @Override
    public Long countByStatusAndRecruiterId(Integer recruiterId, String status) {
        EntityManager em = getEntityManager();
        try {
            String hql = "SELECT COUNT(a) FROM Application a " +
                         "WHERE a.job.recruiter.id = :recruiterId AND a.status = :status";
            return em.createQuery(hql, Long.class)
                     .setParameter("recruiterId", recruiterId)
                     .setParameter("status", status)
                     .getSingleResult();
        } catch (Exception e) {
            return 0L;
        } finally {
            em.close();
        }
    }

    @Override
    public long countPendingInterviews(Integer recruiterId) {
        EntityManager em = getEntityManager();
        try {
            String hql = "SELECT COUNT(a) FROM Application a " +
                         "WHERE a.job.recruiter.id = :recruiterId AND a.status = 'INTERVIEW'";
            Long result = em.createQuery(hql, Long.class)
                            .setParameter("recruiterId", recruiterId)
                            .getSingleResult();
            return (result != null) ? result : 0L;
        } catch (Exception e) {
            return 0L;
        } finally {
            em.close();
        }
    }

    @Override
    public long countAcceptedCandidates(Integer recruiterId) {
        EntityManager em = getEntityManager();
        try {
            String hql = "SELECT COUNT(a) FROM Application a " +
                         "WHERE a.job.recruiter.id = :recruiterId AND a.status = 'Accepted'";
            Long result = em.createQuery(hql, Long.class)
                            .setParameter("recruiterId", recruiterId)
                            .getSingleResult();
            return (result != null) ? result : 0L;
        } catch (Exception e) {
            return 0L;
        } finally {
            em.close();
        }
    }
}