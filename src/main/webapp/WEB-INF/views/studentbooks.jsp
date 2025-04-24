<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.lms.model.BookRequest, com.lms.model.User"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>📘 My Books</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg p-4">

    <div class="container d-flex justify-content-center">
        <div class="glass-card p-4 shadow-lg " style="max-width: 1200px;">
        
            <%
                User user = (User) request.getAttribute("modelUser");
            %>

            <h2 class="mb-4 text-center"><%= user.getName() %>'s Approved Books 📚</h2>

            <%
                List<BookRequest> approvedRequests = (List<BookRequest>) request.getAttribute("approvedRequests");

                if (approvedRequests != null && !approvedRequests.isEmpty()) {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            %>

            <div class="table-responsive rounded-3">
                <table class="table table-bordered table-hover text-center align-middle shadow-sm table-dark">
                    <thead >
                        <tr>
                            <th>📖 Title</th>
                            <th>✍️ Author</th>
                            <th>📅 Requested On</th>
                            <th>📤 Submitted On</th>
                            <th>📌 Status</th>
                            <th>↩️ Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (BookRequest requestItem : approvedRequests) { %>
                        <tr>
                            <td><%= requestItem.getBook().getTitle() %></td>
                            <td><%= requestItem.getBook().getAuthor() %></td>
                            <td><%= sdf.format(requestItem.getRequestDate()) %></td>
                            <td><%= sdf.format(requestItem.getSubmitDate()) %></td>
                            <td style="color: <%= requestItem.getStatus().equals("PENDING") ? "orange" : (requestItem.getStatus().equals("APPROVED") ? "green" : "red") %>;">
                                <strong><%= requestItem.getStatus() %></strong>
                            </td>
                            <td>
                                <form action="<%=request.getContextPath()%>/student/book-return" method="post" class="d-inline">
                                    <input type="hidden" name="bookId" value="<%= requestItem.getBook().getId() %>" />
                                    <input type="hidden" name="bookRequest" value="<%= requestItem.getId() %>" />
                                    <button type="submit" class="btn btn-outline-danger btn-sm">Return</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <% } else { %>
                <div class="alert alert-info text-center mt-4">
                    😕 You have no approved book requests currently.
                </div>
            <% } %>

        </div>
    </div>

</body>
</html>
