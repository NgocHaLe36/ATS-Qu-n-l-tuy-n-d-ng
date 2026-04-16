package com.ats.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.UserDAO;
import com.ats.entity.User;

public class UserDAOImpl extends AbstractDAO<User> implements UserDAO {

    private static final String RECRUITER_ROLE = "recruiter";

    public UserDAOImpl() {
        super(User.class);
    }

    @Override
    public User findByEmail(String email) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.email = :email",
                User.class
            );
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public User findByEmailAndPassword(String email, String password) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u " +
                "WHERE u.email = :email AND u.password = :password AND u.status = true",
                User.class
            );
            query.setParameter("email", email);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<User> findByRole(String role) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.role = :role ORDER BY u.createdDate DESC",
                User.class
            );
            query.setParameter("role", role);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<User> findActiveUsers() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.status = true ORDER BY u.createdDate DESC",
                User.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByEmail(String email) {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(u) FROM User u WHERE u.email = :email",
                Long.class
            )
            .setParameter("email", email)
            .getSingleResult();

            return count != null && count > 0;
        } finally {
            em.close();
        }
    }
    @Override
    public List<User> findFeaturedRecruiters(int limit) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u " +
                "WHERE u.role = :role " +
                "AND u.status = true " +
                "ORDER BY u.createdDate DESC",
                User.class
            );
            query.setParameter("role", RECRUITER_ROLE);

            if (limit > 0) {
                query.setMaxResults(limit);
            }

            List<User> recruiters = query.getResultList();
            
            // --- ĐOẠN CODE BỔ SUNG ---
            // Ép Hibernate tải danh sách jobs trước khi đóng Session
            for (User recruiter : recruiters) {
                if (recruiter.getJobs() != null) {
                    recruiter.getJobs().size(); 
                }
            }
            // -------------------------

            return recruiters;
        } finally {
            em.close();
        }
    }
    @Override
    public List<User> searchPublicRecruiters(String keyword, int page, int pageSize) {
        EntityManager em = getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder();
            jpql.append("SELECT u FROM User u ");
            jpql.append("WHERE u.role = :role ");
            jpql.append("AND u.status = true ");

            if (hasText(keyword)) {
                jpql.append("AND (");
                jpql.append("LOWER(COALESCE(u.fullName, '')) LIKE :keyword ");
                jpql.append("OR LOWER(COALESCE(u.email, '')) LIKE :keyword ");
                jpql.append("OR LOWER(COALESCE(u.phone, '')) LIKE :keyword");
                jpql.append(") ");
            }
            jpql.append("ORDER BY u.createdDate DESC");

            // --- ĐÂY LÀ DÒNG QUAN TRỌNG ĐỂ HẾT LỖI ĐỎ ---
            TypedQuery<User> query = em.createQuery(jpql.toString(), User.class);
            // --------------------------------------------

            query.setParameter("role", RECRUITER_ROLE);
            if (hasText(keyword)) {
                query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
            }

            int safePage = page <= 0 ? 1 : page;
            int safePageSize = pageSize <= 0 ? 10 : pageSize;

            query.setFirstResult((safePage - 1) * safePageSize);
            query.setMaxResults(safePageSize);

            List<User> recruiters = query.getResultList();
            
            // Ép Hibernate tải danh sách jobs trước khi đóng Session (Lazy Loading)
            for (User recruiter : recruiters) {
                if (recruiter.getJobs() != null) {
                    recruiter.getJobs().size(); 
                }
            }

            return recruiters;
        } finally {
            em.close();
        }
    }
    @Override
    public long countPublicRecruiters(String keyword) {
        EntityManager em = getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder();
            jpql.append("SELECT COUNT(u) FROM User u ");
            jpql.append("WHERE u.role = :role ");
            jpql.append("AND u.status = true ");

            if (hasText(keyword)) {
                jpql.append("AND (");
                jpql.append("LOWER(COALESCE(u.fullName, '')) LIKE :keyword ");
jpql.append("OR LOWER(COALESCE(u.email, '')) LIKE :keyword ");
                jpql.append("OR LOWER(COALESCE(u.phone, '')) LIKE :keyword");
                jpql.append(") ");
            }

            TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
            query.setParameter("role", RECRUITER_ROLE);

            if (hasText(keyword)) {
                query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
            }

            Long count = query.getSingleResult();
            return count == null ? 0 : count;
        } finally {
            em.close();
        }
    }

    @Override
    public User findPublicRecruiterById(Integer recruiterId) {
        if (recruiterId == null) {
            return null;
        }

        EntityManager em = getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u " +
                "WHERE u.id = :recruiterId " +
                "AND u.role = :role " +
                "AND u.status = true",
                User.class
            );
            query.setParameter("recruiterId", recruiterId);
            query.setParameter("role", RECRUITER_ROLE);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
