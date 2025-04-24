<%@page import="com.lms.model.BookRequest"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>📚 Book Requests</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg p-4">

    <div class="container d-flex justify-content-center">
    	<div class="glass-card  shadow-lg" style="max-width: 1200px;">
    	
    	
        <h2 class="mb-4 text-center">📖 All Book Requests</h2>

        <%
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy");
            List<BookRequest> requests = (List<BookRequest>) request.getAttribute("requestList");
        %>

        <% if (requests != null && !requests.isEmpty()) { %>
        <div class="table-responsive" style="border-radius: 12px;">
            <table class="table table-bordered table-hover bg-white shadow table-dark">
                <thead>
                    <tr>
                        <th>📘 Title</th>
                        <th>✍️ Author</th>
                        <th>👤 Requested By</th>
                        <th>📧 Email</th>
                        <th>📅 Request Date</th>
                        <th>⚙️ Status</th>
                        <th>🛠️ Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (BookRequest req : requests) { %>
                        <tr>
                            <td><%=req.getBook().getTitle()%></td>
                            <td><%=req.getBook().getAuthor()%></td>
                            <td><%=req.getUser().getName()%></td>
                            <td><%=req.getUser().getEmail()%></td>
                            <td><%=sdf.format(req.getRequestDate())%></td>
                            <td>
                                <% String status = req.getStatus(); %>
                                <span class="badge 
                                    <%= status.equals("PENDING") ? "bg-warning text-dark" : 
                                        status.equals("APPROVED") ? "bg-success" : 
                                        status.equals("REJECTED") ? "bg-danger" : "bg-secondary" %>">
                                    <%= status %>
                                </span>
                            </td>
                            <td>
                                <% if (status.equals("PENDING")) { %>
                                    <form action="<%=request.getContextPath()%>/admin/book-request/handle" method="post" class="d-inline">
                                        <input type="hidden" name="id" value="<%=req.getId()%>" />
                                        <input type="hidden" name="action" value="APPROVED" />
                                        <button class="btn btn-sm btn-success">✔ Approve</button>
                                    </form>
                                    <form action="<%=request.getContextPath()%>/admin/book-request/handle" method="post" class="d-inline">
                                        <input type="hidden" name="id" value="<%=req.getId()%>" />
                                        <input type="hidden" name="action" value="REJECTED" />
                                        <button class="btn btn-sm btn-danger">✖ Reject</button>
                                    </form>
                                <% } else if (status.equals("APPROVED")) { %>
                                    <form action="<%=request.getContextPath()%>/admin/book-request/handle" method="post" class="d-inline">
                                        <input type="hidden" name="id" value="<%=req.getId()%>" />
                                        <input type="hidden" name="action" value="WITHDRAW" />
                                        <button class="btn btn-sm btn-warning">↩ Withdraw</button>
                                    </form>
                                <% } else { %>
                                    <span class="text-white">No actions</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            </div>
        </div>
        <% } else { %>
            <p class="text-center text-muted">🚫 No book requests found.</p>
        <% } %>
    </div>

</body>
</html>
