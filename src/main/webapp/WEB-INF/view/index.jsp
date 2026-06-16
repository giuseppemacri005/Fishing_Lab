<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fishing_Lab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css?v=2" rel="stylesheet">
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top" style="border-bottom: 3px solid #0d6efd;">
        <div class="container">
         
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link mx-2" href="HomeServlet"><i class="fa-solid fa-house me-1"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link position-relative mx-3" href="CarrelloServlet">
                            <i class="fa-solid fa-cart-shopping me-1"></i> Carrello
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-light btn-sm fw-bold px-3 ms-2" href="login.jsp">
                            <i class="fa-solid fa-user me-1"></i> Accedi
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <div class="border-bottom pb-2 mb-4">
            <h2 class="fw-bold text-uppercase m-0" style="color: #212529; font-size: 1.6rem;">
                <i class="fa-solid fa-boxes-stacked text-primary me-2"></i>Nostri Prodotti
            </h2>
        </div>
        
        <div class="row g-3">
            <% 
                List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
                if (prodotti != null && !prodotti.isEmpty()) {
                    for (Prodotto p : prodotti) {
            %>
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="card h-100 p-3 shadow-sm" style="border: 1px solid #e1e8ed; border-radius: 8px; position: relative;">
                            
                            <% 
                                if(p.getPrezzoOriginale() > p.getPrezzoScontato()) { 
                                    int scontoPercentuale = (int) Math.round(((p.getPrezzoOriginale() - p.getPrezzoScontato()) / p.getPrezzoOriginale()) * 100);
                            %>
                                    <div class="position-absolute badge bg-danger text-white fw-bold uppercase" style="top: 10px; left: 10px; z-index: 2; padding: 5px 10px; border-radius: 4px; font-size: 0.75rem;">
                                        -<%= scontoPercentuale %>%
                                    </div>
                            <%  } %>
                            
                           <div class="product-img-container rounded" style="height: 180px; display: flex; align-items: center; justify-content: center; background-color: #fff; overflow: hidden; padding: 10px; border-bottom: 1px solid #f0f0f0;">
                                <% 
                                    String nomeImmagine = p.getImmagine();
                                    String altTesto = p.getNomeProdotto();
                                    
                                    if (nomeImmagine != null && !nomeImmagine.trim().isEmpty()) {
                                        out.print("<img src=\"images/" + nomeImmagine + "\" alt=\"" + altTesto + "\" class=\"product-img\" style=\"max-width: 100%; max-height: 100%; width: auto; height: auto; object-fit: contain;\" onerror=\"this.onerror=null; this.src='https://via.placeholder.com/200x200.png?text=No+Image';\">");
                                    } else {
                                        out.print("<img src=\"https://via.placeholder.com/200x200.png?text=No+Image\" class=\"product-img\" style=\"max-width: 100%; max-height: 100%; width: auto; height: auto; object-fit: contain;\" alt=\"No image\">");
                                    }
                                %>
                            </div>
                            
                            <div class="mt-2">
                                <span class="badge bg-light text-secondary border fw-bold text-uppercase" style="font-size: 0.7rem; padding: 4px 8px;"><%= p.getNomeBrand() %></span>
                            </div>
                            
                            <h3 class="card-title fw-bold text-dark mt-2 text-truncate-2" style="font-size: 0.95rem; height: 42px; overflow: hidden;" title="<%= p.getNomeProdotto() %>">
                                <%= p.getNomeProdotto() %>
                            </h3>
                            
                            <div class="p-2 rounded my-2" style="background-color: #f8f9fa; margin-top: auto;">
                                <% if(p.getPrezzoOriginale() > p.getPrezzoScontato()) { %>
                                    <span class="text-muted text-decoration-line-through d-block" style="font-size: 0.8rem;">
                                        Prezzo: €<%= String.format("%.2f", p.getPrezzoOriginale()) %>
                                    </span>
                                <% } else { %>
                                    <span class="text-muted d-block" style="font-size: 0.8rem; visibility: hidden;">Prezzo: €0.00</span>
                                <% } %>
                                <span class="text-dark fw-bold d-inline-block" style="font-size: 1.3rem;">
                                    €<%= String.format("%.2f", p.getPrezzoScontato()) %>
                                </span>
                            </div>
                            
                            <button class="btn btn-primary w-100 fw-bold text-uppercase mt-1" style="font-size: 0.85rem; padding: 8px;">
                                <i class="fa-solid fa-cart-plus me-1"></i> Aggiungi
                            </button>
                        </div>
                    </div>
            <% 
                    }
                } else { 
            %>
                <div class="col-12 text-center my-5">
                    <div class="alert alert-secondary py-4" role="alert">
                        <i class="fa-solid fa-circle-exclamation fs-3 mb-2 text-secondary"></i>
                        <h4 class="alert-heading fw-bold">Nessun prodotto disponibile</h4>
                        <p class="mb-0 text-muted">Controlla la connessione al database MySQL o verifica che la tabella PRODOTTO non sia vuota.</p>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>