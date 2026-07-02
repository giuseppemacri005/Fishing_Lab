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
    <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">← Torna allo Store</a>
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
// Questa funzione riempie la tabella usando le chiavi minuscole (p.nome e p.id)
function caricaProdotti() {
    fetch('${pageContext.request.contextPath}/GestioneProdottiServlet?action=list')
    .then(res => res.json())
    .then(data => {
        const body = document.getElementById('admin-prodotti-body');
        body.innerHTML = data.map(p => `
            <tr style="border-bottom: 1px solid #1c2d3d;">
                <td style="padding:10px;">${p.nome}</td>
                <td style="padding:10px; text-align: right;">
                    <button onclick="elimina(${p.id})" style="color:#ff5252; background:none; border:none; cursor:pointer; font-weight:bold;">Elimina</button>
                </td>
            </tr>
        `).join('');
    })
    .catch(err => console.error("Errore caricamento prodotti:", err));
}

// Chiamata per eliminare
function elimina(id) {
    if(confirm('Sei sicuro di voler eliminare questo prodotto?')) {
        // Usiamo la action=delete e passiamo l'id
        fetch('${pageContext.request.contextPath}/GestioneProdottiServlet?action=delete&id=' + id, { method: 'POST' })
        .then(() => caricaProdotti());
    }
}

// Gestione invio form
document.getElementById('adminForm').addEventListener('submit', function(e) {
    e.preventDefault();
    fetch('${pageContext.request.contextPath}/GestioneProdottiServlet', { 
        method: 'POST', 
        body: new URLSearchParams(new FormData(this)) 
    })
    .then(() => { 
        this.reset(); 
        caricaProdotti(); 
    });
});

// Caricamento iniziale
caricaProdotti();
</script>
</body>
</html>