<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fishing Lab - Registrazione</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-dark: #001f3f;
            --ocean-blue: #0056b3;
            --sea-foam: #00a8ff;
        }

        body {
            background: linear-gradient(135deg, #001220 0%, #002d54 50%, #004b8d 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            margin: 0;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        /* Card con effetto Glassmorphism avanzato */
        .wave-card {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            z-index: 10;
            width: 100%;
            max-width: 440px;
            transition: transform 0.3s ease;
        }

        /* Focus personalizzato sui campi di testo */
        .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 12px;
            transition: all 0.2s ease-in-out;
        }

        .form-control:focus {
            border-color: var(--sea-foam);
            box-shadow: 0 0 0 0.25rem rgba(0, 168, 255, 0.25);
        }

        /* Bottone moderno */
        .btn-custom {
            background-color: var(--primary-dark);
            color: #ffffff;
            border-radius: 8px;
            padding: 11px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-custom:hover {
            background-color: var(--ocean-blue);
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 86, 179, 0.4);
        }

        .btn-custom:active {
            transform: translateY(0);
        }

        /* Contenitore SVG onde */
        .ocean-waves {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 150px;
            z-index: 1;
            pointer-events: none;
        }

        /* Animazioni differenziate per creare profondità marina */
        .wave1 {
            animation: wave-motion 15s linear infinite;
        }
        .wave2 {
            animation: wave-motion-reverse 10s linear infinite;
            opacity: 0.5;
        }

        @keyframes wave-motion {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        @keyframes wave-motion-reverse {
            0% { transform: translateX(-50%); }
            100% { transform: translateX(0); }
        }
    </style>
</head>
<body>

<div class="card p-4 p-md-5 wave-card">
    <div class="text-center mb-4">
        <h3 class="fw-bold m-0" style="color: var(--primary-dark); letter-spacing: -0.5px;">Crea un Account</h3>
        <p class="text-muted small mt-1">Unisciti a Fishing Lab</p>
    </div>
    
    <% if (request.getAttribute("errore") != null) { %>
        <div class="alert alert-danger p-3 text-center small rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i><%= request.getAttribute("errore") %>
        </div>
    <% } %>

    <form id="registerForm" action="${pageContext.request.contextPath}/RegistrazioneServlet" method="POST">
        <div class="row g-2 mb-3">
            <div class="col-6">
                <label for="nome" class="form-label small fw-bold" style="color: var(--primary-dark);">Nome</label>
                <input type="text" class="form-control" id="nome" name="nome" placeholder="Mario" required>
            </div>
            <div class="col-6">
                <label for="cognome" class="form-label small fw-bold" style="color: var(--primary-dark);">Cognome</label>
                <input type="text" class="form-control" id="cognome" name="cognome" placeholder="Rossi" required>
            </div>
        </div>
        
        <div class="mb-3">
            <label for="email" class="form-label small fw-bold" style="color: var(--primary-dark);">Email</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="nome@esempio.com" required>
        </div>
        
        <div class="mb-4">
            <label for="password" class="form-label small fw-bold" style="color: var(--primary-dark);">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
        </div>
        
        <button type="submit" class="btn btn-custom w-100 mb-3">Registrati</button>
        
        <div class="text-center mt-3">
            <span class="text-muted small">Hai già un account?</span>
            <a href="${pageContext.request.contextPath}/LoginServlet" class="small fw-bold text-decoration-none ms-1" style="color: var(--ocean-blue);">Accedi qui</a>
        </div>
    </form>
</div>

<div class="ocean-waves">
    <svg viewBox="0 24 150 28" preserveAspectRatio="none" style="width: 200%; height: 100%;">
        <defs>
            <path id="gentle-wave" d="M-160 44c30 0 58-18 88-18s58 18 88 18 58-18 88-18 58 18 88 18v44h-352z" />
        </defs>
        <g class="wave1"><use href="#gentle-wave" x="48" y="0" fill="rgba(255,255,255,0.25)" /></g>
        <g class="wave2"><use href="#gentle-wave" x="48" y="5" fill="rgba(255,255,255,0.15)" /></g>
    </svg>
</div>

</body>
</html>