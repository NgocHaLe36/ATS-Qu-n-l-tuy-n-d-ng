package com.ats.dao;

import java.util.List;

public interface BaseDAO<T, ID> {

    T save(T entity);

    T update(T entity);

    boolean deleteById(ID id);

    T findById(ID id);

    List<T> findAll();
}