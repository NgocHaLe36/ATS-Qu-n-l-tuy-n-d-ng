package com.ats.dao.impl;

import java.util.List;
import java.util.function.Function;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import com.ats.dao.BaseDAO;
import com.ats.utils.JpaUtils;

public abstract class AbstractDAO<T> implements BaseDAO<T, Integer> {

    private final Class<T> entityClass;

    protected AbstractDAO(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    protected EntityManager getEntityManager() {
        return JpaUtils.getEntityManager();
    }

    protected <R> R execute(Function<EntityManager, R> action) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            R result = action.apply(em);
            tx.commit();
            return result;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Database transaction failed", e);
        } finally {
            em.close();
        }
    }

    @Override
    public T save(T entity) {
        return execute(em -> {
            em.persist(entity);
            return entity;
        });
    }

    @Override
    public T update(T entity) {
        return execute(em -> em.merge(entity));
    }

    @Override
    public boolean deleteById(Integer id) {
        return execute(em -> {
            T entity = em.find(entityClass, id);
            if (entity == null) {
                return false;
            }
            em.remove(entity);
            return true;
        });
    }

    @Override
    public T findById(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(entityClass, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<T> findAll() {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT e FROM " + entityClass.getSimpleName() + " e";
            TypedQuery<T> query = em.createQuery(jpql, entityClass);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}