package com.quiz.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.quiz.Entity.QuizEntity;

@Repository
public interface QuizRepository extends JpaRepository<QuizEntity, Integer> {
 
}

