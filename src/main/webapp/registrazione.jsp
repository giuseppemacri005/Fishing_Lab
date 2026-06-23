<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione - ShopOnline</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        body {
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .register-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
        }

        .register-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
            font-weight: 600;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            border-color: #007bff;
            outline: none;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .btn-register:hover {
            background-color: #218838;
        }

        .alert {
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            font-size: 14px;
            text-align: center;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .login-link a {
            color: #007bff;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Crea il tuo Account</h2>

    <%-- Gestione dei messaggi di errore o successo inviati dalla Servlet --%>
    <% 
        String errore = (String) request.getAttribute("errore");
        String successo = (String) request.getAttribute("successo");
        if (errore != null) { 
    %>
        <div class="alert alert-danger"><%= errore %></div>
    <%  } 
        if (successo != null) { 
    %>
        <div class="alert alert-success"><%= successo %></div>
    <%  } %>

    <%-- Il form punta alla servlet che gestirà la logica di registrazione (es. RegistrazioneServlet) --%>
    <form action="RegistrazioneServlet" method="POST" onsubmit="return validaForm()">
        
        <div class="form-group">
            <label for="nome">Nome</label>
            <input type="text" id="nome" name="nome" required placeholder="Inserisci il tuo nome">
        </div>

        <div class="form-group">
            <label for="cognome">Cognome</label>
            <input type="text" id="cognome" name="cognome" required placeholder="Inserisci il tuo cognome">
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required placeholder="esempio@email.com">
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Almeno 8 caratteri">
        </div>

        <div class="form-group">
            <label for="confermaPassword">Conferma Password</label>
            <input type="password" id="confermaPassword" name="confermaPassword" required placeholder="Ripeti la password">
        </div>

        <button type="submit" class="btn-register">Registrati</button>
    </form>

    <div class="login-link">
        Hai già un account? <a href="login.jsp">Accedi qui</a>
    </div>
</div>

<script>
    // Semplice controllo lato client prima dell'invio del form
    function validaForm() {
        const password = document.getElementById("password").value;
        const confermaPassword = document.getElementById("confermaPassword").value;

        if (password.length < 8) {
            alert("La password deve contenere almeno 8 caratteri.");
            return false;
        }

        if (password !== confermaPassword) {
            alert("Le password non corrispondono!");
            return false;
        }

        return true;
    }
</script>

</body>
</html>