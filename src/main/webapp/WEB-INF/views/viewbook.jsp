<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" import="java.util.*, com.lms.model.Book, com.lms.model.User"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>📚 View Books</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg p-4">

    <div class="container d-flex justify-content-center">
        <div class="glass-card" style="max-width: 1200px; margin: auto;">
            <h2 class="text-center mb-4">📚 Library Collection</h2>

            <% 
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    ❌ <span class="ms-2"><%= error %></span>
                </div>
            <% } %>

            <% 
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
                <div class="alert alert-success d-flex align-items-center" role="alert">
                    ✅ <span class="ms-2"><%= msg %></span>
                </div>
            <% } %>

            <%
                User user = (User) session.getAttribute("logedInUser");
                String role = user != null ? user.getRole() : "";

                List<Book> bookList = (List<Book>) request.getAttribute("bookList");
                if (bookList != null && !bookList.isEmpty()) {
            %>

            <div class="table-responsive rounded-3">
                <table class="table table-bordered table-hover text-center align-middle shadow-sm table-dark">
                    <thead >
                        <tr>
                            <th>📘 Title</th>
                            <th>✍️ Author</th>
                            <th>📦 Quantity</th>
                            <th>⚙️ Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Book book : bookList) {
                        %>
                        <tr>
                            <td><%= book.getTitle() %></td>
                            <td><%= book.getAuthor() %></td>
                            <td><%= book.getQuantity() %></td>
                            <td>
                                <% if ("ADMIN".equals(role)) { %>
                                    <div class="d-flex gap-2 justify-content-center flex-wrap">
                                        <a href="<%=request.getContextPath()%>/book/edit?id=<%=book.getId()%>" 
                                           class="btn btn-warning btn-sm" title="Edit Book">✏️ Edit</a>
                                        <a href="<%=request.getContextPath()%>/book/delete?id=<%=book.getId()%>" 
                                           onclick="return confirm('Are you sure you want to delete this book?');" 
                                           class="btn btn-danger btn-sm" title="Delete Book">🗑️ Delete</a>
                                    </div>
                                <% } else if ("STUDENT".equals(role)) { %>
                                    <form action="<%=request.getContextPath()%>/book/request" method="post" class="d-inline">
                                        <input type="hidden" name="bookId" value="<%=book.getId()%>" />
                                        <button type="submit" class="btn btn-outline-success btn-sm" title="Request Book">📥 Request</button>
                                    </form>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <% } else { %>
                <div class="alert alert-info text-center mt-4">
                    😕 No books found in the library yet.
                </div>
            <% } %>
        </div>
    </div>

</body>
</html>
