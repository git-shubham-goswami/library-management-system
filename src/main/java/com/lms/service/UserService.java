package com.lms.service;

import java.util.List;

import com.lms.model.User;

public interface UserService {
	
	public void save(User user);
	
	public User getById(int id);
	
	public User getByEmail(String email);
	
	public List<User> getAll();
	
	public void delete(int id);
	
	public User update(User user);
	

}
