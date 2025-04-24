package com.lms.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lms.model.Book;

public interface BookRepo extends JpaRepository<Book, Long> {

	Book findByTitleAndAuthor(String title, String author);

}
