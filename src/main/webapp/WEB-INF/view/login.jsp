<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fishing Lab - Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/stile.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container d-flex justify-content-center align-content-center style-login" style="margin-top: 10%;">
    <div class="card p-4 shadow" style="width: 400px;">
        <h3 class="text-center mb-4" style="color: #001f3f;">Fishing Lab Login</h3>
        
        <% if (request.getAttribute("errore") != null) { %>
            <div class="alert alert-danger p-2 text-center" style="background-color: #FF4136; color: white; border: none;">
                <%= request.getAttribute("errore") %>
            </div>
        <% } %>

        <form id="loginForm" action="${pageContext.request.contextPath}/LoginServlet" method="POST">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="text" class="form-control" id="email" name="email">
                <span id="erroreEmail" class="small fw-bold"></span> </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password">
                <span id="errorePassword" class="small fw-bold"></span> </div>
            <button type="submit" class="btn w-100 text-white" style="background-color: #001f3f;">Accedi</button>
        </form>
    </div>
</div>

    <script src="${pageContext.request.contextPath}/scripts/validazione.js"></script>
</body>
</html>