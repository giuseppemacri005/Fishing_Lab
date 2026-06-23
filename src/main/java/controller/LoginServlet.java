package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Recuperiamo i dati inseriti nel form della JSP
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Dati di connessione al vostro DB locale (modificate se avete credenziali diverse)
        String dbUrl = "jdbc:mysql://localhost:3306/fishing_lab_db?useSSL=false&serverTimezone=UTC";
        String dbUser = "root";
        String dbPass = "root"; // Mettete la vostra password di MySQL locale
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // Carichiamo il driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            
            // Query per verificare se esiste l'utente con quella email e password
            String sql = "SELECT * FROM utente WHERE email = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // LOGIN SUCCESSO: L'utente esiste!
                // Creiamo la sessione e salviamo il nome dell'utente
                HttpSession session = request.getSession();
                session.setAttribute("utenteNome", rs.getString("nome"));
                session.setAttribute("utenteRuolo", rs.getString("ruolo"));
                session.setAttribute("utenteEmail", rs.getString("email"));
                
                // Reindirizziamo l'utente alla home page (index.jsp)
                response.sendRedirect("index.jsp");
            } else {
                // LOGIN FALLITO: Credenziali errate
                request.setAttribute("errore", "Email o Password errate!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore del server durante il login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            // Chiudiamo le risorse del DB
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Se qualcuno prova ad accedere via GET, lo rimandiamo semplicemente al form
        response.sendRedirect("login.jsp");
    }
}