package com.ats.dao;

import java.util.List;

import com.ats.entity.User;

public interface UserDAO extends BaseDAO<User, Integer> {

    User findByEmail(String email);

    User findByEmailAndPassword(String email, String password);

    List<User> findByRole(String role);

    List<User> findActiveUsers();

    boolean existsByEmail(String email);

    // ===== PUBLIC SITE =====
    List<User> findFeaturedRecruiters(int limit);

    List<User> searchPublicRecruiters(String keyword, int page, int pageSize);

    long countPublicRecruiters(String keyword);

    User findPublicRecruiterById(Integer recruiterId);
}