<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fishing Lab - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(180deg, #001122 0%, #001f3f 40%, #004080 100%); min-height: 100vh; margin: 0; overflow-x: hidden; }
        .glass-nav { background: rgba(0, 31, 63, 0.95) !important; backdrop-filter: blur(10px); border-bottom: 1px solid rgba(255, 255, 255, 0.1); }
        .glass-card { background: rgba(255, 255, 255, 0.92); backdrop-filter: blur(5px); transition: 0.3s; }
        .glass-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.3) !important; }
        .aquarium { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 0; pointer-events: none; }
        .fish { position: absolute; font-size: 24px; opacity: 0.35; animation: swim linear infinite; }
        .fish1 { top: 20%; animation-duration: 22s; }
        .fish2 { top: 45%; font-size: 18px; animation-duration: 28s; }
        .fish3 { top: 70%; font-size: 30px; animation-duration: 18s; }
        @keyframes swim { 0% { transform: translateX(105vw); } 100% { transform: translateX(-10vw); } }
        .ocean-waves { position: absolute; bottom: 0; left: 0; width: 100%; height: 100px; z-index: 0; opacity: 0.3; }
    </style>
</head>
<body>

<%
    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    int count = (carrello != null) ? carrello.size() : 0;
    String utenteEmail = (String) session.getAttribute("utenteEmail");
%>

<div class="aquarium">
    <div class="fish fish1">🐟</div><div class="fish fish2">🐠</div><div class="fish fish3">🐟</div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark glass-nav sticky-top" style="z-index: 100;">
    <div class="container">
      <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">Fishing Lab 🎣</a>

<form class="d-flex mx-auto" action="${pageContext.request.contextPath}/CercaServlet" method="GET" style="width: 100%; max-width: 400px;">
    <input class="form-control me-2" type="search" name="ricerca" placeholder="Cerca attrezzatura...">
    <button class="btn btn-outline-light" type="submit">🔍</button>
</form>
        <div class="navbar-nav align-items-center">
            <a class="nav-link text-white position-relative" href="#">🛒 Carrello 
                <% if (count > 0) { %><span class="badge bg-danger rounded-pill"><%= count %></span><% } %>
            </a>
            
            <% if (utenteEmail != null) { %>
                <span class="nav-link text-white fw-bold ms-3">Ciao, <%= utenteEmail %></span>
                <a class="btn btn-outline-danger btn-sm ms-3" href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
            <% } else { %>
                <a class="btn btn-outline-light btn-sm ms-3" href="${pageContext.request.contextPath}/LoginServlet">Accedi</a>
            <% } %>
        </div>
    </div>
</nav>

<div class="container my-5" style="position: relative; z-index: 5;">
    <h2 class="text-white mb-4">Il nostro Catalogo</h2>
    <div class="row">
        <% 
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
            if (prodotti != null && !prodotti.isEmpty()) {
                for (Prodotto p : prodotti) {
        %>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 glass-card border-0 p-3">
                        <img src="${pageContext.request.contextPath}/images/<%= p.getImmagine() %>" class="card-img-top" style="height: 180px; object-fit: contain;">
                        <div class="card-body">
                            <h5 class="fw-bold"><%= p.getNomeProdotto() %></h5>
                            <p class="text-muted small"><%= p.getDescrizione() %></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="fw-bold fs-5 text-primary">€ <%= String.format("%.2f", p.getPrezzoScontato()) %></span>
                                <a href="${pageContext.request.contextPath}/CarrelloServlet?idProdotto=<%= p.getIdProdotto() %>" class="btn btn-primary btn-sm">Aggiungi</a>
                            </div>
                        </div>
                    </div>
                </div>
        <%      } 
            } else { 
        %>
            <div class="alert alert-light w-100 text-center">Nessun prodotto trovato.</div>
        <% } %>
    </div>
</div>

<div class="ocean-waves">
    <svg viewBox="0 24 150 28" preserveAspectRatio="none" style="width: 100%; height: 100%;">
        <path d="M-160 44c30 0 58-18 88-18s58 18 88 18 58-18 88-18 58 18 88 18v44h-352z" fill="white" />
    </svg>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>