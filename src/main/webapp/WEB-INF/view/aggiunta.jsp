<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/Admin.css">
</head>
<body>

<div class="admin-container">
    <a href="${pageContext.request.contextPath}/home" class="back-link">← Torna allo Store</a>
    <h2>Gestione <span>Prodotti</span></h2>

    <form id="adminForm" style="margin-bottom: 40px;">
        <input type="hidden" name="action" value="add">
        <div class="form-group"><label>Nome</label> <input type="text" name="nome" required></div>
        <div class="form-group"><label>Descrizione</label> <textarea name="descrizione" required></textarea></div>
        <div class="form-row">
            <div class="form-group"><label>Prezzo</label> <input type="number" name="prezzo" step="0.01" required></div>
        </div>
        <div class="form-group"><label>Immagine</label> <input type="text" name="immagine" required></div>
        <button type="submit" class="btn-submit">Carica Prodotto</button>
    </form>

    <hr style="border: 0; border-top: 1px solid #1c2d3d; margin: 20px 0;">

    <h3 style="color: white; margin-bottom: 15px;">Lista Prodotti</h3>
    <table style="width: 100%; color: white; border-collapse: collapse;">
        <thead>
            <tr style="color: #8a9cae; border-bottom: 1px solid #1c2d3d;">
                <th style="padding:10px; text-align: left;">Nome Prodotto</th>
                <th style="padding:10px; text-align: right;">Azioni</th>
            </tr>
        </thead>
        <tbody id="admin-prodotti-body">
            </tbody>
    </table>
</div>

<script>
function caricaProdotti() {
    fetch('${pageContext.request.contextPath}/GestioneProdottiServlet?action=list')
    .then(function(res) {
        return res.json();
    })
    .then(function(data) {
        console.log("Dati ricevuti:", data);
        var body = document.getElementById('admin-prodotti-body');
        var html = '';
        
        data.forEach(function(p) {
            html += '<tr style="border-bottom: 1px solid #1c2d3d;">';
            html += '<td style="padding:10px; color: white;">' + p.nome + '</td>';
            html += '<td style="padding:10px; text-align: right;">';
            html += '<button onclick="elimina(' + p.id + ')" style="color:#ff5252; background:none; border:none; cursor:pointer; font-weight:bold;">Elimina</button>';
            html += '</td></tr>';
        });
        
        body.innerHTML = html;
    })
    .catch(function(err) {
        console.error("Errore nel caricamento:", err);
    });
}

function elimina(id) {
    if(confirm('Sei sicuro di voler eliminare questo prodotto?')) {
        fetch('${pageContext.request.contextPath}/GestioneProdottiServlet?action=delete&id=' + id, { method: 'POST' })
        .then(function() { caricaProdotti(); });
    }
}

document.getElementById('adminForm').addEventListener('submit', function(e) {
    e.preventDefault();
    fetch('${pageContext.request.contextPath}/GestioneProdottiServlet', { 
        method: 'POST', 
        body: new URLSearchParams(new FormData(this)) 
    })
    .then(function() { 
        document.getElementById('adminForm').reset(); 
        caricaProdotti(); 
    });
});

caricaProdotti();
</script>
</body>
</html>