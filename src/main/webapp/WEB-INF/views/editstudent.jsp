<%@ page import="com.lms.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>✏️ Edit Student</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg p-4">

    <div class="container d-flex justify-content-center">
        <div class="glass-card p-4 shadow-lg" style="min-width: 350px; max-width: 600px; width: 100%;">
            
            <h2 class="text-center mb-4">🛠️ Update Student Details</h2>

            <%
                User student = (User) request.getAttribute("student");
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
                <div class="alert alert-success text-center" role="alert">
                    <%=msg %>
                </div>
            <%
                }
            %>

            <form action="<%=request.getContextPath()%>/student/edit" method="post">

                <!-- Hidden Fields -->
                <input type="hidden" name="id" value="<%=student.getId()%>"/>
                <input type="hidden" name="password" value="<%=student.getPassword()%>"/>
                <input type="hidden" name="role" value="<%=student.getRole()%>"/>

                <!-- Name -->
                <div class="mb-3">
                    <label class="form-label">👤 Name</label>
                    <input type="text" name="name" class="form-control" value="<%=student.getName()%>" required />
                </div>

                <!-- Email (readonly) -->
                <div class="mb-3">
                    <label class="form-label">📧 Email</label>
                    <input type="email" name="email" class="form-control" value="<%=student.getEmail()%>" readonly />
                </div>

                <!-- Phone Number -->
                <div class="mb-3">
                    <label class="form-label">📞 Phone Number</label>
                    <input type="number" name="phoneNo" class="form-control" value="<%=student.getPhoneNo()%>" required />
                </div>

                <!-- Address -->
                <div class="mb-4">
                    <label class="form-label">🏠 Address</label>
                    <input type="text" name="Address" class="form-control" value="<%=student.getAddress()%>" required />
                </div>

                <!-- Submit -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">💾 Update Student</button>
                </div>
            </form>

        </div>
    </div>

</body>
</html>
