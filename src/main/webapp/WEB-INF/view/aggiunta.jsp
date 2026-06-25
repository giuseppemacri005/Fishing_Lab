<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Controllo di sicurezza: verifica se l'utente è loggato ed è un amministratore
    String ruolo = (String) session.getAttribute("utenteRuolo");
    if (ruolo == null || !ruolo.equalsIgnoreCase("admin")) {
        // Se non è admin, lo reindirizza alla servlet di login con un messaggio d'errore
        request.setAttribute("errore", "Accesso negato. Area riservata agli amministratori.");
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fishing Lab - Pannello Admin</title>
    <style>
        /* --- VARIABILI E RESET --- */
        :root {
            --bg-principal: #0a1118;
            --bg-card: #111c26;
            --accento: #00e5ff;
            --accento-hover: #00b8d4;
            --testo: #ffffff;
            --testo-mutato: #8a9cae;
            --bordo: #1c2d3d;
            --prezzo: #4caf50;
            --errore-colore: #ff5252;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--bg-principal);
            color: var(--testo);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* --- CONTENITORE FORM --- */
        .admin-container {
            background-color: var(--bg-card);
            border: 1px solid var(--bordo);
            border-radius: 16px;
            width: 100%;
            max-width: 550px;
            padding: 40px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
            position: relative;
        }

        .admin-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--accento), var(--accento-hover));
            border-radius: 16px 16px 0 0;
        }

        .back-link {
            display: inline-block;
            color: var(--testo-mutato);
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
            transition: color 0.3s;
        }

        .back-link:hover {
            color: var(--accento);
        }

        h2 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
            letter-spacing: 0.5px;
        }

        h2 span {
            color: var(--accento);
        }

        .subtitle {
            color: var(--testo-mutato);
            font-size: 14px;
            margin-bottom: 30px;
        }

        /* --- GRUPPI DI INPUT --- */
        .form-group {
            margin-bottom: 22px;
            display: flex;
            flex-direction: column;
        }

        label {
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--testo);
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            background-color: #0d1721;
            border: 1px solid var(--bordo);
            color: var(--testo);
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            transition: all 0.3s ease;
            width: 100%;
        }

        input:focus, textarea:focus, select:focus {
            border-color: var(--accento);
            box-shadow: 0 0 8px rgba(0, 229, 255, 0.2);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        /* Riga unita per Prezzo e Categoria */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        /* --- MESSAGGI NOTIFICA --- */
        .msg-errore {
            background-color: rgba(255, 82, 82, 0.1);
            border: 1px solid var(--errore-colore);
            color: var(--errore-colore);
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 20px;
            text-align: center;
        }

        /* --- BOTTONE INVIO --- */
        .btn-submit {
            background: var(--accento);
            color: #000;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s;
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(0, 229, 255, 0.2);
        }

        .btn-submit:hover {
            background: var(--accento-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 229, 255, 0.4);
        }

        .btn-submit:active {
            transform: translateY(0);
        }
    </style>
</head>
<body>

    <div class="admin-container">
        <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">← Torna allo Store</a>
        
        <h2>Fishing<span>Lab</span> Panel</h2>
        <p class="subtitle">Inserisci i dettagli qui sotto per caricare un nuovo prodotto nel database.</p>

        <%-- Mostra un messaggio di errore se presente --%>
        <% if (request.getAttribute("errore") != null) { %>
            <div class="msg-errore">
                <%= request.getAttribute("errore") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/GestioneProdottiServlet" method="POST">
            
            <div class="form-group">
                <label for="nome">Nome del Prodotto</label>
                <input type="text" id="nome" name="nome" placeholder="Es. Carbon Raptor 2.40m" required>
            </div>

            <div class="form-group">
                <label for="descrizione">Descrizione</label>
                <textarea id="descrizione" name="descrizione" placeholder="Inserisci le specifiche tecniche, materiali, dimensioni..." required></textarea>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="prezzo">Prezzo (€)</label>
                    <input type="number" id="prezzo" name="prezzo" step="0.01" min="0" placeholder="0.00" required>
                </div>

                <div class="form-group">
                    <label for="categoria">Categoria</label>
                    <select id="categoria" name="categoria" required>
                        <option value="" disabled selected>Seleziona...</option>
                        <option value="Canne">Canne</option>
                        <option value="Mulinelli">Mulinelli</option>
                        <option value="Esche">Esche</option>
                        <option value="Accessori">Accessori</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="immagine">Nome File Immagine</label>
                <input type="text" id="immagine" name="immagine" placeholder="Es. nuova_canna.jpg" required>
                <span style="color: var(--testo-mutato); font-size: 11px; margin-top: 5px;">
                    Assicurati che l'immagine sia inserita nella cartella delle risorse del server.
                </span>
            </div>

            <button type="submit" class="btn-submit">Carica Prodotto nel DB</button>
        </form>
    </div>

</body>
</html>