<%@page import="com.lms.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg d-flex align-items-center justify-content-center">

    <%
        User user = (User) session.getAttribute("logedInUser");
  	    response.setCharacterEncoding("UTF-8");
    %>

    <div class="glass-card p-4 shadow-lg w-100 text-center" style="max-width: 600px;">
        <h1>Hii, <%= user.getName() %> 👋 </h1>
        <p class="text-muted mb-4">Hey there, book boss 📚✨ — from tracking your requests to managing library actions effortlessly, all from your personalized dashboard, everything you need is right here. Let’s get reading. 📖</p>

        <div class="d-grid gap-3">
            <a href="<%=request.getContextPath()%>/viewBooks" class="btn btn-primary btn-lg">
                📚 View Available Books
            </a>
            <a href="<%=request.getContextPath()%>/requests" class="btn btn-secondary btn-lg">
                📝 View My Requests
            </a>
            <a href="<%=request.getContextPath()%>/myBooks" class="btn btn-success btn-lg">
                📖 My Borrowed Books
            </a>
            <a href="<%=request.getContextPath()%>/logout" class="btn btn-danger btn-lg">
                🔓 Logout
            </a>
        </div>
    </div>

</body>
</html>
