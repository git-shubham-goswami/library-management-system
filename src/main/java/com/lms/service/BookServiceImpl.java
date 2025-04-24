package com.lms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.Book;
import com.lms.repo.BookRepo;

@Service
public class BookServiceImpl implements BookService{
	
	@Autowired
	BookRepo bookRepo;
	
	@Override
	public void save(Book book) {
			bookRepo.save(book);
	}
	
	@Override
	public Book getById(long id) {
		Book book = bookRepo.findById(id).orElse(null);
		return book;
	}
	
	@Override
	public void delete(long id) {
		bookRepo.deleteById(id);	
	}
	
	@Override
	public List<Book> getAll() {
		List<Book> books = bookRepo.findAll();
		return books;
	}
	
	@Override
	public Book update(Book book) {
		Book saveBook = bookRepo.save(book);
		return saveBook;
	}
	
	@Override
	public Book getByTitleAndAuthor(String title, String author) {
		Book byTitleAndAuthor = bookRepo.findByTitleAndAuthor(title, author);
		return byTitleAndAuthor;
	}

}
