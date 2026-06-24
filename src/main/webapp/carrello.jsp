<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Prodotto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Il mio Carrello</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(180deg, #001122 0%, #001f3f 100%); min-height: 100vh; color: white; }
        .glass-card { background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.1); }
    </style>
</head>
<body class="p-4">

<div class="container glass-card p-5 rounded">
    <h2 class="mb-4">Il tuo Carrello 🛒</h2>
    
    <table class="table table-dark table-hover align-middle">
        <thead>
            <tr>
                <th>Prodotto</th>
                <th>Prezzo</th>
                <th class="text-center">Azioni</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
                double totale = 0;
                if(carrello != null && !carrello.isEmpty()) {
                    for(int i = 0; i < carrello.size(); i++) { 
                        Prodotto p = carrello.get(i);
                        totale += p.getPrezzoScontato();
            %>
                <tr>
                    <td><%= p.getNomeProdotto() %></td>
                    <td>€ <%= String.format("%.2f", p.getPrezzoScontato()) %></td>
                    <td class="text-center">
                        <a href="${pageContext.request.contextPath}/RimuoviServlet?index=<%= i %>" class="btn btn-danger btn-sm">❌</a>
                    </td>
                </tr>
            <%      } 
                } else { %>
                <tr>
                    <td colspan="3" class="text-center">Il carrello è vuoto.</td>
                </tr>
            <% } %>
        </tbody>
    </table>
    
    <div class="d-flex justify-content-between align-items-center mt-4">
        <h4>Totale: € <%= String.format("%.2f", totale) %></h4>
        <div>
<a href="${pageContext.request.contextPath}/#" class="btn btn-outline-light">Continua a pescare</a>
            <button class="btn btn-primary">Procedi all'acquisto</button>
        </div>
    </div>
</div>

</body>
</html>