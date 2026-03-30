package com.ats.dao;

import java.util.List;

import com.ats.entity.Subscription;

public interface SubscriptionDAO extends BaseDAO<Subscription, Integer> {

    List<Subscription> findByUserId(Integer userId);

    Subscription findActiveByUserId(Integer userId);

    List<Subscription> findByStatus(String status);
}