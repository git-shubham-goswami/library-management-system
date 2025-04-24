package com.lms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.User;
import com.lms.repo.UserRepo;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserRepo userRepo;

	@Override
	public void save(User user) {
		userRepo.save(user);
	}

	@Override
	public User getById(int id) {

		User stud = userRepo.findById(id).orElse(null);
		return stud;
	}

	@Override
	public User getByEmail(String email) {
		User stud = userRepo.findByEmail(email);
		return stud;
	}

	@Override
	public List<User> getAll() {
		List<User> users = userRepo.findAll();
		return users;
	}

	@Override
	public void delete(int id) {
		userRepo.deleteById(id);
	}
	
	@Override
	public User update(User user) {
		User dbUser = userRepo.findById(user.getId()).orElse(null);
		dbUser.setName(user.getName());
		dbUser.setEmail(user.getEmail());
		dbUser.setPassword(user.getPassword());
		dbUser.setPhoneNo(user.getPhoneNo());
		dbUser.setAddress(user.getAddress());
		dbUser.setRole(user.getRole());
		
		userRepo.save(dbUser);
		return dbUser;
	}
}
