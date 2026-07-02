<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fishing Lab - Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/login.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
</head>
<body>

<div class="card p-4 shadow-lg wave-card">
    <h3 class="text-center mb-4 fw-bold" style="color: #001f3f;">Fishing Lab Login</h3>
    
    <% if (request.getAttribute("errore") != null) { %>
        <div class="alert alert-danger p-2 text-center" style="background-color: #FF4136; color: white; border: none;">
            <%= request.getAttribute("errore") %>
        </div>
    <% } %>

    <form id="loginForm" action="${pageContext.request.contextPath}/LoginServlet" method="POST">
        <div class="mb-3">
            <label for="email" class="form-label fw-semibold" style="color: #001f3f;">Email</label>
            <input type="text" class="form-control" id="email" name="email">
            <span id="erroreEmail" class="small fw-bold"></span>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label fw-semibold" style="color: #001f3f;">Password</label>
            <input type="password" class="form-control" id="password" name="password">
            <span id="errorePassword" class="small fw-bold"></span>
        </div>
        
        <button type="submit" class="btn w-100 text-white mb-3 fw-bold" style="background-color: #001f3f;">Accedi</button>
        
        <div class="text-center">
            <span class="text-muted small">Non hai un account?</span>
            <a href="${pageContext.request.contextPath}/RegistrazioneServlet" class="small fw-bold text-decoration-none" style="color: #004080;"> Registrati qui</a>
        </div>
    </form>
</div>

<div class="ocean-waves">
    <svg viewBox="0 24 150 28" preserveAspectRatio="none" style="width: 200%; height: 100%;">
        <defs>
            <path id="gentle-wave" d="M-160 44c30 0 58-18 88-18s58 18 88 18 58-18 88-18 58 18 88 18v44h-352z" />
        </defs>
        <g class="wave">
            <use href="#gentle-wave" x="48" y="0" fill="rgba(255,255,255,0.3)" />
        </g>
        <g class="wave">
            <use href="#gentle-wave" x="48" y="3" fill="rgba(255,255,255,0.15)" />
        </g>
        <g class="wave">
            <use href="#gentle-wave" x="48" y="5" fill="rgba(255,255,255,0.4)" />
        </g>
    </svg>
</div>

<script src="${pageContext.request.contextPath}/scripts/validazione.js"></script>
</body>
</html>