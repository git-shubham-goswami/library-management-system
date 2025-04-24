<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg ">

    <div class="glass-card text-center p-5 shadow-lg">
        <h2 class="mb-3">📚 Book Management</h2>
        <p class="text-muted mb-4">
            From adding new titles to reviewing existing inventory, manage your library's book collection with ease.
        </p>

        <div class="d-grid gap-3">
            <a href="addBook" class="btn btn-success btn-lg">➕ Add Book</a>
            <a href="viewBook" class="btn btn-primary btn-lg">📖 View Books</a>
        </div>
    </div>

</body>
</html>
