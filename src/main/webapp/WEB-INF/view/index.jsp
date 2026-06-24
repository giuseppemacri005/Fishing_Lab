
                    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fishing Lab - Premium Store</title>
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
        }

        /* --- NAVBAR --- */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 8%;
            border-bottom: 1px solid var(--bordo);
            background-color: rgba(10, 17, 24, 0.8);
            backdrop-filter: blur(10px);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: var(--testo);
            letter-spacing: 1px;
        }

        .logo span {
            color: var(--accento);
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .carrello-status {
            text-decoration: none;
            background: var(--bordo);
            color: var(--testo) !important;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            border: 1px solid var(--bordo);
            transition: all 0.3s ease;
            display: inline-block;
        }

        .carrello-status:hover {
            border-color: var(--accento);
            background-color: rgba(0, 229, 255, 0.05);
            transform: translateY(-1px);
        }

        .btn-login-nav {
            display: inline-block;
            text-decoration: none;
            background-color: transparent;
            border: 1px solid var(--accento);
            color: var(--accento) !important;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-login-nav:hover {
            background-color: var(--accento);
            color: #000 !important;
            transform: translateY(-1px);
        }

        .user-welcome {
            color: var(--accento);
            font-size: 14px;
            font-weight: 600;
        }

        /* --- HERO BANNER --- */
        .hero {
            text-align: center;
            padding: 50px 20px;
            background: linear-gradient(180deg, rgba(0,229,255,0.05) 0%, rgba(10,17,24,0) 100%);
        }

        .hero h1 {
            font-size: 38px;
            margin-bottom: 10px;
            font-weight: 800;
        }

        .hero p {
            color: var(--testo-mutato);
            font-size: 16px;
        }

        /* --- CONTENITORE PRINCIPALE --- */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 4% 40px 4%;
            width: 100%;
            flex-grow: 1;
        }

        /* --- GRIGLIA PRODOTTI --- */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
        }

        .product-card {
            background-color: var(--bg-card);
            border: 1px solid var(--bordo);
            border-radius: 16px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s, border-color 0.3s;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .product-card:hover {
            transform: translateY(-5px);
            border-color: var(--accento);
        }

        .product-image {
            height: 200px;
            background-color: #162636;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-image img {
            transform: scale(1.08);
        }

        .product-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background-color: rgba(0, 229, 255, 0.2);
            color: var(--accento);
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            z-index: 2;
        }

        .product-info {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .product-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .product-desc {
            color: var(--testo-mutato);
            font-size: 13px;
            line-height: 1.5;
            margin-bottom: 20px;
            flex-grow: 1;
        }

        .product-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .product-price {
            font-size: 20px;
            font-weight: bold;
            color: var(--prezzo);
        }

        .btn-add {
            background-color: transparent;
            border: 1px solid var(--accento);
            color: var(--accento);
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-add:hover {
            background-color: var(--accento);
            color: #000;
        }

        /* --- FOOTER --- */
        footer {
            text-align: center;
            padding: 30px;
            color: var(--testo-mutato);
            font-size: 14px;
            border-top: 1px solid var(--bordo);
            margin-top: 40px;
        }
    </style>
</head>
<body>

    <header>
        <div class="logo">Fishing<span>Lab</span> Store</div>
        <div class="nav-right">
            
            <a href="carrello.jsp" class="carrello-status">
                🛒 Carrello: <b id="conteggio-carrello">0</b>
            </a>
            
            <% 
                // Controllo sessione utente
                String utenteLoggato = (String) session.getAttribute("userSessionKey"); 
                if (utenteLoggato != null) {
            %>
                <span class="user-welcome">👋 Benvenuto, <%= utenteLoggato %></span>
            <% 
                } else { 
            %>
                <a class="btn btn-outline-light btn-sm fw-bold px-3 ms-2" href="${pageContext.request.contextPath}/LoginServlet">
    <i class="fa-solid fa-user me-1"></i> Accedi
</a>
            <% 
                } 
            %>
        </div>
    </header>

    <section class="hero">
        <h1>Equipaggiamento da Pesca Premium</h1>
        <p>Selezionato dai professionisti. Scegli i tuoi prodotti e aggiungili al carrello.</p>
    </section>

    <div class="container">
        <div class="products-grid">
            <div class="product-card">
                <div class="product-image">
                    <img src="canna_carbon" alt="Carbon Raptor">
                    <span class="product-badge">Canne</span>
                </div>
                <div class="product-info">
                    <div class="product-title">Carbon Raptor 2.40m</div>
                    <div class="product-desc">Canna in carbonio ad alto modulo, perfetta per lo spinning in mare. Leggera e reattiva.</div>
                    <div class="product-footer">
                        <div class="product-price">€ 89.90</div>
                        <button class="btn-add" onclick="aggiungiAlCarrelloAJAX(1, 'Carbon Raptor')">Acquista</button>
                    </div>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <img src="mulinello_Crossfire.jpg" alt="Poseidon 4000 SW">
                    <span class="product-badge">Mulinelli</span>
                </div>
                <div class="product-info">
                    <div class="product-title">Poseidon 4000 SW</div>
                    <div class="product-desc">Mulinello con frizione impermeabile e 9+1 cuscinetti. Resistente alla salsedine.</div>
                    <div class="product-footer">
                        <div class="product-price">€ 124.50</div>
                        <button class="btn-add" onclick="aggiungiAlCarrelloAJAX(2, 'Poseidon 4000 SW')">Acquista</button>
                    </div>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <img src="esca_rapala.jpg" alt="Kraken Jerk 120">
                    <span class="product-badge">Esche</span>
                </div>
                <div class="product-info">
                    <div class="product-title">Kraken Jerk 120</div>
                    <div class="product-desc">Esca artificiale tipo jerkbait ad azione suspending. Colorazione olografica super riflettente.</div>
                    <div class="product-footer">
                        <div class="product-price">€ 14.90</div>
                        <button class="btn-add" onclick="aggiungiAlCarrelloAJAX(3, 'Kraken Jerk 120')">Acquista</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2026 Fishing Lab - Interfaccia Store dinamica JSP & DataSource
    </footer>

    <script>
        let contatoreCarrello = 0;

        function aggiungiAlCarrelloAJAX(idProdotto, nomeProdotto) {
            const datiOrdine = { idProdotto: idProdotto, quantita: 1 };

            fetch('/api/carrello', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(datiOrdine)
            })
            .then(response => {
                if (response.ok) return response.text();
                throw new Error();
            })
            .then(() => {
                alert(`${nomeProdotto} aggiunto al carrello sul database!`);
                aggiornaGraficaCarrello();
            })
            .catch(() => {
                aggiornaGraficaCarrello();
            });
        }

        function aggiornaGraficaCarrello() {
            contatoreCarrello++;
            document.getElementById('conteggio-carrello').innerText = contatoreCarrello;
        }
    </script>
</body>
</html>