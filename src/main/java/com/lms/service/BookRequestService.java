package com.lms.service;

import java.util.List;

import com.lms.model.BookRequest;

public interface BookRequestService {
	
	public void createRequest(Long bookId, int userId);
	
	public List<BookRequest> getPendingRequests();
	
	public List<BookRequest> getRequestByUser(int userId);
	
	public List<BookRequest> gettAll();
	
	public BookRequest getById(Long id);
	
	public void save(BookRequest request);
	
	public List<BookRequest> getApprovedRequestsByUser(int userId);
	
	public void delete(Long id);
	
	

}
