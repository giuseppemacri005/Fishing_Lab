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
        String dbPass = "Sonogiuseppe2005."; // Mettete la vostra password di MySQL locale
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        
        try {
            // Registrazione esplicita del driver (quella che ha sbloccato la connessione)
            java.sql.Driver driver = new com.mysql.cj.jdbc.Driver();
            java.sql.DriverManager.registerDriver(driver);
            
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            
            // Query pulita
            String sql = "SELECT email, ruolo FROM utente WHERE email = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // LOGIN COINCIDE -> Salviamo i dati in sessione
                HttpSession session = request.getSession();
                
                // Usiamo l'estrazione sicura tramite stringa
                session.setAttribute("utenteEmail", rs.getString("email"));
                session.setAttribute("utenteRuolo", rs.getString("ruolo"));
                
                // Mandiamo alla index dentro WEB-INF (usando il forward funzionante)
                request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
                return; // Interrompe il metodo ed evita che il codice sotto interferisca
                
            } else {
                // Credenziali sbagliate
                request.setAttribute("errore", "Email o Password errate!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
        } catch (Exception e) {
            // Questo ti stamperà in rosso l'esatto motivo per cui "sembra disconnettersi"
            System.out.println("❌ ERRORE DURANTE LA QUERY/FORWARD:");
            e.printStackTrace(); 
            
            request.setAttribute("errore", "Errore interno: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            // La connessione DEVE chiudersi solo qui, alla fine di tutto il processo
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