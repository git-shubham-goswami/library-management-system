package com.lms.service;

import java.util.List;

import com.lms.model.Book;

public interface BookService {
	
	public void save(Book book);
	
	public Book update(Book book);
	
	public List<Book> getAll();
	
	public Book getById(long id); 
	
	public void delete(long id);
	
	public Book getByTitleAndAuthor(String title, String author);

}
