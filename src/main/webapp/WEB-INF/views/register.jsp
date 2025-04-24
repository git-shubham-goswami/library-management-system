<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Register Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>

<body class="main-bg d-flex align-items-center justify-content-center">

    <div class="glass-card" style="max-width: 500px;">
        <h1>Hello!</h1>
        <h2>Register to get started</h2>

        <% String error = (String) request.getAttribute("error");
           if (error != null) {
        %>
            <p class="text-danger text-center"><%= error %></p>
        <% } %>

        <form action="processRegister" method="post">
            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Phone No</label>
                <input type="number" name="phoneNo" class="form-control" required>
            </div>

            <div class="mb-4">
                <label class="form-label">Address</label>
                <input type="text" name="address" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-success w-100">Register</button>
        </form>
    </div>

</body>
</html>
