<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login Page</title>

    <!-- Bootstrap (optional, if you're using it) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    
    <!-- Your custom CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body class="main-bg">

    <div class="glass-card">
        <h1>Welcome Back!</h1>
        <h2> Glad to see you Again!</h2>

        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <p style="color: red;"><%= error %></p>
        <%
            }
        %>

        <form action="processLogin" method="post" class="d-grid gap-3">
            <input type="email" name="email" placeholder="Email" class="form-control" required>
            <input type="password" name="password" placeholder="Password" class="form-control" required>
            <input type="submit" value="Login" class="btn btn-primary btn-lg">
        </form>
    </div>

</body>
</html>
