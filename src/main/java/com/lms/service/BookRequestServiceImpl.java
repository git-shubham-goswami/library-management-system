package com.lms.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.BookRequest;
import com.lms.repo.BookRequestRepo;

@Service
public class BookRequestServiceImpl implements BookRequestService {
	
	@Autowired
	BookRequestRepo requestRepo;
	
	@Autowired
	BookService bookService;
	
	@Autowired
	UserService userService;
	
	@Override
	public void createRequest(Long bookId, int userId) {
		BookRequest bookRequest = new BookRequest();
		bookRequest.setStatus("PENDING");
		bookRequest.setBook(bookService.getById(bookId));
		bookRequest.setUser(userService.getById(userId));
		bookRequest.setRequestDate(new Date());
		
		requestRepo.save(bookRequest);
		
	}
	
	@Override
	public List<BookRequest> getPendingRequests() {
		List<BookRequest> listByStatus = requestRepo.findByStatus("PENDING");
		return listByStatus;
	}
	
	@Override
	public List<BookRequest> getRequestByUser(int userId) {
		List<BookRequest> listByUserId = requestRepo.findByUserId(userId);
		return listByUserId;
	}
	
	@Override
	public List<BookRequest> gettAll() {
		List<BookRequest> allRequest = requestRepo.findAll();
		return allRequest;
	}
	
	@Override
	public BookRequest getById(Long id) {
		BookRequest request = requestRepo.findById(id).orElse(null);
		return request;
	}
	
	@Override
	public void save(BookRequest request) {
		requestRepo.save(request);
		
	}
	
	@Override
	public List<BookRequest> getApprovedRequestsByUser(int userId) {
	    return requestRepo.findByUserIdAndStatus(userId, "APPROVED");
	}
	
	@Override
	public void delete(Long id) {
		requestRepo.deleteById(id);
		
	}


}
