<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Prodotto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/index.css">
</head>
<body>

<%
    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    int count = (carrello != null) ? carrello.size() : 0;
    String utenteEmail = (String) session.getAttribute("utenteEmail");
%>

<div class="aquarium">
    <div class="fish fish1">🐟</div>
    <div class="fish fish2">🐠</div>
    <div class="fish fish3">🐟</div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark glass-nav sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">Fishing Lab 🎣</a>

        <form class="d-flex mx-auto" action="${pageContext.request.contextPath}/CercaServlet" method="GET" style="width: 100%; max-width: 400px;">
            <input class="form-control me-2" type="search" name="ricerca" placeholder="Cerca attrezzatura...">
            <button class="btn btn-outline-light" type="submit">🔍</button>
        </form>

        <div class="navbar-nav align-items-center">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/carrello.jsp">🛒 Carrello 
                <span id="carrello-badge" class="badge bg-danger rounded-pill"><%= count > 0 ? count : "" %></span>
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

<div class="container my-5" style="z-index: 5; position: relative;">
    <h2 class="text-white mb-4">Il nostro Catalogo</h2>
    <div class="row">
        <% 
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
            if (prodotti != null) {
                for (Prodotto p : prodotti) {
        %>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 glass-card border-0 p-3">
                        <img src="${pageContext.request.contextPath}/images/<%= p.getImmagine() %>" class="card-img-top" style="height: 180px; object-fit: contain;">
                        <div class="card-body text-center">
                            <h5 class="fw-bold"><%= p.getNomeProdotto() %></h5>
                            
                            <p class="fs-5 fw-bold text-primary">€ <%= String.format("%.2f", p.getPrezzoScontato()) %></p>
                            
                            <button type="button" onclick="aggiungiAlCarrello('<%= p.getIdProdotto() %>')" class="btn btn-primary btn-sm">Aggiungi</button>
                        </div>
                    </div>
                </div>
        <%      } 
            }
        %>
    </div>
</div>

<script>
function aggiungiAlCarrello(id) {
    fetch('${pageContext.request.contextPath}/CarrelloServlet?idProdotto=' + id, {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(response => response.text())
    .then(count => {
        document.getElementById('carrello-badge').innerText = count;
        alert("Prodotto aggiunto al carrello!");
    });
}
</script>
</body>
</html>