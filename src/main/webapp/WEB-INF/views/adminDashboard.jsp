<%@page import="com.lms.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg d-flex align-items-center justify-content-center">
	
	<%
		User user =(User)session.getAttribute("logedInUser");
	%>
	
    <div class="glass-card text-center p-5 shadow-lg">
        <h1 class="mb-3">Welcome, <%=user.getName()%> 👋</h1>
        <p class="text-muted mb-4">Oversee everything from books to users your tools for a smooth library experience are right here.</p>
        
        <div class="d-grid gap-3">
            <a href="bookManagement" class="btn btn-primary btn-lg">📚 Book Management</a>
            <a href="studentManagement" class="btn btn-secondary btn-lg">🎓 Student Management</a>
            <a href="book-request" class="btn btn-success btn-lg">📥 View Requests</a>
            <a href="createAdminPage" class="btn btn-warning btn-lg">👤 Create New Admin</a>
            <a href="<%=request.getContextPath()%>/logout" class="btn btn-danger btn-lg">🚪 Logout</a>
        </div>
    </div>

</body>
</html>
