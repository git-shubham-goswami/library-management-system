<%@page import="com.lms.model.Book"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>📖 Edit Book</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg p-4">

    <div class="container d-flex justify-content-center">
        <div class="glass-card mx-auto p-5 shadow-lg" style="max-width: 600px;">
            <h2 class="mb-4 text-center">✏️ Edit Book Details</h2>

            <%
                Book book = (Book) request.getAttribute("dbBook");
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
                <div class="alert alert-success text-center"><%= msg %></div>
            <%
                }
            %>

            <form action="<%=request.getContextPath()%>/book/edit" method="post">
                <input type="hidden" name="id" value="<%= book.getId() %>" />

                <div class="mb-3">
                    <label class="form-label">📚 Title</label>
                    <input type="text" class="form-control" name="title" value="<%= book.getTitle() %>" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">✍️ Author</label>
                    <input type="text" class="form-control" name="author" value="<%= book.getAuthor() %>" required />
                </div>

                <div class="mb-4">
                    <label class="form-label">📦 Quantity</label>
                    <input type="number" class="form-control" name="quantity" value="<%= book.getQuantity() %>" required min="1" />
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg">💾 Update Book</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
