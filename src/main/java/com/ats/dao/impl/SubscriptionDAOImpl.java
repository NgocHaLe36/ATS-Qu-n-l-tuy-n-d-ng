package com.ats.dao.impl;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.SubscriptionDAO;
import com.ats.entity.Subscription;

public class SubscriptionDAOImpl extends AbstractDAO<Subscription> implements SubscriptionDAO {

    public SubscriptionDAOImpl() {
        super(Subscription.class);
    }

    @Override
    public List<Subscription> findByUserId(Integer userId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Subscription> query = em.createQuery(
                "SELECT s FROM Subscription s " +
                "JOIN FETCH s.user " +
                "JOIN FETCH s.plan " +
                "WHERE s.user.id = :userId " +
                "ORDER BY s.startDate DESC",
                Subscription.class
            );
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Subscription findActiveByUserId(Integer userId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Subscription> query = em.createQuery(
                "SELECT s FROM Subscription s " +
                "JOIN FETCH s.user " +
                "JOIN FETCH s.plan " +
                "WHERE s.user.id = :userId " +
                "AND LOWER(s.status) = :status " +
                "AND s.endDate >= :now " +
                "ORDER BY s.endDate DESC",
                Subscription.class
            );
            query.setParameter("userId", userId);
            query.setParameter("status", "active");
            query.setParameter("now", LocalDateTime.now());
            query.setMaxResults(1);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Subscription> findByStatus(String status) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Subscription> query = em.createQuery(
                "SELECT s FROM Subscription s " +
                "JOIN FETCH s.user " +
                "JOIN FETCH s.plan " +
                "WHERE s.status = :status " +
                "ORDER BY s.startDate DESC",
                Subscription.class
            );
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    @Override
    public Subscription update(Subscription entity) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Subscription updatedEntity = em.merge(entity); // Lưu kết quả merge
            em.getTransaction().commit();
            return updatedEntity; // Trả về đối tượng đã update
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Subscription save(Subscription entity) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.flush(); // Đẩy dữ liệu xuống DB để sinh ID ngay lập tức
            em.getTransaction().commit();
            return entity; // Trả về entity đã có ID
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
    
    @Override
    public Subscription findById(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Subscription.class, id);
        } finally {
            em.close();
        }
    }
}