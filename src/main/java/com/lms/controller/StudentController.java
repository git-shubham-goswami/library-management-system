package com.lms.controller;

import java.util.ArrayList;
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
import com.lms.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class StudentController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	BookService bookService;
	
	@Autowired
	BookRequestService requestService;
	
//             <------- for adminDashboard.jsp ------->
	@RequestMapping(path = "/admin/studentManagement", method = RequestMethod.GET)
	public String openStudentManagment(HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		if(user==null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		return "studentmanagment";
	}

//              <------- for studentmanagment.jsp ------->
	@RequestMapping(path = "/admin/viewStudent", method = RequestMethod.GET)
	public String openViewStudent(HttpSession session, Model model) {
		User user = (User)session.getAttribute("logedInUser");
		if(user==null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		
		List<User> studentList = new ArrayList<>();
		List<User> users = userService.getAll();
		for(User user2 : users) {
			if(user2.getRole().equals("STUDENT")) {
				studentList.add(user2);
			}
		}
		
		model.addAttribute("studentList",studentList);
		
		return "viewstudent";
	}
	
	@RequestMapping(path = "/admin/addStudent", method = RequestMethod.GET)
	public String addStudent() {
		return "register";
	}

//               <------- for viewstudent.jsp ------->
	@RequestMapping(path = "/student/delete", method = RequestMethod.GET)
	public String deleteStudent(@RequestParam("id") int id, Model model, HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		if(user==null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		userService.delete(id);
		model.addAttribute("msg","Student Deleted");
		return "redirect:/admin/viewStudent";
	}

//                <------- for viewstudent.jsp ------->
	@RequestMapping(path = "/student/edit", method = RequestMethod.GET)
	public String openEditStudent(@RequestParam("id") int id, Model model, HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		if(user==null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		User userbyId = userService.getById(id);
		model.addAttribute("student",userbyId);
		
		return "editstudent";
	}

//                 <------- for editstudent.jsp ------->
	@RequestMapping(path="/student/edit", method = RequestMethod.POST)
	public String editStudent(@RequestParam("id") int id, @ModelAttribute User formStudent, Model model) {
		
		
		userService.update(formStudent);
		model.addAttribute("student",formStudent);
		model.addAttribute("msg","Updated Successful");
		return "editstudent";
	}
	
//                  <------- for studentDashboard.jsp ------->
	@RequestMapping(path = "/viewBooks", method = RequestMethod.GET)
	public String openViewBooks(Model model) {
		List<Book> allBooks = bookService.getAll();
		model.addAttribute("bookList",allBooks);
		return "viewbook";
	}
	
//                   <------- for studentDashboard.jsp ------->
	@RequestMapping(path="/requests", method = RequestMethod.GET)
	public String viewBookRequests(Model model, HttpSession session) {
		User user =(User)session.getAttribute("logedInUser");
		if(user==null || !user.getRole().equals("STUDENT")) {
			return "redirect:/loginPage";
		}
		
		List<BookRequest> requestsByUser = requestService.getRequestByUser(user.getId());
		model.addAttribute("requestList",requestsByUser);
		
		return "studentbookrequests";
	}
	
	
//                 <------- for studentDashboard.jsp ------->
	@RequestMapping(path = "/myBooks", method = RequestMethod.GET)
	public String viewApprovedBooks(Model model, HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		if (user == null || !user.getRole().equals("STUDENT")) {
	        return "redirect:/loginPage";
	    }
		
		model.addAttribute("modelUser",user);
		List<BookRequest> approvedRequests = requestService.getApprovedRequestsByUser(user.getId());
		model.addAttribute("approvedRequests", approvedRequests);
		return "studentbooks";
	}
	
//                <------- for viewstudent.jsp ------->
	@RequestMapping(path = "/student/books", method = RequestMethod.GET)
	public String viewStudentBooks(@RequestParam("id") int userId, Model model, HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		/*
		 * if (user == null || !user.getRole().equals("ADMIN")) { return
		 * "redirect:/loginPage"; }
		 */
		
		User student = userService.getById(userId);
		
		model.addAttribute("modelUser",student);
		List<BookRequest> approvedRequests = requestService.getApprovedRequestsByUser(userId);
		model.addAttribute("approvedRequests", approvedRequests);
		return "studentbooks";
	}
	
//             <------- for studentbook.jsp ------->
	@RequestMapping(path = "/student/book-return", method = RequestMethod.POST)
	public String returnBook(@RequestParam("bookId") Long bookId,
							 @RequestParam("bookRequest") Long bookRequestId,
							 HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		if (user == null || !user.getRole().equals("STUDENT")) {
	        return "redirect:/loginPage";
	    }
		
		//update the quantity in DB
		Book book = bookService.getById(bookId);
		book.setQuantity(book.getQuantity()+1);
		bookService.save(book);
		
		BookRequest bookReq = requestService.getById(bookRequestId);
		bookReq.setStatus("RETURNED");
		requestService.save(bookReq);
		/* requestService.delete(bookReq.getId()); */
		
		return "redirect:/student/books?id=" + user.getId();

	}
}





