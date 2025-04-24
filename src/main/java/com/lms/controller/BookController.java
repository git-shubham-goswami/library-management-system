package com.lms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lms.model.Book;
import com.lms.model.BookRequest;
import com.lms.model.User;
import com.lms.service.BookRequestService;
import com.lms.service.BookService;

import jakarta.servlet.http.HttpSession;

@Controller
public class BookController {
	
	@Autowired
	BookService bookService;
	
	@Autowired
	BookRequestService requestService;

//  <------- for adminDashboard.jsp ------->	
	@RequestMapping(path = "/admin/bookManagement", method = RequestMethod.GET)
	public String openBookManagement(HttpSession session) {
		User user = (User) session.getAttribute("logedInUser");
		if (user == null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		return "bookmanagement";
	}
	
//             	<------- for Bookmanagement.jsp ------->	
	@RequestMapping(path="/admin/addBook", method = RequestMethod.GET)
	public String openAddBook(HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		if(user==null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		return "addbook";
	}
	
//                <------- for Bookmanagement.jsp ------->
	@RequestMapping(path = "/admin/viewBook", method = RequestMethod.GET)
	public String openViewBook(Model model, HttpSession session) {
		User user = (User) session.getAttribute("logedInUser");
		if (user == null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		List<Book> books = bookService.getAll();
		model.addAttribute("bookList", books);
		return "viewbook";
	}

// 	            <------- for addbook.jsp ------->	
	@RequestMapping(path="/book/add", method = RequestMethod.POST)
	public String addBook(@ModelAttribute Book formBook, Model model, HttpSession session ) {
		//check if book exist then increase quantity by 1
		Book existingBook = bookService.getByTitleAndAuthor(formBook.getTitle(), formBook.getAuthor());
		
		if (existingBook != null) {
	        // Book exists, so increase quantity
	        existingBook.setQuantity(existingBook.getQuantity() + formBook.getQuantity());
	        bookService.save(existingBook); // Save updated existing book
	        model.addAttribute("msg", "Book quantity updated successfully.");
	    } else {
	        // New book
	        bookService.save(formBook);
	        model.addAttribute("msg", "New book added successfully.");
	    }
		
		return "addbook";
	}

	
//              <------- for viewbook.jsp ------->
	@RequestMapping(path="/book/delete",method = RequestMethod.GET)
	public String deleteBook(@RequestParam("id") long id, Model model, HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		if(user==null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		bookService.delete(id);
		model.addAttribute("msg","Book Deleted");
		return "redirect:/admin/viewBook";
	}
	
//                <------- for viewbook.jsp ------->
	@RequestMapping(path="/book/edit", method = RequestMethod.GET)
	public String openEditBook(@RequestParam("id") long id, Model model, HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		if(user==null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		Book dbBook = bookService.getById(id);
		model.addAttribute("dbBook",dbBook);
		return "editbook";
	}
	
//                <------- for editbook.jsp ------->
	@RequestMapping(path = "/book/edit", method = RequestMethod.POST)
	public String editBook(@ModelAttribute Book formBook, Model model) {
		
		Book existingBook = bookService.getByTitleAndAuthor(formBook.getTitle(), formBook.getAuthor());
		if(existingBook != null) {
			// Book exists, so increase quantity
			existingBook.setQuantity(formBook.getQuantity() + existingBook.getQuantity());
			bookService.save(existingBook); // Save updated existing book
			model.addAttribute("dbBook",existingBook);
	        model.addAttribute("msg", "Book quantity updated successfully.");
//	        bookService.delete(existingBook.getId());
		}else {
			bookService.update(formBook);
			model.addAttribute("dbBook",formBook);
			model.addAttribute("msg","Book Updated ");
		}
		
		return "editbook";
	}
	
	
//                   <------- for viewbook.jsp ------->
	@RequestMapping(value = "/book/request", method = RequestMethod.POST)
	public String requestBook(@RequestParam("bookId") Long bookId, HttpSession session, Model model) {
	    User user = (User) session.getAttribute("logedInUser");

	    // Prevent unauthorized access
	    if (user == null || !user.getRole().equals("STUDENT")) {
	        return "redirect:/loginPage"; 
	    }

	    Book book = bookService.getById(bookId);
	    //check if the book exist in DB
	    if (book != null && book.getQuantity() > 0) {
	        List<BookRequest> requests = requestService.getRequestByUser(user.getId());
	        
	        boolean alreadyRequested = false;
	        for (BookRequest req : requests) {
	            if (req.getBook().getId().equals(bookId)) {
	            	if(!req.getStatus().equals("REJECTED") && !(req.getStatus().equals("WITHDRAW") || req.getStatus().equals("APPROVED") || req.getStatus().equals("RETURNED") )){
	            		alreadyRequested = true;
		                break;
	            	}
	            }
	        }
	        if (alreadyRequested) {
	            model.addAttribute("error", "Sorry! You already requested this book, please check the status.");
	        } else {
	            // store this request in DB
	            requestService.createRequest(bookId, user.getId());
	            model.addAttribute("msg", "Book request submitted successfully for: " + book.getTitle());
	        }

	    } else {
	        model.addAttribute("error", "Sorry! Book is not available right now.");
	    }

	    List<Book> bookList = bookService.getAll();
	    model.addAttribute("bookList", bookList);
	    return "viewbook"; // return back to the book list page
	}



}
