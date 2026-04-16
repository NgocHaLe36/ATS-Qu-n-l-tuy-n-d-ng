package com.ats.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.PlanDAO;
import com.ats.entity.Plan;

public class PlanDAOImpl extends AbstractDAO<Plan> implements PlanDAO {

    public PlanDAOImpl() {
        super(Plan.class);
    }

    @Override
    public Plan findByName(String name) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Plan> query = em.createQuery(
                "SELECT p FROM Plan p WHERE LOWER(p.name) = :name",
                Plan.class
            );
            query.setParameter("name", name.trim().toLowerCase());
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Plan> findAllOrderByPriceAsc() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Plan> query = em.createQuery(
                "SELECT p FROM Plan p ORDER BY p.price ASC",
                Plan.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Plan> findByJobLimitGreaterThanEqual(Integer jobLimit) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Plan> query = em.createQuery(
                "SELECT p FROM Plan p WHERE p.jobLimit >= :jobLimit ORDER BY p.jobLimit ASC",
                Plan.class
            );
            query.setParameter("jobLimit", jobLimit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}