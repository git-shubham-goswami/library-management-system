<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>➕ Create Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="main-bg p-4">

    <div class="container d-flex justify-content-center">
        <div class="glass-card p-4 shadow-lg" >
        
            <h2 class="text-center mb-4">🧑‍💼 Create New Admin</h2>

            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="alert alert-danger text-center" role="alert">
                    <%=error %>
                </div>
            <%
                }
            %>

            <form action="createAdmin" method="post">

                <!-- Name -->
                <div class="mb-3">
                    <label class="form-label">👤 Name</label>
                    <input type="text" class="form-control" name="name" required />
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label class="form-label">📧 Email</label>
                    <input type="email" class="form-control" name="email" required />
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <label class="form-label">🔑 Password</label>
                    <input type="password" class="form-control" name="password" required />
                </div>

                <!-- Phone No -->
                <div class="mb-3">
                    <label class="form-label">📞 Phone No</label>
                    <input type="text" class="form-control" name="phoneNo" required />
                </div>

                <!-- Address -->
                <div class="mb-4">
                    <label class="form-label">🏠 Address</label>
                    <input type="text" class="form-control" name="address" required />
                </div>

                <!-- Submit -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-success">✅ Create Admin</button>
                </div>
            </form>

        </div>
    </div>

</body>
</html>
