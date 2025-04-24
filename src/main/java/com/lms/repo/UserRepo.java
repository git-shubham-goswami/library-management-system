package com.lms.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lms.model.User;

public interface UserRepo extends JpaRepository<User, Integer> {
		
	User findByEmail(String email);
}
