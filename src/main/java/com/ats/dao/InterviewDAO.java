package com.ats.dao;

import java.util.List;

import com.ats.entity.Interview;

public interface InterviewDAO extends BaseDAO<Interview, Integer> {

    List<Interview> findByApplicationId(Integer applicationId);

    List<Interview> findByInterviewer(String interviewer);

    List<Interview> findUpcomingInterviews();

    Interview findLatestByApplicationId(Integer applicationId);
}