package com.ats.dao;

import java.util.List;

import com.ats.entity.Plan;

public interface PlanDAO extends BaseDAO<Plan, Integer> {

    Plan findByName(String name);

    List<Plan> findAllOrderByPriceAsc();

    List<Plan> findByJobLimitGreaterThanEqual(Integer jobLimit);
}