<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>🎓 Student Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg p-4">

    <div class="container d-flex justify-content-center">
        <div class="glass-card mx-auto p-5 shadow-lg" style="max-width: 600px;">
            <h2 class="mb-3 text-center">👩‍🎓 Student Management Hub</h2>
            <p class="text-center text-muted">Manage your student data efficiently — view, add, and control it all right here! 💼</p>

            <div class="d-grid gap-3 mt-4">
                <a href="viewStudent" class="btn btn-primary btn-lg">📋 View Students</a>
                <a href="addStudent" class="btn btn-success btn-lg">➕ Add New Student</a>
            </div>
        </div>
    </div>

</body>
</html>
