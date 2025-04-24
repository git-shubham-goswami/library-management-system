<%@page import="com.lms.model.BookRequest"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>📚 My Book Requests</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg p-4">

    <div class="container d-flex justify-content-center">
        <div class="glass-card shadow-lg"  style="max-width: 600px;">
            <h2 class="text-center mb-4">📖 My Book Requests</h2>

            <%
                List<BookRequest> requestList = (List<BookRequest>) request.getAttribute("requestList");
                if (requestList != null && !requestList.isEmpty()) {
            %>

            <div class="table-responsive rounded-3">
                <table class="table table-bordered table-hover text-center align-middle shadow-sm table-dark">
                    <thead>
                        <tr>
                            <th>📘 Title</th>
                            <th>✍️ Author</th>
                            <th>📌 Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (BookRequest requestItem : requestList) {
                                String status = requestItem.getStatus();
                                String badgeClass = status.equals("PENDING") ? "bg-warning text-dark" :
                                                    status.equals("APPROVED") ? "bg-success" :
                                                    status.equals("REJECTED") ? "bg-danger" : "bg-secondary";
                        %>
                        <tr>
                            <td><%= requestItem.getBook().getTitle() %></td>
                            <td><%= requestItem.getBook().getAuthor() %></td>
                            <td><span class="badge <%= badgeClass %> px-3 py-2"><%= status %></span></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <%
                } else {
            %>
                <p class="text-center text-muted">🚫 You have not made any book requests yet.</p>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>
