<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fishing Lab - Pannello Admin (Dinamico)</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; color: #333; padding: 20px; }
        .container { max-width: 650px; background: #fff; margin: 0 auto; padding: 30px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        h2 { color: #0288d1; border-bottom: 2px solid #e1f5fe; padding-bottom: 10px; margin-top: 0; }
        h3 { color: #f57c00; margin-top: 25px; border-bottom: 1px solid #fff3e0; padding-bottom: 5px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: 600; font-size: 14px; }
        input[type="text"], input[type="number"], select, textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 14px; }
        textarea { resize: vertical; height: 80px; }
        .row { display: flex; gap: 15px; }
        .row .form-group { flex: 1; }
        button { background-color: #2e7d32; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; font-weight: bold; width: 100%; margin-top: 20px; transition: background 0.3s; }
        button:hover { background-color: #1b5e20; }
    </style>
</head>
<body>

<div class="container">
    <h2>Pannello Amministratore - Fishing Lab</h2>
    <p>Inserisci un nuovo prodotto. I menu Brand e Categoria sono sincronizzati in tempo reale con il database.</p>
    
    <form action="AggiungiProdottoServlet" method="POST">
        
        <h3>1. Informazioni Generali Prodotto</h3>
        
        <div class="form-group">
            <label for="nome">Nome Prodotto:</label>
            <input type="text" id="nome" name="nomeProdotto" required>
        </div>

        <div class="form-group">
            <label for="descrizione">Descrizione:</label>
            <textarea id="descrizione" name="descrizione"></textarea>
        </div>

        <div class="row">
            <div class="form-group">
                <label for="prezzoOrig">Prezzo Originale (€):</label>
                <input type="number" id="prezzoOrig" name="prezzoOriginale" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label for="prezzoScont">Prezzo Scontato (€):</label>
                <input type="number" id="prezzoScont" name="prezzoScontato" step="0.01" min="0">
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label for="brand">Brand / Marca:</label>
                <select id="brand" name="idBrand" required>
                    <option value="">-- Seleziona Marchio --</option>
                    <%
                        // Connessione diretta al database locale XAMPP
                        String url = "jdbc:mysql://localhost:3306/fishing_lab_db";
                        String user = "root";
                        String password = ""; // Di default su XAMPP è vuota
                        
                        Connection conn = null;
                        Statement stmtBrand = null;
                        ResultSet rsBrand = null;
                        
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(url, user, password);
                            
                            stmtBrand = conn.createStatement();
                            rsBrand = stmtBrand.executeQuery("SELECT ID_Brand, Nome_Brand FROM BRAND ORDER BY Nome_Brand ASC");
                            
                            while(rsBrand.next()) {
                    %>
                                <option value="<%= rsBrand.getInt("ID_Brand") %>"><%= rsBrand.getString("Nome_Brand") %></option>
                    <%
                            }
                        } catch(Exception e) {
                            out.println("<option value=''>Errore caricamento brand</option>");
                        } finally {
                            if(rsBrand != null) rsBrand.close();
                            if(stmtBrand != null) stmtBrand.close();
                        }
                    %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="categoria">Categoria:</label>
                <select id="categoria" name="idCategoria" required>
                    <option value="">-- Seleziona Categoria --</option>
                    <%
                        Statement stmtCat = null;
                        ResultSet rsCat = null;
                        try {
                            stmtCat = conn.createStatement();
                            rsCat = stmtCat.executeQuery("SELECT ID_Categoria, Nome_Categoria FROM CATEGORIA ORDER BY Nome_Categoria ASC");
                            
                            while(rsCat.next()) {
                    %>
                                <option value="<%= rsCat.getInt("ID_Categoria") %>"><%= rsCat.getString("Nome_Categoria") %></option>
                    <%
                            }
                        } catch(Exception e) {
                            out.println("<option value=''>Errore caricamento categorie</option>");
                        } finally {
                            if(rsCat != null) rsCat.close();
                            if(stmtCat != null) stmtCat.close();
                            if(conn != null) conn.close(); // Chiudiamo la connessione generale alla fine della pagina
                        }
                    %>
                </select>
            </div>
        </div>

        <div class="form-group" style="width: 48%;">
            <label for="anno">Anno di Prodotzione:</label>
            <input type="number" id="anno" name="annoProduzione" min="2020" max="2030" value="2026">
        </div>

        <h3>2. Dettagli Variante e Magazzino</h3>
        
        <div class="row">
            <div class="form-group">
                <label for="colore">Colore / Estetica:</label>
                <input type="text" id="colore" name="colore" required>
            </div>
            <div class="form-group">
                <label for="taglia">Misura / Taglia / Azione:</label>
                <input type="text" id="taglia" name="misuraTaglia" required>
            </div>
        </div>

        <div class="form-group" style="width: 48%;">
            <label for="stock">Quantità in Stock:</label>
            <input type="number" id="stock" name="stockDisponibile" min="0" value="5" required>
        </div>

        <button type="submit">Salva Articolo nel Database</button>
    </form>
</div>

</body>
</html>