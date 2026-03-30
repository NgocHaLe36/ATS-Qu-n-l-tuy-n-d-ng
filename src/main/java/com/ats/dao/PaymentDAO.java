package com.ats.dao;

import java.util.List;

import com.ats.entity.Payment;

public interface PaymentDAO extends BaseDAO<Payment, Integer> {

    List<Payment> findByUserId(Integer userId);

    List<Payment> findBySubscriptionId(Integer subscriptionId);

    Payment findByTransactionCode(String transactionCode);

    List<Payment> findByStatus(String status);
}