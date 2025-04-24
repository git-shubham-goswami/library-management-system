# 📚 Library Management System (Spring MVC + JSP)

This is a full-featured Library Management System built using **Spring MVC**, **JSP**, and **Spring Data JPA**. It provides separate dashboards for Admins and Students with various functionalities to manage users and books efficiently.

## 🚀 Technologies Used

- **Java 8+**
- **Spring MVC (Non-Boot)**
- **Spring Data JPA**
- **Hibernate**
- **JSP (Plain JSP without JSTL)**
- **CSS + Bootstrap 5.3**
- **Tomcat 10.1**
- **MySQL**

---

## 🛠️ Features & Functionalities

### 👤 Admin Panel
- **Create Admin:** Add new admin accounts.
- **Manage Students:**
  - View all registered students
  - Edit student information
  - Delete student accounts
- **Manage Books:**
  - Add new books
  - View all books in the collection
  - Edit and delete books
- **Handle Book Requests:**
  - View all incoming book requests from students
  - Approve, Reject, or Withdraw approved requests

### 🎓 Student Panel
- **View Available Books:** Browse all available books with real-time status and request books with a single click.
- **My Requests:** View status of all previously requested books (Pending, Approved, or Rejected).
- **My Books:** View approved book requests and return books when done.

---

## 🖼️ UI Highlights

- **Glassmorphism Theme:** Custom `glass-card` styling for modern, translucent UI.
- **Responsive Design:** Bootstrap-powered layout ensures mobile and desktop friendliness.
- **Dynamic Status Coloring:** Request status (PENDING, APPROVED, REJECTED) highlighted in different colors.

---

## 🗂️ Folder Structure
<pre> ``` ├── src/ │ └── main/ │ └── java/ │ └── com.lms/ │ ├── controller/ │ ├── model/ │ ├── repository/ │ └── service/ ├── webapp/ │ ├── css/ │ ├── jsp/ │ ├── WEB-INF/ │ │ └── ds-servlet.xml │ └── index.jsp ``` </pre>
## 🧑‍💻 How to Run

1. Clone this repo
2. Import it as a **Maven Project** in Eclipse/IntelliJ
3. Set up MySQL database and update DB config in `ds-servlet.xml`
4. Deploy the project on **Tomcat 10.1**
5. Access the app at `http://localhost:8080/[project_name]/`

---

## 🙌 Credits

Created by **[Your Name]** — built with ❤️ using Java & Spring.

---

## 📬 Feedback or Contribution

Feel free to open issues, pull requests or suggestions!
