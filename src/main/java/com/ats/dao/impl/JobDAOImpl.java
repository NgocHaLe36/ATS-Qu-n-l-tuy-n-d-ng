package com.ats.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.JobDAO;
import com.ats.entity.Job;

public class JobDAOImpl extends AbstractDAO<Job> implements JobDAO {

    private static final String PUBLIC_JOB_STATUS = "OPEN";
    private static final String RECRUITER_ROLE = "recruiter";

    public JobDAOImpl() {
        super(Job.class);
    }

    @Override
    public List<Job> findByRecruiterId(Integer recruiterId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Job> query = em.createQuery(
                "SELECT j FROM Job j " +
                "JOIN FETCH j.recruiter r " +
                "WHERE r.id = :recruiterId " +
                "ORDER BY j.createdDate DESC",
                Job.class
            );
            query.setParameter("recruiterId", recruiterId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Job> findByStatus(String status) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Job> query = em.createQuery(
                "SELECT j FROM Job j " +
                "JOIN FETCH j.recruiter " +
                "WHERE j.status = :status " +
                "ORDER BY j.createdDate DESC",
                Job.class
            );
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Job> findVipJobs() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Job> query = em.createQuery(
                "SELECT j FROM Job j " +
                "JOIN FETCH j.recruiter " +
                "WHERE j.isVip = true " +
                "ORDER BY j.createdDate DESC",
                Job.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Job> searchJobs(String keyword, String location, String status, Boolean isVip) {
        EntityManager em = getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder(
                "SELECT j FROM Job j JOIN FETCH j.recruiter r WHERE 1=1"
            );

            if (hasText(keyword)) {
                jpql.append(" AND (LOWER(j.title) LIKE :keyword");
                jpql.append(" OR LOWER(COALESCE(j.description, '')) LIKE :keyword");
                jpql.append(" OR LOWER(COALESCE(j.requirement, '')) LIKE :keyword)");
            }

            if (hasText(location)) {
                jpql.append(" AND LOWER(COALESCE(j.location, '')) LIKE :location");
            }

            if (hasText(status)) {
                jpql.append(" AND j.status = :status");
            }

            if (isVip != null) {
jpql.append(" AND j.isVip = :isVip");
            }

            jpql.append(" ORDER BY j.isVip DESC, j.createdDate DESC");

            TypedQuery<Job> query = em.createQuery(jpql.toString(), Job.class);

            if (hasText(keyword)) {
                query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
            }

            if (hasText(location)) {
                query.setParameter("location", "%" + location.trim().toLowerCase() + "%");
            }

            if (hasText(status)) {
                query.setParameter("status", status);
            }

            if (isVip != null) {
                query.setParameter("isVip", isVip);
            }

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByRecruiterId(Integer recruiterId) {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(j) FROM Job j WHERE j.recruiter.id = :recruiterId",
                Long.class
            )
            .setParameter("recruiterId", recruiterId)
            .getSingleResult();

            return count == null ? 0 : count;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Job> findLatestPublicJobs(int limit) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Job> query = em.createQuery(
                "SELECT j FROM Job j " +
                "JOIN FETCH j.recruiter r " +
                "WHERE j.status = :jobStatus " +
                "AND r.status = true " +
                "AND r.role = :role " +
                "ORDER BY j.isVip DESC, j.createdDate DESC",
                Job.class
            );
            query.setParameter("jobStatus", PUBLIC_JOB_STATUS);
            query.setParameter("role", RECRUITER_ROLE);

            if (limit > 0) {
                query.setMaxResults(limit);
            }

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Job> findVipPublicJobs(int limit) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Job> query = em.createQuery(
                "SELECT j FROM Job j " +
                "JOIN FETCH j.recruiter r " +
                "WHERE j.status = :jobStatus " +
                "AND j.isVip = true " +
                "AND r.status = true " +
                "AND r.role = :role " +
                "ORDER BY j.createdDate DESC",
                Job.class
            );
            query.setParameter("jobStatus", PUBLIC_JOB_STATUS);
            query.setParameter("role", RECRUITER_ROLE);

            if (limit > 0) {
                query.setMaxResults(limit);
            }

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
public List<Job> searchPublicJobs(String keyword, String location, Boolean isVip,
                                      Integer recruiterId, int page, int pageSize) {
        EntityManager em = getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder();
            jpql.append("SELECT j FROM Job j ");
            jpql.append("JOIN FETCH j.recruiter r ");
            jpql.append("WHERE j.status = :jobStatus ");
            jpql.append("AND r.status = true ");
            jpql.append("AND r.role = :role ");

            if (hasText(keyword)) {
                jpql.append("AND (");
                jpql.append("LOWER(j.title) LIKE :keyword ");
                jpql.append("OR LOWER(COALESCE(j.description, '')) LIKE :keyword ");
                jpql.append("OR LOWER(COALESCE(j.requirement, '')) LIKE :keyword");
                jpql.append(") ");
            }

            if (hasText(location)) {
                jpql.append("AND LOWER(COALESCE(j.location, '')) LIKE :location ");
            }

            if (isVip != null) {
                jpql.append("AND j.isVip = :isVip ");
            }

            if (recruiterId != null) {
                jpql.append("AND r.id = :recruiterId ");
            }

            jpql.append("ORDER BY j.isVip DESC, j.createdDate DESC");

            TypedQuery<Job> query = em.createQuery(jpql.toString(), Job.class);
            query.setParameter("jobStatus", PUBLIC_JOB_STATUS);
            query.setParameter("role", RECRUITER_ROLE);

            if (hasText(keyword)) {
                query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
            }

            if (hasText(location)) {
                query.setParameter("location", "%" + location.trim().toLowerCase() + "%");
            }

            if (isVip != null) {
                query.setParameter("isVip", isVip);
            }

            if (recruiterId != null) {
                query.setParameter("recruiterId", recruiterId);
            }

            int safePage = page <= 0 ? 1 : page;
            int safePageSize = pageSize <= 0 ? 10 : pageSize;

            query.setFirstResult((safePage - 1) * safePageSize);
            query.setMaxResults(safePageSize);

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countPublicJobs(String keyword, String location, Boolean isVip, Integer recruiterId) {
        EntityManager em = getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder();
            jpql.append("SELECT COUNT(j) FROM Job j ");
            jpql.append("JOIN j.recruiter r ");
            jpql.append("WHERE j.status = :jobStatus ");
            jpql.append("AND r.status = true ");
            jpql.append("AND r.role = :role ");

            if (hasText(keyword)) {
                jpql.append("AND (");
                jpql.append("LOWER(j.title) LIKE :keyword ");
                jpql.append("OR LOWER(COALESCE(j.description, '')) LIKE :keyword ");
                jpql.append("OR LOWER(COALESCE(j.requirement, '')) LIKE :keyword");
                jpql.append(") ");
            }

            if (hasText(location)) {
                jpql.append("AND LOWER(COALESCE(j.location, '')) LIKE :location ");
            }

            if (isVip != null) {
                jpql.append("AND j.isVip = :isVip ");
            }

            if (recruiterId != null) {
                jpql.append("AND r.id = :recruiterId ");
            }

            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            query.setParameter("jobStatus", PUBLIC_JOB_STATUS);
            query.setParameter("role", RECRUITER_ROLE);

            if (hasText(keyword)) {
                query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
            }

            if (hasText(location)) {
                query.setParameter("location", "%" + location.trim().toLowerCase() + "%");
            }

            if (isVip != null) {
                query.setParameter("isVip", isVip);
            }

            if (recruiterId != null) {
                query.setParameter("recruiterId", recruiterId);
            }

            Long count = query.getSingleResult();
            return count == null ? 0 : count;
        } finally {
            em.close();
        }
    }

    @Override
    public Job findPublicJobById(Integer jobId) {
        if (jobId == null) {
            return null;
        }

        EntityManager em = getEntityManager();
        try {
            TypedQuery<Job> query = em.createQuery(
                "SELECT j FROM Job j " +
                "JOIN FETCH j.recruiter r " +
                "WHERE j.id = :jobId " +
                "AND j.status = :jobStatus " +
                "AND r.status = true " +
                "AND r.role = :role",
                Job.class
            );
            query.setParameter("jobId", jobId);
            query.setParameter("jobStatus", PUBLIC_JOB_STATUS);
            query.setParameter("role", RECRUITER_ROLE);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
public List<Job> findRelatedPublicJobs(Integer currentJobId, String location, int limit) {
        EntityManager em = getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder();
            jpql.append("SELECT j FROM Job j ");
            jpql.append("JOIN FETCH j.recruiter r ");
            jpql.append("WHERE j.status = :jobStatus ");
            jpql.append("AND r.status = true ");
            jpql.append("AND r.role = :role ");

            if (currentJobId != null) {
                jpql.append("AND j.id <> :currentJobId ");
            }

            if (hasText(location)) {
                jpql.append("AND LOWER(COALESCE(j.location, '')) LIKE :location ");
            }

            jpql.append("ORDER BY j.isVip DESC, j.createdDate DESC");

            TypedQuery<Job> query = em.createQuery(jpql.toString(), Job.class);
            query.setParameter("jobStatus", PUBLIC_JOB_STATUS);
            query.setParameter("role", RECRUITER_ROLE);

            if (currentJobId != null) {
                query.setParameter("currentJobId", currentJobId);
            }

            if (hasText(location)) {
                query.setParameter("location", "%" + location.trim().toLowerCase() + "%");
            }

            if (limit > 0) {
                query.setMaxResults(limit);
            }

            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    @Override
    public void delete(Integer id) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Job job = em.find(Job.class, id);
            if (job != null) {
                em.remove(job);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Job> findPublicJobsByRecruiterId(Integer recruiterId, int page, int pageSize) {
        return searchPublicJobs(null, null, null, recruiterId, page, pageSize);
    }

    @Override
    public long countPublicJobsByRecruiterId(Integer recruiterId) {
        return countPublicJobs(null, null, null, recruiterId);
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }
    
}
