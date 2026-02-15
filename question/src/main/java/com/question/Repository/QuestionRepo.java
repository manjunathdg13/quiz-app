package com.question.Repository;

import java.util.List;


import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.question.Entity.QuestionEntity;
 

@Repository
public interface QuestionRepo extends JpaRepository<QuestionEntity, Integer> {
      List<QuestionEntity> findByCategory(String category);

        @Query(value = "SELECT q.id FROM question q WHERE q.category = :category ORDER BY RAND()", nativeQuery = true)
        List<Integer> findRandomQuestionsByCategory(@Param("category") String category, Pageable pageable);
}