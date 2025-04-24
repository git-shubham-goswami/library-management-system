package com.lms.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lms.model.Book;
import com.lms.model.BookRequest;
import com.lms.model.User;
import com.lms.service.BookRequestService;
import com.lms.service.BookService;
import com.lms.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	BookRequestService requestService;
	
	@Autowired
	BookService bookService;

//               	<------- for index.jsp ------->	
	@RequestMapping(path="/loginPage", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	
//	                <------- for index.jsp ------->	
	@RequestMapping(path="/regPage", method = RequestMethod.GET)
	public String register() {
		return "register";
	
	}
//                	<------- for register.jsp ------->	
	@RequestMapping(path="/processRegister", method = RequestMethod.POST)
	public String doRegister(@ModelAttribute User formUser, Model model) {
		//password encode
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodedPassword = passwordEncoder.encode(formUser.getPassword());
		formUser.setPassword(encodedPassword);
		//setting role
		formUser.setRole("STUDENT");
		//check if user already exist
		User userByEmail = userService.getByEmail(formUser.getEmail());
		if(userByEmail != null) {
			model.addAttribute("error","User Already Exist with this Email!");
			return"login";
		}
		userService.save(formUser); 
		return "redirect:/loginPage";
	}
	
//                   	<------- for login.jsp ------->	
	@RequestMapping(path="/processLogin", method = RequestMethod.POST)
	public String doLogin(@ModelAttribute User formUser, Model model, HttpSession session) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		User dbUser = userService.getByEmail(formUser.getEmail());
		if(dbUser != null) {
			if(dbUser.getEmail().equals(formUser.getEmail())  && passwordEncoder.matches(formUser.getPassword(), dbUser.getPassword()) ) {
				//login successful
				session.setAttribute("logedInUser", dbUser);
				//redirect according to their role
				if(dbUser.getRole().equals("STUDENT")) {
					return "redirect:/student/dashboard";
				}else if(dbUser.getRole().equals("ADMIN")){  
					return "redirect:/admin/dashboard";
				}else {
					model.addAttribute("error", "Invalid role.");
					System.out.println("Invalid role.");
					return "login";
				}
			}else {
				//login failed wrong password
				model.addAttribute("error","Invalid Password");
				System.out.println("Invalid Password");
				return "login";
			}
		}else {
			//Student is null means not found by given id
			model.addAttribute("error","User not exist, Please Register!! ");
			System.out.println("User not exist, Please Register!!");
			return "login";
		}
	}
	
//                   	<------- for studentDashboard.jsp ------->	
	@RequestMapping(path="/student/dashboard", method = RequestMethod.GET)
	public String studentDashboard(HttpSession session, Model model) {
		//check if a user is a student
		User user = (User) session.getAttribute("logedInUser");
		if(user == null || ! user.getRole().equals("STUDENT")) {
			return "redirect:/loginPage";
		}
		return "studentDashboard";
		
		
	}
	
//	                    <------- for adminDashboard.jsp ------->	
	@RequestMapping(path="/admin/dashboard", method = RequestMethod.GET)
	public String adminDashboard(HttpSession session, Model model) {
		//check if a user is a admin
		User user = (User) session.getAttribute("logedInUser");
		if(user == null || ! user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		return "adminDashboard";
	}
	
//	                     <------- for adminDashboard.jsp ------->
	@RequestMapping(path="/admin/createAdminPage", method = RequestMethod.GET)
	public String createAdmin(HttpSession session) {
		User user = (User)session.getAttribute("logedInUser");
		if(user == null || ! user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		return "createadmin";
	}
	
//                     <------- For createAdmin.jsp --------->
	@RequestMapping(path = "/admin/createAdmin", method = RequestMethod.POST)
	public String createAdmin(@ModelAttribute User formUser, Model model, HttpSession session) {
		//password encode
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodePassword = passwordEncoder.encode(formUser.getPassword());
		formUser.setPassword(encodePassword);
		formUser.setRole("ADMIN");
		
    	//check if user already exist
		User userByEmail = userService.getByEmail(formUser.getEmail());
		if(userByEmail != null) {
			model.addAttribute("error","Admin Already Exist with this email!");
			return "createadmin";
		}
		
		userService.save(formUser);
		return "redirect:/loginPage";
	}
	
//                   <------- For adminDashboard.jsp --------->
	@RequestMapping(path = "/admin/book-request", method = RequestMethod.GET)
	public String viewBookRequest(HttpSession session, Model model) {
		User user = (User) session.getAttribute("logedInUser");
		if(user == null || !user.getRole().equals("ADMIN")) {
			return "redirect:/loginPage";
		}
		
		List<BookRequest> allRequest = requestService.gettAll();
		model.addAttribute("requestList",allRequest);
		
		return "adminbookrequests";
	}
	
//                 <------- For adminbookrequests.jsp --------->
	@RequestMapping(path = "/admin/book-request/handle", method = RequestMethod.POST)
	public String handleBookRequest(@RequestParam("id") Long requestId, 
	                                @RequestParam("action") String action,
	                                RedirectAttributes redirectAttributes) {

	    BookRequest request = requestService.getById(requestId);
	 // Set current date
	    Date currentDate = new Date();

	    // Use Calendar to add 15 days
	    Calendar calendar = Calendar.getInstance();
	    calendar.setTime(currentDate);
	    calendar.add(Calendar.DAY_OF_MONTH, 15);

	    if (request != null) {
	        request.setStatus(action);

	        if (action.equals("APPROVED")) {
	            Book book = request.getBook();
	            int currentQty = book.getQuantity();

	            if (currentQty > 0) {
	                book.setQuantity(currentQty - 1);
	                bookService.save(book);
	                request.setSubmitDate(calendar.getTime());
	            } else {
	                // Don't approve if no stock available
	                redirectAttributes.addFlashAttribute("msg", "Cannot approve. Book is out of stock.");
	                return "redirect:/admin/book-request";
	            }
	        }else if(action.equals("WITHDRAW")) {
	        	Book book = request.getBook();
	            int currentQty = book.getQuantity();
	            
	            book.setQuantity(currentQty + 1);
                bookService.save(book);
                
	            requestService.delete(requestId);
            
	        }else {
	        	
	        }

	        requestService.save(request); // Save the request after status change
	        redirectAttributes.addFlashAttribute("msg", "Request " + action.toLowerCase() + " successfully.");
	    }

	    return "redirect:/admin/book-request";
	}

	
	
	@RequestMapping(path = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate(); 
		return "redirect:/loginPage";
	}
	
//                          <------------ Only for one-time use to create admin -------------->
//	@RequestMapping("/createAdminOnce")
//	public String createAdminOnce() {
//	    User admin = new User();
//	    admin.setEmail("admin@gmail.com");
//	    admin.setPassword(new org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder().encode("admin123"));
//	    admin.setRole("ADMIN");
//	    admin.setAddress("Block 4, Ghaziabad");
//	    admin.setName("Admin");
//	    admin.setPhoneNo("9990614212");
//
//	    userService.save(admin);
//	    return "redirect:/loginPage"; // or a success message page
//	}


	
}
