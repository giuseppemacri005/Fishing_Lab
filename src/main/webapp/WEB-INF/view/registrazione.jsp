<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fishing Lab - Registrazione</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(180deg, #001f3f 0%, #004080 50%, #0066cc 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            margin: 0;
        }
        .wave-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            z-index: 10;
            width: 420px;
        }
        .ocean-waves {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 250px;
            z-index: 1;
            pointer-events: none;
        }
        .wave {
            animation: wave-anim 12s cubic-bezier(0.36, 0.45, 0.63, 0.53) infinite;
        }
        @keyframes wave-anim {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }
    </style>
</head>
<body>

<div class="card p-4 shadow-lg wave-card">
    <h3 class="text-center mb-4 fw-bold" style="color: #001f3f;">Crea un Account</h3>
    
    <% if (request.getAttribute("errore") != null) { %>
        <div class="alert alert-danger p-2 text-center" style="background-color: #FF4136; color: white; border: none;">
            <%= request.getAttribute("errore") %>
        </div>
    <% } %>

    <form id="registerForm" action="${pageContext.request.contextPath}/RegistrazioneServlet" method="POST">
        <div class="mb-3">
            <label for="nome" class="form-label fw-semibold" style="color: #001f3f;">Nome</label>
            <input type="text" class="form-control" id="nome" name="nome" required>
        </div>
        <div class="mb-3">
            <label for="cognome" class="form-label fw-semibold" style="color: #001f3f;">Cognome</label>
            <input type="text" class="form-control" id="cognome" name="cognome" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label fw-semibold" style="color: #001f3f;">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label fw-semibold" style="color: #001f3f;">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        
        <button type="submit" class="btn w-100 text-white mb-3 fw-bold" style="background-color: #001f3f;">Registrati</button>
        
        <div class="text-center">
            <span class="text-muted small">Hai già un account?</span>
            <a href="${pageContext.request.contextPath}/LoginServlet" class="small fw-bold text-decoration-none" style="color: #004080;"> Accedi qui</a>
        </div>
    </form>
</div>

<div class="ocean-waves">
    <svg viewBox="0 24 150 28" preserveAspectRatio="none" style="width: 200%; height: 100%;">
        <defs>
            <path id="gentle-wave" d="M-160 44c30 0 58-18 88-18s58 18 88 18 58-18 88-18 58 18 88 18v44h-352z" />
        </defs>
        <g class="wave"><use href="#gentle-wave" x="48" y="0" fill="rgba(255,255,255,0.3)" /></g>
        <g class="wave"><use href="#gentle-wave" x="48" y="5" fill="rgba(255,255,255,0.4)" /></g>
    </svg>
</div>

</body>
</html>