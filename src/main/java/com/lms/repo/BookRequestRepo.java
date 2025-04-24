package com.lms.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lms.model.BookRequest;

public interface BookRequestRepo extends JpaRepository<BookRequest, Long> {

	List<BookRequest> findByStatus(String status); //to show pending request to admin
	List<BookRequest> findByUserId(int id); //student can see their request
	List<BookRequest> findByUserIdAndStatus(int userId, String status);
	
	
}
