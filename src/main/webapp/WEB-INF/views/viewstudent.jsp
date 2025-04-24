<%@ page import="com.lms.model.User" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>📚 View Students</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg p-4">

    <div class="container d-flex justify-content-center">
        <div class="glass-card " style="max-width: 1200px;">
            <h2 class="mb-3 text-center">👨‍🎓 Students Registered in the Library</h2>

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
                <div class="alert alert-success text-center" role="alert">
                    <%=msg%>
                </div>
            <%
                }
            %>

            <%
                List<User> studentList = (List<User>) request.getAttribute("studentList");
                if (studentList != null && !studentList.isEmpty()) {
            %>

            <div class="table-responsive rounded-3">
                <table class="table table-hover table-striped table-bordered align-middle text-center table-dark">
                    <thead >
                        <tr>
                            <th>👤 Name</th>
                            <th>📧 Email</th>
                            <th>📞 Phone No</th>
                            <th>🏠 Address</th>
                            <th>📖 View Books</th>
                            <th>⚙️ Action</th>
                        </tr>
                    </thead>
                    <tbody >
                        <%
                            for (User student : studentList) {
                        %>
                        <tr>
                            <td><%=student.getName()%></td>
                            <td><%=student.getEmail()%></td>
                            <td><%=student.getPhoneNo()%></td>
                            <td><%=student.getAddress()%></td>
                            <td>
                                <a class="btn btn-sm btn-outline-primary" 
                                   href="<%=request.getContextPath()%>/student/books?id=<%=student.getId()%>">
                                   📚 Books
                                </a>
                            </td>
                            <td>
                                <a class="btn btn-sm btn-warning me-2" 
                                   href="<%=request.getContextPath()%>/student/edit?id=<%=student.getId()%>">
                                   ✏️ Edit
                                </a>
                                <a class="btn btn-sm btn-danger" 
                                   href="<%=request.getContextPath()%>/student/delete?id=<%=student.getId()%>"
                                   onclick="return confirm('Are you sure you want to delete this student?');">
                                   🗑️ Delete
                                </a>
                            </td>
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
                <p class="text-center text-muted">No students found in the system. 🚫</p>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>
