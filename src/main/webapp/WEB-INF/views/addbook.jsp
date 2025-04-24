<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg ">

    <div class="glass-card p-5 shadow-lg" style="width: 100%; max-width: 500px;">
        <h2 class="mb-4 text-center">📘 Add a New Book</h2>

        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
            <div class="alert alert-success" role="alert">
                <%= msg %>
            </div>
        <%
            }
        %>

        <form action="<%=request.getContextPath()%>/book/add" method="post">
            <div class="mb-3">
                <label class="form-label">Title</label>
                <input type="text" name="title" class="form-control" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Author</label>
                <input type="text" name="author" class="form-control" required />
            </div>
            <div class="mb-4">
                <label class="form-label">Quantity</label>
                <input type="number" name="quantity" class="form-control" min="1" required />
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-success btn-lg">➕ Add Book</button>
            </div>
        </form>
    </div>

</body>
</html>
