package com.ats.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import com.ats.dao.PaymentDAO;
import com.ats.entity.Payment;

public class PaymentDAOImpl extends AbstractDAO<Payment> implements PaymentDAO {

    public PaymentDAOImpl() {
        super(Payment.class);
    }

    @Override
    public List<Payment> findByUserId(Integer userId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Payment> query = em.createQuery(
                "SELECT p FROM Payment p " +
                "JOIN FETCH p.user " +
                "JOIN FETCH p.subscription s " +
                "JOIN FETCH s.plan " +
                "WHERE p.user.id = :userId " +
                "ORDER BY p.paymentDate DESC",
                Payment.class
            );
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Payment> findBySubscriptionId(Integer subscriptionId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Payment> query = em.createQuery(
                "SELECT p FROM Payment p " +
                "JOIN FETCH p.user " +
                "JOIN FETCH p.subscription s " +
                "JOIN FETCH s.plan " +
                "WHERE s.id = :subscriptionId " +
                "ORDER BY p.paymentDate DESC",
                Payment.class
            );
            query.setParameter("subscriptionId", subscriptionId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Payment findByTransactionCode(String transactionCode) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Payment> query = em.createQuery(
                "SELECT p FROM Payment p " +
                "JOIN FETCH p.user " +
                "JOIN FETCH p.subscription s " +
                "JOIN FETCH s.plan " +
                "WHERE p.transactionCode = :transactionCode",
                Payment.class
            );
            query.setParameter("transactionCode", transactionCode);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Payment> findByStatus(String status) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Payment> query = em.createQuery(
                "SELECT p FROM Payment p " +
                "JOIN FETCH p.user " +
                "JOIN FETCH p.subscription s " +
                "JOIN FETCH s.plan " +
                "WHERE p.status = :status " +
                "ORDER BY p.paymentDate DESC",
                Payment.class
            );
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}